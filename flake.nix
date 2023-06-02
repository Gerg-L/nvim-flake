{
  description = "My forth version on turning my neovim configuration in to a flake";
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
      lib.foldAttrs lib.mergeAttrs {}
      (map (s: lib.mapAttrs (_: v: {${s} = v;}) (f s))
        ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"]);
  in
    {
      overlay = final: _: {
        inherit (self.packages.${final.system}) neovim;
      };
    }
    // withSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      formatter = pkgs.alejandra;

      packages = {
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

      devShells.default = pkgs.mkShell {
        packages = [
          self.packages.${system}.neovim
          pkgs.nvfetcher
        ];
      };
    });
}
