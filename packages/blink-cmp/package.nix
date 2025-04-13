{
  rustPlatform,
  fetchFromGitHub,
  writeShellScriptBin,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.1.1-unstable-2025-04-12";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "23a27a1eb21d49a7ca456adc9c927ab951b30990";
    hash = "sha256-4+VgDL7JDbfOCXsJBrEi1rFrtUxAefexX7xXpxFvlbI=";
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
