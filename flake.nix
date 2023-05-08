{
  description = "My forth version on turning my neovim configuration in to a flake";
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    neovim-src = {
      url = "github:neovim/neovim/?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
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
      overlay = _: final: {
        neovim = self.packages.${final.system}.default;
      };
    }
    // withSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      formatter = pkgs.alejandra;

      packages.default = pkgs.callPackage ./wrapper.nix {
        unwrappedTarget = neovim-src.packages.${system}.default;
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
      };

      devShells.default = pkgs.mkShell {
        packages = [
          self.packages.${system}.default
          pkgs.nvfetcher
        ];
      };
    });
}
