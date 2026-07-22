{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.sccache ];

  environment.sessionVariables = {
    RUSTC_WRAPPER = "sccache";
    SCCACHE_DIR = "/data/sccache";
    SCCACHE_CACHE_SIZE = "1T";
  };

  systemd.tmpfiles.rules = [
    "d /data/sccache 0777 root root - -"
  ];
}
