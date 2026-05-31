{
  rustPlatform,
  fetchFromGitHub,
  lib,
  stdenv,
  rust-jemalloc-sys,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.10.2-unstable-2026-05-30";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "5ee69ea52492fa038b3a1cd8de55edffe205c77d";
    hash = "sha256-sE9dQZ5Du3vDC9WYgvP9Pt6A6gXO/6EqljmX4jRcz0I=";
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
