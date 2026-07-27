{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
    ];
  };

  xdg.configFile."nvim".source = ./nvim;

  home.packages = with pkgs; [
    # LSP servers (globaal, behalve Rust toolchain)
    nil # nix
    lua-language-server
    bash-language-server

    # formatters
    nixfmt
    stylua
    shfmt
    nixdoc

    # tools
    ripgrep
    fd
  ];
}
