{
  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };
    neovim-nightly = {
      type = "github";
      owner = "nix-community";
      repo = "neovim-nightly-overlay";
    };
    flake-compat = {
      type = "github";
      owner = "edolstra";
      repo = "flake-compat";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      neovim-nightly,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      #
      # Funni helper function
      #
      gerg-utils =
        x:
        lib.foldAttrs lib.mergeAttrs { } (
          map
            (
              s:
              builtins.mapAttrs (
                _: v:
                if lib.isFunction v then
                  {
                    ${s} = v {
                      pkgs = nixpkgs.legacyPackages.${s};
                      system = s;
                    };
                  }
                else
                  v
              ) x
            )
            [
              "x86_64-linux"
              "x86_64-darwin"
              "aarch64-linux"
              "aarch64-darwin"
            ]
        );
    in
    gerg-utils {
      #
      # Linter and formatter, run with "nix fmt"
      # You can use alejandra or nixpkgs-fmt instead of nixfmt if you wish
      #
      formatter =
        { pkgs, ... }:
        pkgs.writeShellApplication {
          name = "lint";
          runtimeInputs = builtins.attrValues {
            inherit (pkgs)
              nixfmt-rfc-style
              deadnix
              statix
              fd
              stylua
              ;
          };
          text = ''
            fd '.*\.nix' . -x statix fix -- {} \;
            fd '.*\.nix' . -X deadnix -e -- {} \; -X nixfmt {} \;
            fd '.*\.lua' . -X stylua --indent-type Spaces --indent-width 2 {} \;
          '';
        };

      packages =
        { pkgs, system }:
        {
          default = self.packages.${system}.neovim;

          neovim =
            (pkgs.wrapNeovimUnstable neovim-nightly.packages.${system}.neovim (
              pkgs.neovimUtils.makeNeovimConfig {
                wrapRc = false;
                extraLuaPackages = p: [ p.jsregexp ];
                plugins =
                  [
                    #
                    # Package your lua config as a plugin
                    #
                    (pkgs.vimUtils.buildVimPlugin {
                      pname = "gerg";
                      version = self.shortRev or self.dirtyShortRev or "dirty";
                      src = "${self}/gerg";
                    })

                    #
                    # Add plugins from nixpkgs here
                    #
                    pkgs.vimPlugins.nvim-treesitter.withAllGrammars
                  ]
                  ++ lib.mapAttrsToList (
                    #
                    # This generates plugins from npins sources
                    #
                    pname: pin:
                    (pkgs.vimUtils.buildVimPlugin {
                      inherit pname;
                      src = pkgs.npins.mkSource pin;
                      version = builtins.substring 0 8 pin.revision;
                    })
                  ) (lib.importJSON "${self}/sources.json").pins;
              }
            )).overrideAttrs
              (old: {
                generatedWrapperArgs = old.generatedWrapperArgs or [ ] ++ [
                  "--prefix"
                  "PATH"
                  ":"
                  (lib.makeBinPath (
                    builtins.attrValues {

                      #
                      # Runtime dependencies
                      #
                      inherit (pkgs)
                        deadnix
                        statix
                        nil

                        lua-language-server
                        stylua

                        #rustfmt

                        ripgrep
                        fd
                        chafa
                        ;
                    }
                  ))
                  "--set"
                  "NVIM_APPNAME"
                  "gerg"
                  "--add-flags"
                  "-u NORC"
                  "--set-default"
                  "FZF_DEFAULT_OPTS"
                  "--layout=reverse --inline-info"
                ];
              });
        };
    };
}
