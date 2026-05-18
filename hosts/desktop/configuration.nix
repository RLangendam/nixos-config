{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common/nix.nix
    ../../modules/common/locale.nix
    ../../modules/desktop/kde.nix
    ../../modules/desktop/nvidia.nix
    ../../modules/desktop/steam.nix
    ../../modules/development/rust.nix
    ../../modules/development/virtualization.nix
    ../../modules/services/pipewire.nix
    ../../modules/services/networking.nix
    ../../modules/services/printing.nix
    ../../modules/services/automount.nix
    ../../modules/services/earlyoom.nix
    ../../modules/services/syncthing.nix
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
      "exec"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /data 0755 ralph users -"
  ];

  nix.settings = {
    download-buffer-size = 524288000; # 500 MiB
    cores = 4;
    max-jobs = 3;
  };

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
    wget
    curl
    nerd-fonts.jetbrains-mono
    lua-language-server
    stylua
    pciutils
  ];

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  services.blueman.enable = true;
  services.flatpak.enable = true;
  services.power-profiles-daemon.enable = true;

  xdg.portal.enable = true;

  system.stateVersion = "25.11";
}
