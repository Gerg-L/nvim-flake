{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-src = {
      url = "github:neovim/neovim/d7bb19e0138c7363ed40c142972c07e4e1912785";
      flake = false;
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    neovim-src,
    ...
  }: let
    inherit (nixpkgs) lib;
    withSystem = f:
      lib.fold lib.recursiveUpdate {}
      (map (s: f s) ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"]);
  in
    withSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      formatter.${system} = pkgs.alejandra;

      overlays.default = final: _: removeAttrs self.packages.${final.system} ["default"];
      overlay = self.overlays.default;

      packages.${system} = {
        neovim = pkgs.callPackage ./wrapper.nix {
          package = pkgs.neovim-unwrapped.overrideAttrs (_: let
            version = neovim-src.shortRev or "dirty";
          in {
            src = neovim-src;
            inherit version;
            patches = [];
            preConfigure = ''
              sed -i cmake.config/versiondef.h.in -e 's/@NVIM_VERSION_PRERELEASE@/-dev-${version}/'
            '';
          });
          extraPackages = builtins.attrValues {
            inherit
              (pkgs)
              #rust
              
              rustfmt
              #nix
              
              deadnix
              statix
              alejandra
              nil
              #other
              
              ripgrep
              fd
              ;
          };
          plugins =
            (lib.mapAttrsToList (
                _: value: (
                  pkgs.vimUtils.buildVimPluginFrom2Nix
                  {
                    inherit (value) name date version;
                    src = pkgs.fetchgit {
                      inherit (value.src) url rev sha256;
                    };
                  }
                )
              )
              (lib.importJSON ./plugins/_sources/generated.json))
            ++ [pkgs.vimPlugins.nvim-treesitter.withAllGrammars];
        };
        default = self.packages.${system}.neovim;
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = [
          self.packages.${system}.default
          pkgs.nvfetcher
        ];
      };
    });
}
