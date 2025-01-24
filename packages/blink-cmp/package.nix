{
  lib,
  rustPlatform,
  fetchFromGitHub,
  replaceVars,
  writeShellScriptBin,
}:
let
  version = "0.10.0-unstable-2025-01-23";
in
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  inherit version;

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "c4eafc1f87380da04eb8b9c5b52395c48edd102e";
    hash = "sha256-HJ3/Qovyj1lcnlrYz6lueGVxNSx/EsPh8ORgoVvpJ4Y=";
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
