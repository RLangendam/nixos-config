{ config, pkgs, ... }:
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

  programs.zsh.enable = true;
  programs.zsh.initContent = ''
    eval "$(direnv hook zsh)"
  '';

  programs.direnv.enable = true;
  programs.direnv.package = pkgs.direnv;

  programs.tmux.enable = true;
  programs.zellij.enable = true;
  programs.wezterm.enable = true;
  programs.starship.enable = true;
  programs.starship.settings = {
    add_newline = false;
    format = "$all";
  };

  home.packages = with pkgs; [
    firefox
    ripgrep
    fd
    bat
    direnv
    nix-direnv
    zellij
    tmux
    wezterm
    nerd-fonts.jetbrains-mono
    git
    stylua
    nil
    kdePackages.kate
    thunderbird
    vscode
    keepass
    davinci-resolve
    libreoffice
    hunspell
    hunspellDicts.pt_BR
    hunspellDicts.en_US
    (aspellWithDicts (
      dicts: with dicts; [
        br
        en
      ]
    ))
    starship
  ];

  home.file.".config/nvim/init.lua".text = ''
    local config_path = vim.fn.expand("~/.config/lua")
    vim.opt.rtp:prepend(config_path)
    package.path = config_path .. "/?.lua;" .. package.path
    package.path = config_path .. "/?/init.lua;" .. package.path
    require("config")
  '';

  home.file.".config/lua".source = ./neovim-config/lua;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GIT_EDITOR = "nvim";
  };

  home.stateVersion = "25.11";
  imports = [
    ./neovim.nix
    ./zsh.nix
    ./git.nix
    ./wezterm.nix
    ./tmux.nix
    ./zellij.nix
    ./steam.nix
  ];
}
