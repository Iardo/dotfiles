local wezterm = require "wezterm"
local config = wezterm.config_builder()

-- Quake Mode
config.unix_domains = {
  {
    name = 'quake',
  }
}

config.default_prog = { "zsh" }
config.front_end = "WebGpu"
config.enable_wayland = false
config.window_background_opacity = 1.0

return config
