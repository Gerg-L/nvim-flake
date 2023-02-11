{
  wrapNeovimUnstable,
  neovimUtils,
  lib,
  writeText,
  # sorry about using this but I want to only specify LSPs once
  plugins ? [],
  extraPackages ? [],
  neovim-unwrapped,
  unwrappedTarget ? neovim-unwrapped,
  extraLuaPackages ? (_: []),
  extraPython3Packages ? (_: []),
  withPython3 ? true,
  withRuby ? false,
  ...
}: let
  luaFile = writeText "init.lua" (import ./lua);

  vimConfig = ''luafile ${luaFile}'';

  binPath = lib.makeBinPath extraPackages;

  neovimConfig = neovimUtils.makeNeovimConfig {
    inherit plugins extraPython3Packages withPython3 withRuby;
    viAlias = false;
    vimAlias = false;
    customRC = vimConfig;
  };

  # this bit is stolen from https://github.com/nix-community/home-manager/blob/master/modules/programs/neovim.nix
  luaPackages = unwrappedTarget.lua.pkgs;
  resolvedExtraLuaPackages = extraLuaPackages luaPackages;

  makeWrapperArgsFromPackages = op:
    lib.lists.foldr
    (next: prev: prev ++ [";" (op next)]) []
    resolvedExtraLuaPackages;

  extraMakeWrapperLuaCArgs =
    lib.optionals (resolvedExtraLuaPackages != [])
    (["--suffix" "LUA_CPATH" ";"]
      ++ (makeWrapperArgsFromPackages luaPackages.getLuaCPath));
  extraMakeWrapperLuaArgs =
    lib.optionals (resolvedExtraLuaPackages != [])
    (["--suffix" "LUA_PATH" ";"]
      ++ (makeWrapperArgsFromPackages luaPackages.getLuaPath));

  wrapperArgs =
    neovimConfig.wrapperArgs
    ++ extraMakeWrapperLuaArgs
    ++ extraMakeWrapperLuaCArgs
    ++ ["--suffix" "PATH" ":" "${binPath}"];
in
  wrapNeovimUnstable unwrappedTarget (neovimConfig
    // {inherit wrapperArgs;})
