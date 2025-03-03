{
  rustPlatform,
  fetchFromGitHub,
  writeShellScriptBin,
}:
let
  version = "0.13.1-unstable-2025-03-02";
in
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  inherit version;

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "12298b4836d11b536aefb76f4937c0a8769773cc";
    hash = "sha256-aq2fXEIMz9j3tCeHaRM3eBAYyeQO84rf/G6SJybMFqw=";
  };

  postInstall = ''
    cp -r {lua,plugin} "$out"
    mkdir -p "$out/target/release"
    mv "$out/lib/"* "$out/target/release/"
    echo -n "nix" > "$out/target/release/version"
  '';

  cargoHash = "sha256-F1wh/TjYoiIbDY3J/prVF367MKk3vwM7LqOpRobOs7I=";
  useFetchCargoVendor = true;

  nativeBuildInputs = [
    (writeShellScriptBin "git" "exit 1")
  ];

  env.RUSTC_BOOTSTRAP = true;
}
