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
      rev = "1329ddcc318e77e4629eb629d39f7f7c9b2632f6";
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
    systems = {
      type = "github";
      owner = "nix-systems";
      repo = "default";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      neovim-nightly,
      mnw,
      systems,
      ...
    }:
    let
      eachSystem = nixpkgs.lib.genAttrs (import systems);
      inherit (nixpkgs) lib;
    in
    {
      #
      # Linter and formatter, run with "nix fmt"
      # You can use alejandra or nixpkgs-fmt instead of nixfmt if you wish
      #
      formatter = eachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
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
        }
      );

      devShells = eachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShellNoCC {
            packages = [
              self.packages.${system}.default.devMode
              self.formatter.${system}
              pkgs.npins
            ];
          };
        }
      );

      packages = eachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = self.packages.${system}.neovim;

          neovim = mnw.lib.wrap pkgs {
            inherit (neovim-nightly.packages.${system}) neovim;

            appName = "gerg";

            extraLuaPackages = p: [ p.jsregexp ];

            withNodeJs = true;
            withPerl = true;

            # Source lua config
            initLua = ''
              require('gerg')
            '';

            # Add lua config
            devExcludedPlugins = [
              ./gerg
            ];
            # Impure path to lua config for devShell
            devPluginPaths = [
              "/home/gerg/Projects/nvim-flake/gerg"
            ];

            desktopEntry = false;

            plugins =
              [
                #
                # Add plugins from nixpkgs here
                #
                pkgs.vimPlugins.nvim-treesitter.withAllGrammars
                pkgs.vimPlugins.blink-cmp
              ]
              ++ lib.mapAttrsToList (
                #
                # This generates plugins from npins sources
                #
                pname: pin:
                (
                  pin
                  // {
                    inherit pname;
                    version = builtins.substring 0 8 pin.revision;
                  }

                )
              ) (pkgs.callPackages ./npins/sources.nix { });

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
                vscode-langservers-extracted
                ;
            };
          };
        }
      );
    };
}
