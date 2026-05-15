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

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/bb685c32-754c-4e61-a213-8cebb543d895";
    fsType = "xfs";
    options = [
      "defaults"
      "nofail"
      "user"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /data 0755 ralph users -"
  ];

  networking.hostName = "ralph-nixos-desktop";

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

  users.users.ramon = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "video"
      "audio"
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
    rustfmt
    clippy
  ];

  virtualisation.podman = {
    enable = true;
    dockerSocket.enable = true;
  };

  programs.direnv.enable = true;

  services.earlyoom.enable = true;
  services.earlyoom.freeMemThreshold = 15;
  services.earlyoom.freeMemKillThreshold = 7;
  services.earlyoom.freeSwapThreshold = 20;
  services.earlyoom.freeSwapKillThreshold = 10;

  system.stateVersion = "25.11";
}
