{
  rustPlatform,
  fetchFromGitHub,
  lib,
  stdenv,
  rust-jemalloc-sys,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.9.1-unstable-2026-03-05";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "e9556f9b981f395e22a6bfd69fd5f3008a2a6cd9";
    hash = "sha256-EhKpt+L6Qw9NpUsms11tsNnV4IQ/divhiipCcQSV4VI=";
  };
  buildInputs = lib.optional stdenv.hostPlatform.isAarch64 rust-jemalloc-sys;

  cargoHash = "sha256-EswHGYr/PbQQPrMys0Sv0UNfB56zN5SSqg2FJbXZWAs=";

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
  env = {
    RUSTC_BOOTSTRAP = true;
    RUSTFLAGS = lib.optionalString stdenv.hostPlatform.isDarwin "-C link-arg=-undefined -C link-arg=dynamic_lookup";
  };

  # Don't move /doc to $out/share
  forceShare = [ ];
}
