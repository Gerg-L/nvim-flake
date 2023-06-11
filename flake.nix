{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-src = {
      url = "github:neovim/neovim";
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

      overlay = final: _: lib.filterAttrs (n: _: n == "default") self.packages.${final.system};

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
