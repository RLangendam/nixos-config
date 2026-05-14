{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    prefix = "C-a";
    extraConfig = ''
      set -g default-terminal "screen-256color"
      set -ga terminal-overrides ",xterm-256color:RGB"
      
      # Bindings
      unbind C-b
      bind-key C-a send-prefix
      
      # Window and pane splitting
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      
      # Pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      
      # Window navigation
      bind n next-window
      bind p previous-window
      
      # Vi copy mode
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection
    '';
  };
}
