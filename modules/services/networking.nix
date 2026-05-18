{ config, pkgs, ... }:
{
  networking.hostName = "ralph-nixos-desktop";
  networking.networkmanager.enable = true;

  services.openssh.enable = true;

  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
}
