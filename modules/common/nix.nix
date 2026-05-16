{ config, pkgs, ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    nil
    nixfmt
    nixdoc
  ];

  programs.direnv.enable = true;
  programs.git.enable = true;
}
