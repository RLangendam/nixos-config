{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    llvmPackages_latest.clang
    llvmPackages_latest.lld

    cmake
    ninja
    gnumake

    llvmPackages_latest.lldb
    valgrind

    clang-tools

    mold-wrapped
    (lib.lowPrio (symlinkJoin {
      name = "wild-filtered";
      paths = [ wild ];
      postBuild = ''
        rm -f $out/bin/ld
      '';
    }))
  ];
}
