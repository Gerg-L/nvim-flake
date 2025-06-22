{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.4.1-unstable-2025-06-21";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "fe7c97455a375259a480c496fe3410c52ac004dc";
    hash = "sha256-tLZdfHOrL0H9tI1TwXTEKfn4Laa3AV6RtTR3owOMMIw=";
  };

  cargoHash = "sha256-N7s1s7K/9OFJuIMOJhRFS8LOFQBckdrlbxOYAqwEZlU=";

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
