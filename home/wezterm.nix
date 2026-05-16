{ config, pkgs, ... }:
{
  programs.wezterm.enable = true;
  programs.wezterm.extraConfig = ''
    local config = wezterm.config_builder()

    config.color_scheme = "Tokyo Night"
    config.font = wezterm.font_with_fallback({
      "JetBrainsMono Nerd Font Mono",
      "Symbols Nerd Font",
      "Segoe UI Emoji",
    })
    config.font_size = 11
    config.line_height = 1.1
    config.window_padding = {
      left = 10,
      right = 10,
      top = 10,
      bottom = 10,
    }
    config.window_background_opacity = 1.0
    config.enable_tab_bar = true
    config.tab_bar_at_bottom = true
    config.default_prog = { 'zsh' }

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

  # programs.wezterm = {
  #   enable = true;
  #   extraConfig = ''
  #     local config = wezterm.config_builder()

  #     config.color_scheme = "Tokyo Night"
  #     config.font = wezterm.font_with_fallback({
  #       "JetBrainsMono Nerd Font Mono",
  #       "Symbols Nerd Font",
  #       "Segoe UI Emoji",
  #     })
  #     config.font_size = 11
  #     config.line_height = 1.1
  #     config.window_padding = {
  #       left = 10,
  #       right = 10,
  #       top = 10,
  #       bottom = 10,
  #     }
  #     config.window_background_opacity = 1.0
  #     config.enable_tab_bar = true
  #     config.tab_bar_at_bottom = true
  #     config.default_prog = { 'zsh' }

  #     -- Key bindings
  #     config.leader = { key = 'a', mods = 'CTRL' }
  #     local act = wezterm.action
  #     config.keys = {
  #       { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  #       { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  #       { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  #       { key = '|', mods = 'LEADER|SHIFT', action = act.SplitPane { direction = 'Right' } },
  #       { key = '-', mods = 'LEADER', action = act.SplitPane { direction = 'Down' } },
  #     }

  #     return config
  #   '';
  # };
}
