{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.7.0-unstable-2025-10-09";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "cc8c9b737d9ddc5dd0d9869ca2970a3859be9c5f";
    hash = "sha256-bBd4tBupDma0QVgN5SURyA++NLRvnH/XyvESVx8UdJw=";
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
