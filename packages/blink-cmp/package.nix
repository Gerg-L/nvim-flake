{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.3.1-unstable-2025-05-15";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "022521a8910a5543b0251b21c9e1a1e989745796";
    hash = "sha256-ZMq7zXXP3QL73zNfgDNi7xipmrbNwBoFPzK4K0dr6Zs=";
  };

  cargoHash = "sha256-IDoDugtNWQovfSstbVMkKHLBXKa06lxRWmywu4zyS3M";

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
