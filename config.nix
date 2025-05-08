{
  lib,
  inputs,
  pkgs,
  ...
}:
{
  inherit (inputs.neovim-nightly.packages.${pkgs.stdenv.system}) neovim;

  appName = "gerg";

  extraLuaPackages = p: [ p.jsregexp ];

  providers = {
    nodeJs.enable = true;
    perl.enable = true;
  };

  # Source lua config
  initLua = ''
    require('gerg')
  '';

  desktopEntry = false;

  plugins = {
    dev.gerg = {
      pure = ./gerg;
      impure = "/home/gerg/Projects/nvim-flake/gerg";
    };

    start =
      [
        #
        # Add plugins from nixpkgs here
        #
        inputs.self.packages.${pkgs.stdenv.system}.blink-cmp
        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
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
  };

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

}
