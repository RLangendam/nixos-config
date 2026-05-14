{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -lah";
    };
    initContent = ''
      eval "$(direnv hook zsh)"
    '';
  };
}
