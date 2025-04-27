{
  rustPlatform,
  fetchFromGitHub,
  writeShellScriptBin,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.1.1-unstable-2025-04-26";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "f2e4f6aae833c5c2866d203666910005363779d7";
    hash = "sha256-Y5dcnlVl4nvCDEQQD5O2BdjuB3oNZc1fmQj7fE7azV8=";
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
