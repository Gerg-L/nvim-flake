{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.6.0-unstable-2025-08-30";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "7b0548e5103e295f465be00b1bb7770c548776c1";
    hash = "sha256-p52cyY7LYaroc3P0ag4JOtfEVHrChRuKwOdiSEL0TN0=";
  };

  cargoHash = "sha256-QsVCugYWRri4qu64wHnbJQZBhy4tQrr+gCYbXtRBlqE=";

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
