{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    fd
    eza
    bat
    btop
    zip
    unzip
    rsync
    pandoc
    fd
    tree
    atool
    pv
    jq
    tmux
    cron
    sshfs
    qrencode
    yt-dlp
    fastfetch
    tldr
    delta
    dust
    fzf
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "eza --icons -l -T -L=1";
      cat = "bat";
      htop = "btop";
    };
    initContent = ''
      eval "$(direnv hook zsh)"
      eval "$(starship init zsh)"
    '';
  };

  programs.direnv.enableZshIntegration = true;

  programs.starship.enable = true;
  programs.starship.settings = {
    add_newline = false;
    format = "$all";
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd cd"
    ];
  };
}
