{ config, pkgs, ... }:
{
  sops.defaultSopsFile = ./secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";

  # Example of how to use encrypted secrets:
  # sops.secrets."myapp/password" = {
  #   owner = "myapp";
  #   group = "myapp";
  #   mode = "0400";
  # };
}
