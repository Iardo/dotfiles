local wezterm = require "wezterm"
local config = wezterm.config_builder()

-- Quake Mode
-- config.unix_domains = {
--   {
--     name = 'quake',
--   }
-- }

config.audible_bell = "Disabled"
-- config.default_prog = { "zsh" }
-- config.enable_wayland = false
-- config.front_end = "WebGpu"
config.window_background_opacity = 1.0
config.window_padding = {
  left = 2,
  right = 2,
  top = 0,
  bottom = 0,
}

return config
