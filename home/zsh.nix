{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "eza --icons -l -T -L=1";
      cat = "bat";
      htop = "btm";
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
}
