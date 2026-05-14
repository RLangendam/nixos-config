{ config, pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local config = wezterm.config_builder()

      config.color_scheme = "Tokyo Night"
      config.font = wezterm.font("JetBrains Mono")
      config.font_size = 11
      config.window_padding = {
        left = 10,
        right = 10,
        top = 10,
        bottom = 10,
      }
      config.window_background_opacity = 0.95
      config.enable_tab_bar = true
      config.tab_bar_at_bottom = true

      -- Key bindings
      config.leader = { key = 'a', mods = 'CTRL' }
      local act = wezterm.action
      config.keys = {
        { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
        { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
        { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
        { key = '|', mods = 'LEADER|SHIFT', action = act.SplitPane { direction = 'Right' } },
        { key = '-', mods = 'LEADER', action = act.SplitPane { direction = 'Down' } },
      }

      return config
    '';
  };
}
