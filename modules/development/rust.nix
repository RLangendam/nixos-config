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
    podman
    skopeo
  ];

  virtualisation.podman = {
    enable = true;
    dockerSocket.enable = true;
  };

  programs.direnv.enable = true;
  programs.nix-direnv.enable = true;
}
