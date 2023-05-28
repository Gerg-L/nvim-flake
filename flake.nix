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
    lib = nixpkgs.lib;
    withSystem = f:
      lib.foldAttrs lib.mergeAttrs {}
      (map (s: lib.mapAttrs (_: v: {${s} = v;}) (f s))
        ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"]);
  in
    {
      overlay = _: final: self.packages.${final.system};
    }
    // withSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      formatter = pkgs.alejandra;

      packages.neovim = pkgs.callPackage ./wrapper.nix {
        package = pkgs.neovim-unwrapped.overrideAttrs (_: {
          src = neovim-src;
          patches = [];
        });
        extraPackages = [
          #rust
          pkgs.rustfmt
          #nix
          pkgs.deadnix
          pkgs.statix
          pkgs.alejandra
          pkgs.nil

          #other
          pkgs.ripgrep
          pkgs.fd
        ];
        plugins =
          (lib.mapAttrsToList (
              _: value: (
                pkgs.vimUtils.buildVimPluginFrom2Nix {
                  inherit (value) name version date;
                  src = pkgs.fetchgit {
                    inherit (value.src) url rev sha256;
                  };
                }
              )
            )
            (lib.importJSON ./plugins/_sources/generated.json))
          ++ [pkgs.vimPlugins.nvim-treesitter.withAllGrammars];
      };

      devShells.default = pkgs.mkShell {
        packages = [
          self.packages.${system}.neovim
          pkgs.nvfetcher
        ];
      };
    });
}
