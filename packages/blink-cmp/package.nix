{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.9.1-unstable-2026-02-08";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "f85eb6252f4c0212be15c6c4213e9af587574cbe";
    hash = "sha256-DbKgP2jjTux0O/TvqkMnPrEOQ4jcxDNo9WXJBmfNxiU=";
  };

  cargoHash = "sha256-GNZb/PBOO51BSARATcu4IZhBxBrB7MKxUIRBJXuxkp8=";

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
