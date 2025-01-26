{
  lib,
  rustPlatform,
  fetchFromGitHub,
  replaceVars,
  writeShellScriptBin,
}:
let
  version = "0.11.0-unstable-2025-01-26";
in
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  inherit version;

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "f0f34c318af019b44fc8ea347895dcf92b682122";
    hash = "sha256-IAlJ1VfTJLUkS5y92fXkluVFTDa8vs9K+/nWM9z/G44=";
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

  cargoHash = "sha256-EoxKmVyJRxqI6HOuuiSj5+IOuo5M8ZNdSyk86sQNtE8=";
  useFetchCargoVendor = true;

  nativeBuildInputs = [
    (writeShellScriptBin "git" "exit 1")
  ];

  env.RUSTC_BOOTSTRAP = true;
}
