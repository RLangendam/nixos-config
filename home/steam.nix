{ config, pkgs, lib, ... }:
{
  programs.steam = {
    enable = true; # Master switch, already covered in installation
    remotePlay.openFirewall = true;  # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports for Source Dedicated Server hosting
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    # Other general flags if available can be set here.
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
    "steam-original"
    "steam-run"
  ];

  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];

  programs.gamemode.enable = true;

  programs.gamescope = {
    enable = true;
    capSysNice = false;
  };

  environment.systemPackages = with pkgs; [
    steam-run
    protonup-qt
    #gamescope-wsi # HDR won't work without this
  ];

  programs.java.enable = true;
  programs.steam.extraPackages = [ pkgs.jdk ];

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
}
