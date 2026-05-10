{
  rustPlatform,
  fetchFromGitHub,
  lib,
  stdenv,
  rust-jemalloc-sys,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "0-unstable-2026-05-04";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "d3874d2a13aa19b095bdd10d37a82a8f0aa7cad3";
    hash = "sha256-3wv3S3icbiyd5ui7jEvYK7U3SXHLzBH/KmXJMhunet4=";
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
