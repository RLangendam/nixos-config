{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    secrets.fah_token = { };

    templates."fah.env" = {
      content = ''
        ACCOUNT_TOKEN=${config.sops.placeholder.fah_token}
      '';
    };
  };

  systemd.user.services.podman-foldingathome = {
    Unit = {
      Description = "Folding@home Podman Container (User)";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      Type = "simple";
      Restart = "no";

      ExecStartPre = [
        "-${pkgs.podman}/bin/podman rm -f foldingathome"
      ];

      ExecStart = lib.concatStringsSep " " [
        "${pkgs.podman}/bin/podman run"
        "--name foldingathome"
        "--rm"
        "--gpus all"
        "--pids-limit 2048"
        "--shm-size 65536000"
        "-p 7396:7396"
        "-e PUID=1000"
        "-e PGID=100"
        "-e TZ=Europe/Amsterdam"
        "-e MACHINE_NAME=ralph-nixos"
        "--env-file ${config.sops.templates."fah.env".path}"
        "-e NVIDIA_VISIBLE_DEVICES=all"
        "-e NVIDIA_DRIVER_CAPABILITIES=compute,utility,video"
        "-v /home/ralph/Documents/FoldingAtHome:/config:rprivate,rbind"
        "lscr.io/linuxserver/foldingathome:latest"
      ];

      ExecStop = "-${pkgs.podman}/bin/podman stop -t 10 foldingathome";
    };

    Install = {
      WantedBy = [ ];
    };
  };
}