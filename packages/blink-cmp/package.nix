{
  lib,
  rustPlatform,
  fetchFromGitHub,
  replaceVars,
  writeShellScriptBin,
}:
let
  version = "0.10.0-unstable-2025-01-24";
in
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  inherit version;

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "9854978bf9cb871b386c0dc30913bad81d66a33a";
    hash = "sha256-xXQuEPGBSPe+t1UGPKPZP8LIOfS0rGH9Ug7x1ZEAwTc=";
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
