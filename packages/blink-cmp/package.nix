{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.3.1-unstable-2025-06-13";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "0fc23d278ef32b89aa9f3f18f3125ef403e23bae";
    hash = "sha256-Yf3dnExofgdRj69gF6gglaaSR5APrwigCQzwdA5uhss=";
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
