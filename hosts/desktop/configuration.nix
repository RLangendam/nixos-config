{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common/nix.nix
    ../../modules/common/fonts.nix
    ../../modules/common/locale.nix
    ../../modules/desktop/kde.nix
    ../../modules/desktop/nvidia.nix
    ../../modules/desktop/steam.nix
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

  systemd.tmpfiles.rules = [
    "d /data 0755 ralph users -"
  ];
  # Disable systemd targets for sleep and hibernation
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

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
    lua-language-server
    stylua
    pciutils
    cacert
    openssl
  ];

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  # services.blueman.enable = true;
  services.flatpak.enable = true;
  services.power-profiles-daemon.enable = true;

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
  };

  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startplasma-x11";
  services.xrdp.openFirewall = true;

  system.stateVersion = "25.11";
}
