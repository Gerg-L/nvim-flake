{
  description = "My forth version on turning my neovim configuration in to a flake";
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    neovim-src = {
      url = "github:neovim/neovim/?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    neovim-src,
    ...
  }:
    {
      overlay = self.overlays.default;
      overlays.default = _: final: {
        neovim = self.packages.${final.system}.default;
      };
    }
    // flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
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
