{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker-compose
    lazydocker
    virt-manager
    qemu
    uefi-run
    swtpm
    bottles
    dosfstools
    distrobox
  ];

  virtualisation.podman = {
    enable = true;
    dockerSocket.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

  virtualisation.lxc.enable = true;

  virtualisation.libvirtd = {
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
    enable = true;
    qemu.runAsRoot = false;
  };
}
