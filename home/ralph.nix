{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.username = "ralph";
  home.homeDirectory = "/home/ralph";

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    settings = {
      user = {
        name = "Ralph Langendam";
        email = "rlangendam@gmail.com";
      };
      lfs.enable = true;
    };
  };

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
    # kdePackages.kdenlive
    zip
    unzip
    rsync
    pandoc
    # local-ai # Broken
    inkscape
    gimp-with-plugins
    vlc
    vlc-bittorrent
    kdePackages.phonon-vlc
    qbittorrent
    obsidian
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
    (heroic.override {
      extraPkgs =
        pkgs': with pkgs'; [
          gamescope
          gamemode
        ];
    })
    (lutris.override {
      extraLibraries =
        pkgs: with pkgs; [
          libadwaita
          gtk4
        ];
    })
  ];

  programs.firefox.enable = true;
  # error: The option `home-manager.users.ralph.programs.thunderbird.profiles' was accessed but has no value defined. Try setting the option.
  #programs.thunderbird.enable = true;
  programs.vscode.enable = true;
  # programs.lutris.enable = true;

  # programs.lutris.extraPackages =
  #   pkgs': with pkgs'; [
  #     mangohud
  #     winetricks
  #     gamescope
  #     gamemode
  #   ];

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
    ./neovim.nix
    ./zsh.nix
    ./wezterm.nix
    ./tmux.nix
    ./zellij.nix
  ];
}
