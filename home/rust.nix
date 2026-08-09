{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    cargo
    cargo-binstall
    cargo-generate
  ];
}
