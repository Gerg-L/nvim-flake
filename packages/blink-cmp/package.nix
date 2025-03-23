{
  rustPlatform,
  fetchFromGitHub,
  writeShellScriptBin,
}:
let
  version = "0.14.1-unstable-2025-03-22";
in
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  inherit version;

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "4607923f60029f8cb28e6950a078f93fd33e1288";
    hash = "sha256-iIHV2M+cbXVb/XsFhEMyNDu2TvTlBb2R6DVGmvbQpn4=";
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
