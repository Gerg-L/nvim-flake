{
  lib,
  rustPlatform,
  fetchFromGitHub,
  replaceVars,
  writeShellScriptBin,
}:
let
  version = "0.10.0-unstable-2025-01-19";
in
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  inherit version;

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "8f27db520029b793adb5e784f57ca309deb77ca8";
    hash = "sha256-QQuzy0SsRZ5OF+i8sTzIoydenx+cogHE2ufVNPdFk7w=";
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

  cargoHash = "sha256-ISCrUaIWNn+SfNzrAXKqeBbQyEnuqs3F8GAEl90kK7I=";
  useFetchCargoVendor = true;

  nativeBuildInputs = [
    (writeShellScriptBin "git" "exit 1")
  ];

  env.RUSTC_BOOTSTRAP = true;
}
