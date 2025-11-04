{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  inherit (inputs.neovim-nightly.packages.${pkgs.stdenv.system}) neovim;

  appName = "gerg";

  extraLuaPackages = p: [ p.jsregexp ];

  providers = {
    ruby.enable = true;
    python3.enable = true;
    nodeJs.enable = true;
    perl.enable = true;
  };

  # Source lua config
  initLua = ''
    require("gerg")
    LZN = require("lz.n")
    LZN.register_handler(require("handlers.which-key"))
    LZN.load("lazy")
  '';

  desktopEntry = false;
  plugins = {
    dev.gerg = {
      pure =
        let
          fs = lib.fileset;
        in
        fs.toSource {
          root = ./.;
          fileset = fs.unions [
            ./lua
            ./after
          ];
        };
      impure = "~/Projects/nvim-flake";
    };

    start = inputs.mnw.lib.npinsToPlugins pkgs ./start.json;

    opt = [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      inputs.self.packages.${pkgs.stdenv.system}.blink-cmp
    ]
    ++ inputs.mnw.lib.npinsToPlugins pkgs ./opt.json;
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
