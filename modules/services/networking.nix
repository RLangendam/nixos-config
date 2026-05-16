{ config, pkgs, ... }:
{
  networking.hostName = "ralph-nixos-desktop";
  networking.networkmanager.enable = true;
  programs.localsend.openFirewall = true;
}
