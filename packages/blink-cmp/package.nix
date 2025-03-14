{
  rustPlatform,
  fetchFromGitHub,
  writeShellScriptBin,
}:
let
  version = "0.13.1-unstable-2025-03-08";
in
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  inherit version;

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "07c3bedc14e824489c1f8abfd7123bdb6d4634e2";
    hash = "sha256-nI9OY+vdEatbhRLF6+QGGNVOVxlGP7pcmBgiZwQpB6Y=";
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
