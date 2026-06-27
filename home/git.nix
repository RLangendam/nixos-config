{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    settings = {
      user = {
        name = "Ralph Langendam";
        email = "rlangendam@gmail.com";
      };
      lfs.enable = true;
    };
  };
}
