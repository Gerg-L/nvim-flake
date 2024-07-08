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
    neovim-wrapper = {
      type = "github";
      owner = "gerg-l";
      repo = "neovim-wrapper";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      neovim-nightly,
      neovim-wrapper,
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

          neovim = neovim-wrapper.legacyPackages.${system}.neovimWrapper {
            inherit (neovim-nightly.packages.${system}) neovim;

            wrapperArgs = [
              "--set-default"
              "FZF_DEFAULT_OPTS"
              "--layout=reverse --inline-info"
            ];

            appName = "gerg";

            luaFiles = [
              (builtins.toFile "init.lua" ''
                print('loaded lua file')
              '')
            ];
            initLua = "print('loaded lua text')";

            vimlFiles = [
              (builtins.toFile "init.vim" ''
                echomsg 'loaded vim file'
              '')
            ];
            initViml = "echomsg 'loaded vim text'";

            extraLuaPackages = p: [ p.jsregexp ];

            withNodeJs = true;
            withPerl = true;
            loadDefaultRC = false;

            plugins =
              [
                #
                # Package your lua config as a plugin
                #
                {
                  pname = "gerg";
                  version = self.shortRev or self.dirtyShortRev or "dirty";
                  outPath = "${self}/gerg";
                }
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
                (
                  (pkgs.npins.mkSource pin)
                  // {
                    inherit pname;
                    version = builtins.substring 0 8 pin.revision;
                  }
                )
              ) (lib.importJSON "${self}/sources.json").pins;

            extraBinPath = builtins.attrValues {

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
            };
          };
        };
    };
}
