{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.8.0-unstable-2025-11-14";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "b19413d214068f316c78978b08264ed1c41830ec";
    hash = "sha256-JjlcPj7v9J+v1SDBYIub6jFEslLhZGHmsipV1atUAFo=";
  };

  cargoHash = "sha256-Qdt8O7IGj2HySb1jxsv3m33ZxJg96Ckw26oTEEyQjfs=";

  # Tries to call git
  preBuild = ''
    rm build.rs
  '';

  postInstall = ''
    cp -r {lua,plugin} "$out"
    mkdir -p "$out/doc"
    cp 'doc/'*'.txt' "$out/doc/"
    mkdir -p "$out/target"
    mv "$out/lib" "$out/target/release"
  '';

  # Uses rust nightly
  env.RUSTC_BOOTSTRAP = true;
  # Don't move /doc to $out/share
  forceShare = [ ];
}
