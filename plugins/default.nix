{
  pkgs,
  lib,
  ...
}: {
  plugins = lib.attrsets.mapAttrsToList (
    _: value:
      pkgs.buildVimPluginFrom2Nix {
        pname = value.pname;
        version = value.version;
        src = value.src;
      }
  ) (import ./_sources/generated.nix);
}
