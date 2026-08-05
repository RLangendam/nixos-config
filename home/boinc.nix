{ pkgs, ... }:

{
  systemd.user.services.podman-boinc = {
    Unit = {
      Description = "BOINC Podman Container (User)";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      Type = "simple";
      Restart = "no"; # Do not auto-restart if stopped manually
      
      # Clean up any dead container instances before starting
      ExecStartPre = [
        "-${pkgs.podman}/bin/podman rm -f boinc"
      ];

      # Run the container matching your exact Inspect configuration
      ExecStart = ''
        ${pkgs.podman}/bin/podman run \
          --name boinc \
          --rm \
          --pids-limit 2048 \
          --shm-size 1073741824 \
          -p 8080:8080 \
          -p 8181:8181 \
          -e PUID=1000 \
          -e PGID=100 \
          -e TZ=Etc/UTC \
          -e CUSTOM_PORT=8080 \
          -e CUSTOM_HTTPS_PORT=8181 \
          -e NVIDIA_DRIVER_CAPABILITIES=compute,video,utility \
          -v /home/ralph/Documents/Boinc:/config:rprivate,rbind \
          lscr.io/linuxserver/boinc:latest
      '';

      ExecStop = "${pkgs.podman}/bin/podman stop -t 10 boinc";
    };

    Install = {
      WantedBy = [ ];
    };
  };
}