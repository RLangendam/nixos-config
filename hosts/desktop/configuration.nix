{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common/locale.nix
    ../../modules/desktop/kde.nix
    ../../modules/desktop/nvidia.nix
    ../../modules/services/pipewire.nix
    ../../modules/services/networking.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ralph-laptop";

  time.timeZone = "Europe/Amsterdam";

  users.users.ralph = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "docker"
      "podman"
    ];
  };

  services.xserver.enable = true;

  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    podman
    buildah
    skopeo
    crane
    zellij
    tmux
    wezterm
    direnv
    nix-direnv
    rust-analyzer
    cargo
    nil
    lua-language-server
    stylua
  ];

  system.stateVersion = "25.11";
}
