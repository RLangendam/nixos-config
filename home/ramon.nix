{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.username = "ramon";
  home.homeDirectory = "/home/ramon";

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Ramon Ribeiro";
        email = "ramon.kbyte@gmail.com";
      };
    };
  };

  programs.direnv.enable = true;
  programs.direnv.package = pkgs.direnv;

  home.packages = with pkgs; [
    davinci-resolve
    discord
    libreoffice
    thunderbird
    vlc
    vlc-bittorrent
    kdePackages.phonon-vlc
    hunspell
    hunspellDicts.pt_BR
    hunspellDicts.en_US
    (aspellWithDicts (
      dicts: with dicts; [
        br
        en
      ]
    ))
  ];

  programs.firefox.enable = true;

  programs.obs-studio.enable = true;
  programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
    obs-gstreamer
    obs-vaapi
    obs-scale-to-sound
  ];

  services.flatpak.packages = [
    "moe.launcher.an-anime-game-launcher"
  ];

  imports = [
    ./flatpak.nix
  ];

  home.stateVersion = "26.05";
}
