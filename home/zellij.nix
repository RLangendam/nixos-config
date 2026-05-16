{ config, pkgs, ... }:
{
  programs.zellij.enable = true;

  home.file.".config/zellij/config.kdl".text = ''
    keybinds clear-defaults=true {
      normal {
        bind "Ctrl g" { SwitchToMode "locked"; }
        bind "Ctrl p" { SwitchToMode "pane"; }
        bind "Ctrl t" { SwitchToMode "tab"; }
        bind "Ctrl r" { SwitchToMode "resize"; }
        bind "Alt n" { NewPane; }
        bind "Alt s" { NewPane "Down"; }
        bind "Alt v" { NewPane "Right"; }
      }
      pane {
        bind "Ctrl p" { SwitchToMode "normal"; }
        bind "h" "Left" { MoveFocusOrPreviousTab "Left"; }
        bind "j" "Down" { MoveFocus "Down"; }
        bind "k" "Up" { MoveFocus "Up"; }
        bind "l" "Right" { MoveFocusOrNextTab "Right"; }
        bind "n" { NewPane; }
        bind "s" { NewPane "Down"; }
        bind "v" { NewPane "Right"; }
        bind "d" { CloseFocus; }
      }
      tab {
        bind "Ctrl t" { SwitchToMode "normal"; }
        bind "n" { NewTab; }
        bind "h" "Left" { GoToPreviousTab; }
        bind "l" "Right" { GoToNextTab; }
        bind "d" { CloseTab; }
      }
      resize {
        bind "Ctrl r" { SwitchToMode "normal"; }
        bind "h" "Left" { Resize "Left"; }
        bind "j" "Down" { Resize "Down"; }
        bind "k" "Up" { Resize "Up"; }
        bind "l" "Right" { Resize "Right"; }
      }
    }

    themes {
      tokyo-night {
        fg      "#c0caf5"
        bg      "#1a1b26"
        red     "#f7768e"
        green   "#9ece6a"
        blue    "#7aa2f7"
        yellow  "#e0af68"
        magenta "#bb9af7"
        cyan    "#7dcfff"
        black   "#1a1b26"
        white   "#c0caf5"
      }
    }

    theme "tokyo-night"
  '';
}
