{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.6.0-unstable-2025-07-30";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "33f0789297cfec5279c30c8f8980c035fdc91e34";
    hash = "sha256-rEQBAQV4ffrIk6aFOctBVKxtWEDMAsGL4K8JAcZdBLo=";
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
