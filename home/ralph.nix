{ config, pkgs, ... }:
{
  home.username = "ralph";
  home.homeDirectory = "/home/ralph";

  programs.git = {
    enable = true;
    userName = "Ralph Langendam";
    userEmail = "rlangendam@gmail.com";
  };

  programs.zsh.enable = true;
  programs.zsh.initExtra = ''
    eval "$(direnv hook zsh)"
  '';

  programs.direnv.enable = true;
  programs.direnv.package = pkgs.direnv;

  programs.tmux.enable = true;
  programs.zellij.enable = true;
  programs.wezterm.enable = true;

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
    git
    stylua
    rust-analyzer
    nil
    cargo
    rustfmt
    clippy
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
  ];
}
