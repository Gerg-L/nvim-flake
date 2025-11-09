{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.7.0-unstable-2025-11-05";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "40380e711b616a28affb0f4086a2f7de2f2a556b";
    hash = "sha256-0+KyxOh7WUm6rRLfb936X48qBhYL5aRYn2OBEj4G1/s=";
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
