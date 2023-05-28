{
  wrapNeovimUnstable,
  neovimUtils,
  lib,
  writeText,
  #neovim package
  neovim-unwrapped,
  package ? neovim-unwrapped,
  extraPackages ? [],
  plugins ? [],
}: let
  neovimConfig = neovimUtils.makeNeovimConfig {
    inherit plugins;
    withPython3 = true;
    extraPython3Packages = _: [];
    withRuby = true;
    viAlias = false;
    vimAlias = false;
    customRC = "luafile ${writeText "init.lua" (import ./lua)}";
  };

  wrapperArgs =
    neovimConfig.wrapperArgs
    ++ ["--suffix" "PATH" ":" "${lib.makeBinPath extraPackages}"];
in
  wrapNeovimUnstable package (neovimConfig
    // {inherit wrapperArgs;})
