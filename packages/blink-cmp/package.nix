{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.5.1-unstable-2025-07-19";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "af22c527a451d162e5229a1eff9283ee840b4bca";
    hash = "sha256-WnXCVNU5if/2pODUNpyMtEssRXgpmGqEhwUAbL9AN1Q=";
  };

  cargoHash = "sha256-pWBOPMUy/gXeujaowlp2I6kqD+Q95h+f9mXl231DN88=";

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
