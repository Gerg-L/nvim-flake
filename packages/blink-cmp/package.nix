{
  lib,
  rustPlatform,
  fetchFromGitHub,
  replaceVars,
  writeShellScriptBin,
}:
let
  version = "0.12.2-unstable-2025-02-16";
in
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  inherit version;

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "5007e544362da031909ae718cf86e9bace964711";
    hash = "sha256-rZQmWEIuv327GYvDYbAKMsgQsY7Cu+70ZQuTit20BuE=";
  };

  patches = [
    (replaceVars ./force-version.patch {
      tag = "v${builtins.concatStringsSep "." (lib.take 3 (builtins.splitVersion version))}";
    })
  ];

  postInstall = ''
    cp -r {lua,plugin} "$out"
    mkdir -p "$out/target"
    mv "$out/lib" "$out/target/release"
  '';

  cargoHash = "sha256-W7CdF70BMXKMCcooR6adw2wwHJ3WznZ+o8KRyHWMeeI=";
  useFetchCargoVendor = true;

  nativeBuildInputs = [
    (writeShellScriptBin "git" "exit 1")
  ];

  env.RUSTC_BOOTSTRAP = true;
}
