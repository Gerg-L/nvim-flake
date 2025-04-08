{
  rustPlatform,
  fetchFromGitHub,
  writeShellScriptBin,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.1.1-unstable-2025-04-06";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "9632d20905f2b9b8d874846e50fb2d26367e56eb";
    hash = "sha256-GcC/WJCqphYpS6cX9MnDkwvPO9lFT/auLCCm9NdpFEU=";
  };

  postInstall = ''
    cp -r {lua,plugin} "$out"
    mkdir -p "$out/target"
    mv "$out/lib" "$out/target/release"
  '';

  cargoHash = "sha256-MWElqh7ENJ6CbLOnvz0DsP5YYu+e+y12GSUOfW1IKGU=";
  useFetchCargoVendor = true;

  nativeBuildInputs = [
    (writeShellScriptBin "git" "exit 1")
  ];

  env.RUSTC_BOOTSTRAP = true;
}
