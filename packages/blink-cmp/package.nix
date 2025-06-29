{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.4.1-unstable-2025-06-27";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "e84b7d936eb8de042a5fc7c8dabef609dd8e2386";
    hash = "sha256-47COYufbsSItR0Ax8dJV1j3t0xLw4Uq/2SD4b1yY8I8=";
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
