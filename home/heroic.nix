{ config, pkgs, ... }:
{
  services.flatpak.packages = [
    "com.heroicgameslauncher.hgl"
    "org.freedesktop.Platform.VulkanLayer.gamescope//24.08"
    "org.freedesktop.Platform.VulkanLayer.MangoHud//24.08"
  ];

  # Geeft Heroic toegang tot het D-Bus netwerk van GameMode
  services.flatpak.overrides = {
    "com.heroicgameslauncher.hgl" = {
      Context = {
        sockets = [
          "wayland"
          "x11"
        ];
        shared = [ "ipc" ];
        talk-name = [ "org.freedesktop.GameMode" ];
        filesystems = [ "xdg-config/MangoHud:ro" ];
      };
    };
  };
}
