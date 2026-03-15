{
  rustPlatform,
  fetchFromGitHub,
  lib,
  stdenv,
  rust-jemalloc-sys,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.10.1-unstable-2026-03-14";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "f9a453b6b6d4065efb5dd9731d760af7344c7873";
    hash = "sha256-d/0hTIXAIw2VEF/A74nPT0hp36wRhCNTHSRgNNpM0Jo=";
  };
  buildInputs = lib.optional stdenv.hostPlatform.isAarch64 rust-jemalloc-sys;

  cargoHash = "sha256-3o2n4xwNF9Fc3VlPKf3lnvmN7FVus5jQB8gcXXwz50c=";

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
