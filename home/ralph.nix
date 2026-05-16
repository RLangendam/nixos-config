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
    settings = {
      user = {
        name = "Ralph Langendam";
        email = "rlangendam@gmail.com";
      };
    };
  };

  # programs.zsh.enable = true;
  # programs.zsh.initContent = ''
  #   eval "$(direnv hook zsh)"
  # '';

  # programs.direnv.enable = true;
  # programs.direnv.package = pkgs.direnv;

  # programs.tmux.enable = true;
  # programs.zellij.enable = true;
  # programs.wezterm.enable = true;
  # programs.starship.enable = true;
  # programs.starship.settings = {
  #   add_newline = false;
  #   format = "$all";
  # };

  home.packages = with pkgs; [
    # firefox
    ripgrep
    fd
    eza
    bat
    bottom
    thunderbird
    # vscode
    keepass
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
    # inkscape
    # libresprite
    # upscayl
    # material-maker
    # google-fonts
    # fontforge-gtk
    # blender
    # git-extras
    # git-filter-repo
    # openssh
    # vlc
    # mpv
    # ffmpeg
    # discord
    # obs-studio
    # kdePackages.kdenlive
    # zip
    # unzip
    # rsync
    # pandoc
    # yazi
  ];

  programs.firefox.enable = true;
  # error: The option `home-manager.users.ralph.programs.thunderbird.profiles' was accessed but has no value defined. Try setting the option.
  #programs.thunderbird.enable = true;
  programs.vscode.enable = true;

  xdg.mimeApps.defaultApplications = lib.mkForce {
    "image/svg+xml" = [ "org.inkscape.Inkscape.desktop" ];
  };

  programs.git.lfs.enable = true;
  services.ssh-agent.enable = true;

  programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
    obs-gstreamer
    obs-vaapi
    obs-scale-to-sound
  ];

  home.stateVersion = "25.11";

  imports = [
    ./neovim.nix
    ./zsh.nix
    # ./git.nix
    ./wezterm.nix
    ./tmux.nix
    ./zellij.nix
  ];
}
