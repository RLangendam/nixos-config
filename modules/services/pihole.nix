{ config, pkgs, ... }:
{
  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 53;
  };

  services.resolved = {
    enable = true;
    settings = {
      Resolve = {
        DNSStubListener = "no";
      };
    };
  };

  networking.nameservers = [
    "127.0.0.1"
    "1.1.1.1"
  ];

  systemd.tmpfiles.rules = [
    "d /var/lib/pihole/etc-pihole 0755 root root -"
    "d /var/lib/pihole/etc-dnsmasq.d 0755 root root -"
  ];

  virtualisation.oci-containers = {
    backend = "podman";
    containers.pihole = {
      image = "pihole/pihole:latest";
      autoStart = true;
      ports = [
        "127.0.0.1:53:53/tcp"
        "127.0.0.1:53:53/udp"
        "127.0.0.1:8085:80/tcp"
      ];
      environment = {
        TZ = "europe/Amsterdam";
        FTLCONF_LOCAL_IPV4 = "127.0.0.1";
        WEBPASSWORD = "pihole";
      };
      volumes = [
        "/var/lib/pihole/etc-pihole:/etc/pihole"
        "/var/lib/pihole/etc-dnsmasq.d:/etc/dnsmasq.d"
      ];
    };
  };
}
