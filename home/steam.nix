{ config, pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
    "steam-original"
    "steam-run"
  ];

  home.packages = with pkgs; [
    steam-run
    protonup-qt
  ];

  programs.java.enable = true;
}
