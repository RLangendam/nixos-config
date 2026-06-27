{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.username = "ralph";
  home.homeDirectory = "/home/ralph";

  home.packages = with pkgs; [
    ripgrep
    fd
    eza
    bat
    bottom
    thunderbird
    keepassxc
    davinci-resolve
    libreoffice
    hunspell
    hunspellDicts.nl_nl
    hunspellDicts.en_US
    (aspellWithDicts (
      dicts: with dicts; [
        nl
        en
      ]
    ))
    # krita
    # pinta
    # libresprite
    # upscayl
    # material-maker
    # fontforge-gtk
    # blender
    git-extras
    git-filter-repo
    mpv
    ffmpeg
    discord
    zip
    unzip
    rsync
    pandoc
    inkscape
    gimp-with-plugins
    vlc
    vlc-bittorrent
    kdePackages.phonon-vlc
    qbittorrent
    ldtk
    aseprite
    tiled
    bash-language-server
    pkgs.affinity-v3
    brave
    pika-backup
    digikam
    evince
    veracrypt
    qdirstat
    handbrake
  ];

  services.flatpak.packages = [
    "md.obsidian.Obsidian"
    "moe.launcher.an-anime-game-launcher"
  ];

  programs.firefox.enable = true;
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
  };

  xdg.mimeApps.defaultApplications = lib.mkForce {
    "image/svg+xml" = [ "org.inkscape.Inkscape.desktop" ];
  };

  services.ssh-agent.enable = true;

  programs.obs-studio.enable = true;
  programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
    obs-gstreamer
    obs-vaapi
    obs-scale-to-sound
  ];

  programs.yazi.enable = true;

  services.kdeconnect.enable = true;

  services.ollama = {
    enable = true;
    acceleration = "cuda"; # Schakelt CUDA in voor Nvidia GPU's
  };

  home.stateVersion = "25.11";

  imports = [
    ./flatpak.nix
    ./git.nix
    ./heroic.nix
    ./neovim.nix
    ./rust.nix
    ./wezterm.nix
    ./zellij.nix
    ./zsh.nix
  ];
}
