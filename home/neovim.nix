{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile."nvim".source = ./nvim;

  home.packages = with pkgs; [
    # LSPs
    rust-analyzer # Rust
    nil # Nix
    lua-language-server # Lua
    bash-language-server # Bash

    # Formatters & Linters
    rustfmt # Rust
    alejandra # Nix
    stylua # Lua
    shfmt # Bash
  ];
}
