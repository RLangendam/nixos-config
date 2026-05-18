{ config, pkgs, ... }:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "ralph";
    dataDir = "/data/syncthing";
    configDir = "/home/ralph/.config/syncthing";
  };

  #services.syncthing.settings.gui = {
  #  user = "ralph";
  #  password = "";
  #};

}
