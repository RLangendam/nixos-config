{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -lah";
    };
    initExtra = ''
      eval "$(direnv hook zsh)"
    '';
  };
}
