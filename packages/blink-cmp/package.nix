{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "blink.cmp";
  version = "1.8.0-unstable-2025-12-14";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "d4ba3e7c39543e588d1569532cbdd03d73d20c39";
    hash = "sha256-zSnTNGeF4qR1tByE7MY+SXBxLThjZScQM2K/7vRVuqM=";
  };

  cargoHash = "sha256-Qdt8O7IGj2HySb1jxsv3m33ZxJg96Ckw26oTEEyQjfs=";

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
