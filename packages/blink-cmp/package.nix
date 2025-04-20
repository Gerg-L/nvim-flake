{
  rustPlatform,
  fetchFromGitHub,
  writeShellScriptBin,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.1.1-unstable-2025-04-18";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "46c2db88c3efdf5eb99f9073675a874ba91bbc3f";
    hash = "sha256-as70ayTTEKPpNSk4s04zWwJrPLl4tgywWaabHJQ5KeQ=";
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
