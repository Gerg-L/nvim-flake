{
  rustPlatform,
  fetchFromGitHub,
  writeShellScriptBin,
}:
let
  version = "0.13.1-unstable-2025-03-14";
in
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  inherit version;

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "cb8cc634dee35b14e359daf2e9b0c418a60f75f1";
    hash = "sha256-q0IzIb+GNvOniatW3lnnaQxYPgS1JkaAC9VpF2aA2Jo=";
  };

  postInstall = ''
    cp -r {lua,plugin} "$out"
    mkdir -p "$out/target"
    mv "$out/lib" "$out/target/release"
  '';

  cargoHash = "sha256-F1wh/TjYoiIbDY3J/prVF367MKk3vwM7LqOpRobOs7I=";
  useFetchCargoVendor = true;

  nativeBuildInputs = [
    (writeShellScriptBin "git" "exit 1")
  ];

  env.RUSTC_BOOTSTRAP = true;
}
