{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.3.1-unstable-2025-05-31";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "30f0a7b5bfed80c1e4b1f7ba065f5c36db0ce025";
    hash = "sha256-iv6EIGiQXfphuexTFiD6uC76aCTSob1Cf456IwmBm5s=";
  };

  cargoHash = "sha256-IDoDugtNWQovfSstbVMkKHLBXKa06lxRWmywu4zyS3M=";

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
