{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.username = "anneke";
  home.homeDirectory = "/home/anneke";

  home.packages = with pkgs; [
    affinity-v3
    kdePackages.akregator
    (aspellWithDicts (
      dicts: with dicts; [
        nl
        en
      ]
    ))
    audacity
    authenticator
    blender
    darktable
    davinci-resolve
    digikam
    gearlever
    google-chrome
    inkscape
    kdePackages.kdenlive
    keepassxc
    krita
    libreoffice
    handbrake
    hunspell
    hunspellDicts.nl_NL
    hunspellDicts.en_US
    minder
    onlyoffice-desktopeditors
    pika-backup
    pinta
    scribus
    stellarium
    the-powder-toy
    thunderbird
    obsidian
    shortwave
    upscaler
    vlc
    kdePackages.phonon-vlc
  ];

  programs.firefox.enable = true;

  services.kdeconnect.enable = true;

  services.flatpak.packages = [
    "com.usebottles.bottles"
  ];

  imports = [
    ./flatpak.nix
  ];

  home.stateVersion = "26.05";
}
