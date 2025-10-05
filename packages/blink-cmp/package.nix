{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.7.0-unstable-2025-09-29";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "a999ddca2f629faf8a554a8fff904931935a7b1c";
    hash = "sha256-n3R3xiMGRGBlwU+TIshowEE/25Jjw4hFdS/mEX623/M=";
  };

  cargoHash = "sha256-zWZHT+Y8ENN/nFEtJnkEUHXRuU6FUQ/ITHo+V4zJ6f8=";

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
