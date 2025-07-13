{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.4.1-unstable-2025-07-11";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "17e30f35af24545fc2cd8711a0788f49b44c28ff";
    hash = "sha256-4BdnAP+cf1rRAplnAgpJPeS/HW+X6rkRzE44CwohouM=";
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
