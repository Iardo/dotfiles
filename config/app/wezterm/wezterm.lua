local wezterm = require "wezterm"
local config = wezterm.config_builder()

-- Quake Mode
config.unix_domains = {
  {
    name = 'quake',
  }
}

config.audible_bell = "Disabled"
config.default_prog = { "zsh" }
config.enable_wayland = false
config.front_end = "WebGpu"
config.window_background_opacity = 1.0

return config
