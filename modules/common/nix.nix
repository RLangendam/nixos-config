{ config, pkgs, ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.direnv.enable = true;
  programs.git.enable = true;
}
