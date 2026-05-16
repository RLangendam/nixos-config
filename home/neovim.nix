{ config, pkgs, ... }:
{
  programs.neovim.enable = true;

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
}
