{ config, pkgs, ... }:

let
  # Use rust-overlay's rust-bin helper to select a reproducible latest nightly
  # with common components (rust-src, rustfmt, clippy).
  nightlyToolchain = pkgs.rust-bin.selectLatestNightlyWith (
    toolchain:
    toolchain.default.override {
      extensions = [
        "rust-src"
        "rustfmt"
        "clippy"
      ];
    }
  );
in
{
  # Install the selected nightly toolchain system-wide (binary distribution),
  # along with rust-analyzer and some common developer tooling.
  environment.systemPackages = with pkgs; [
    # the selected nightly toolchain (provides rustc/cargo)
    nightlyToolchain

    # language server and tooling
    rust-analyzer

    # other niceties
    crane
    buildah
    skopeo
    bash

    # linker
    gcc
    gnumake

    pkg-config
    openssl
  ];

  # No rustup or per-user one-shot services — the binary toolchain is supplied
  # directly by Nix for reproducibility.
}
