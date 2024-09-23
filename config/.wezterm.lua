local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font("Operator Mono Lig Book")
config.line_height = 1.2
-- config.enable_wayland = false
config.window_background_opacity = 0.9

config.keys = {
  {
    key = 'n',
    mods = 'CTRL',
    action = wezterm.action.SplitHorizontal,
  },
  {
    key = ',',
    mods = 'CTRL',
    action = wezterm.action.SplitVertical,
  },
}

return config
