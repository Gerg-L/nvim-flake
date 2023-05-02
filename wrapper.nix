{
  wrapNeovimUnstable,
  neovimUtils,
  lib,
  writeText,
  vimPlugins,
  vimUtils,
  #neovim package
  neovim-unwrapped,
  unwrappedTarget ? neovim-unwrapped,
  extraPackages ? [],
  fetchgit,
}: let
  neovimConfig = neovimUtils.makeNeovimConfig {
    withPython3 = true;
    extraPython3Packages = _: [];
    withRuby = true;
    plugins =
      (lib.mapAttrsToList (
          _: value: (
            vimUtils.buildVimPluginFrom2Nix {
              inherit (value) name version date;
              src = fetchgit {
                inherit (value.src) url rev sha256;
              };
            }
          )
        )
        (lib.importJSON ./plugins/_sources/generated.json))
      ++ [vimPlugins.nvim-treesitter.withAllGrammars];
    viAlias = false;
    vimAlias = false;
    customRC = "luafile ${writeText "init.lua" (import ./lua)}";
  };

  wrapperArgs =
    neovimConfig.wrapperArgs
    ++ ["--suffix" "PATH" ":" "${lib.makeBinPath extraPackages}"];
in
  wrapNeovimUnstable unwrappedTarget (neovimConfig
    // {inherit wrapperArgs;})
