{
  rustPlatform,
  fetchFromGitHub,
  lib,
  stdenv,
  rust-jemalloc-sys,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.10.2-unstable-2026-10-30";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "d4318ec75309a37e09757de0f16faa67bf22b890";
    hash = "sha256-sDccz96gXezaUWTu31T64+JhKOO0itqhbFBkWyFYUbo=";
  };
  buildInputs = lib.optional stdenv.hostPlatform.isAarch64 rust-jemalloc-sys;

  cargoHash = "sha256-W1itx0EY4nuPqKyKOlvdGwQH9bm5uh4Vui/gxWEBEDM=";

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
