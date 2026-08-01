{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # docker-compose
    # lazydocker
    virt-manager
    qemu
    uefi-run
    swtpm
    bottles
    dosfstools
    distrobox
    podman-compose
  ];

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
      extraPackages = [ pkgs.nvidia-container-toolkit ];
    };
  };

  # virtualisation.docker = {
  #   enable = true;
  #   enableOnBoot = true;
  #   autoPrune.enable = true;
  # };

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
