{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    neovim-src = {
      url = "github:neovim/neovim/a7788c2e251089b4844aac0e6633998bdb017da1";
      flake = false;
    };
    nixfmt = {
      url = "github:piegamesde/nixfmt?ref=rfc101-style";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      neovim-src,
      nixfmt,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      #
      # Funni helper function
      #
      withSystem =
        f:
        lib.fold lib.recursiveUpdate { } (
          map f [
            "x86_64-linux"
            "x86_64-darwin"
            "aarch64-linux"
            "aarch64-darwin"
          ]
        );
    in
    withSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        #
        # Linter and formatter, run with "nix fmt"
        # You can use alejandra or nixpkgs-fmt instead of nixfmt if you wish
        #
        formatter.${system} = pkgs.writeShellApplication {
          name = "lint";
          runtimeInputs = [
            (pkgs.nixfmt.overrideAttrs {
              version = "0.6.0-${nixfmt.shortRev}";

              src = nixfmt;
            })
            pkgs.deadnix
            pkgs.statix
            pkgs.fd
            pkgs.stylua
          ];
          text = ''
            fd '.*\.nix' . -x statix fix -- {} \;
            fd '.*\.nix' . -X deadnix -e -- {} \; -X nixfmt {} \;
            fd '.*\.lua' . -X stylua --indent-type Spaces --indent-width 2 {} \;
          '';
        };

        packages.${system} = {
          default = self.packages.${system}.neovim;

          neovim =
            (pkgs.wrapNeovimUnstable
              (pkgs.neovim-unwrapped.overrideAttrs {
                #
                # Use neovim nightly
                #
                src = neovim-src;
                version = neovim-src.shortRev or "dirty";
                patches = [ ];
                preConfigure = ''
                  sed -i cmake.config/versiondef.h.in -e "s/@NVIM_VERSION_PRERELEASE@/-dev-$version/"
                '';
              })
              (
                pkgs.neovimUtils.makeNeovimConfig {
                  plugins =
                    [
                      #
                      # Add plugins from nixpkgs here
                      #
                      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
                    ]
                    ++ lib.mapAttrsToList (
                      #
                      # This generates plugins from npins sources
                      #
                      name: src: (pkgs.vimUtils.buildVimPlugin { inherit name src; })
                    ) (import ./npins);
                  #
                  # Use the string generated in ./lua/default.nix for init.vim
                  #
                  customRC = import ./lua { inherit lib self; };
                }
              )
            ).overrideAttrs
              (old: {
                generatedWrapperArgs = old.generatedWrapperArgs or [ ] ++ [
                  "--prefix"
                  "PATH"
                  ":"
                  (lib.makeBinPath [
                    #
                    # Runtime dependencies
                    #
                    pkgs.deadnix
                    pkgs.statix
                    pkgs.nil
                    pkgs.ripgrep
                    pkgs.fd
                    pkgs.lua-language-server
                    pkgs.stylua
                  ])
                ];
              });
        };
      }
    );
}
