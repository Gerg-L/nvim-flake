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
    mnw = {
      type = "github";
      owner = "gerg-l";
      repo = "mnw";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      neovim-nightly,
      mnw,
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

          neovim = mnw.lib.wrap pkgs {
            inherit (neovim-nightly.packages.${system}) neovim;

            wrapperArgs = [
              "--set-default"
              "FZF_DEFAULT_OPTS"
              "--layout=reverse --inline-info"
            ];

            appName = "gerg";

            extraLuaPackages = p: [ p.jsregexp ];

            withNodeJs = true;
            withPerl = true;

            plugins = [
              (pkgs.buildNpmPackage {
                name = "nvim-asciidoc";
                src = pkgs.fetchFromGitHub {
                owner = "tigion";
                repo = "nvim-asciidoc-preview";
                rev = "06b13166ec0aaa5ae59531bc5c38017171323947";
                hash = "sha256-6v5DsgCDbpAOHFaNk1i/j5KzO0NFCkIwDpT0Dezceao=";
              };
              postPatch = ''
                pushd server
              '';
              npmDepsHash = "sha256-HGEuBpMkupoLMkqrNo1tw989dVzrIiZf5OJCMo4FOgU=";
              dontNpmBuild = true;
              installPhase = ''
                runHook preInstall

                popd
                cp -r . $out/

                runHook postInstall
              '';
              })
                #
                # Add your lua config as a "plugin"
                #
                ./gerg
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
