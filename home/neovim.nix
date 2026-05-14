{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      nil
      stylua
    ];
  };
}
