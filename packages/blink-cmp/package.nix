{
  rustPlatform,
  fetchFromGitHub,
  writeShellScriptBin,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.1.1-unstable-2025-04-05";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "192f22ae506328a4924bfaf9053fb98ed7fb1089";
    hash = "sha256-ySP4YWoJOmDuaYim3jiJpovWHelboJpJn7R8OFmgOEQ=";
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
