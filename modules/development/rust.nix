{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cargo
    rustc
    rust-analyzer
    rustfmt
    clippy
    crane
    buildah
    skopeo
  ];
}
