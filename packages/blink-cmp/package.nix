{
  rustPlatform,
  fetchFromGitHub,
  lib,
  stdenv,
  rust-jemalloc-sys,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.10.2-unstable-2026-11-04";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "7b31e1b6497be70f620bbad83a789929248697ac";
    hash = "sha256-8m/YJF19Ws2WQAcYX8qc/nEKPMVhRyR/tU9WRwPHOtE=";
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
