{ config, pkgs, ... }:
{
  services.earlyoom = {
    enable = true;
    freeMemThreshold = 15;
    freeMemKillThreshold = 10;
    freeSwapThreshold = 20;
    freeSwapKillThreshold = 10;
    enableNotifications = false;
    enableDebugInfo = false;
    package = pkgs.earlyoom;
    extraArgs = [
      "--prefer"
      "(^|/)(chrome|chromium|firefox|java)$"
    ];
  };
}
