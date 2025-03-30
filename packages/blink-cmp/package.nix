{
  rustPlatform,
  fetchFromGitHub,
  writeShellScriptBin,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.0.0-unstable-2025-03-28";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "70c73033c510ee3641393a4a081d3c85db91a641";
    hash = "sha256-3KJ9oTDiheI/o4thEKS3UWg+hsYvHbkFwo4iUYpphBE=";
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
