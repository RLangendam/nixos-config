{ config, pkgs, ... }:
{
  networking.hostName = "ralph-nixos-desktop";
  networking.networkmanager.enable = true;

  services.openssh.enable = true;

  # For KDEConnect
  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  services.logmein-hamachi.enable = true;
}
