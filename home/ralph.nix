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
    krita
    pinta
    libresprite
    material-maker
    fontforge-gtk
    blender
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
    gearlever
    tor-browser
    # whatsie
    # ventoy
    audacity
    shortwave
    clamav
    clamtk
    dbeaver-bin
    video-downloader
    postman
    calibre
    arduino-ide
    filezilla
    upscaler
    haguichi
    dosbox-staging
    teamspeak6-client
    openttd
    i2pd
    i2pd-tools
    vice
    the-powder-toy
    logisim-evolution
    antigravity
    kdePackages.filelight
    (heroic.override {
      extraPkgs =
        pkgs': with pkgs'; [
          gamescope
          gamemode
        ];
    })
    geogebra
    obsidian
    ruffle
    itch
    podman-desktop
    calibre
    retroarch-full
    scummvm
    meld
    ripgrep
    fd
    tree
    atool
    gnupg
    pv
    jq
    xclip
    tmux
    cron
    sshfs
    qrencode
    yt-dlp
    imagemagickBig
    fastfetch
    tldr
  ];

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
  };

  services.flatpak.packages = [
    "moe.launcher.an-anime-game-launcher"
    "com.github.unrud.VideoDownloader"
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

  home.stateVersion = "26.05";

  imports = [
    ./cpp.nix
    ./flatpak.nix
    ./git.nix
    ./neovim.nix
    ./wezterm.nix
    ./zellij.nix
    ./zsh.nix
  ];
}
