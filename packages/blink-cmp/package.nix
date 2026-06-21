{
  rustPlatform,
  fetchFromGitHub,
  lib,
  stdenv,
  rust-jemalloc-sys,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.10.2-unstable-2026-06-20";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "bda905a4bf1b3edfa708b0be193b8c63d8620c96";
    hash = "sha256-zasVwual6ectjIjxNgUftw090ZKHw23Abo7/RK1U/90=";
  };
  buildInputs = lib.optional stdenv.hostPlatform.isAarch64 rust-jemalloc-sys;

  cargoHash = "sha256-z8koRYVM9mkgKB6rdZAKIfjZfinVUUpYAW0IvPgmjZ4=";

  # Tries to call git
  preBuild = ''
    rm build.rs
  '';

  postInstall = ''
    cp -r {lua,plugin} "$out"
    mkdir -p "$out/doc"
    cp 'doc/'*'.txt' "$out/doc/"
  '';

  env.RUSTFLAGS = lib.optionalString stdenv.hostPlatform.isDarwin "-C link-arg=-undefined -C link-arg=dynamic_lookup";

  # Don't move /doc to $out/share
  forceShare = [ ];
}
