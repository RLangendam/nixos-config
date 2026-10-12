{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common/nix.nix
    ../../modules/common/fonts.nix
    ../../modules/common/locale.nix
    ../../modules/desktop/kde.nix
    ../../modules/desktop/nvidia.nix
    ../../modules/desktop/steam.nix
    ../../modules/development/nix-ld.nix
    ../../modules/development/sccache.nix
    ../../modules/development/virtualization.nix
    ../../modules/services/automount.nix
    ../../modules/services/earlyoom.nix
    ../../modules/services/networking.nix
    ../../modules/services/pihole.nix
    ../../modules/services/pipewire.nix
    ../../modules/services/printing.nix
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

  i18n = {
    # Default fallback language for system processes / console
    defaultLocale = "en_US.UTF-8";

    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "nl_NL.UTF-8/UTF-8"
      "pt_BR.UTF-8/UTF-8"
    ];
  };

  users.users.anneke = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "video"
      "audio"
    ];
  };

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
    pciutils
    cacert
    openssl
    piper
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

  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
    (final: prev: {
      msitools = prev.msitools.overrideAttrs (old: {
        doCheck = false;
      });
    })
  ];

  services.ratbagd.enable = true;

  nix.gc.automatic = true;

  system.stateVersion = "26.05";
}
