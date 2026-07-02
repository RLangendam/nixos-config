{ config, pkgs, ... }:
{
  services.flatpak.enable = true;

  # Forces flatpak to install applications into ~/.local/share/flatpak/
  services.flatpak.uninstallUnmanaged = true;

  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }
  ];
}
