local wezterm = require "wezterm"
local config = wezterm.config_builder()

-- Quake Mode
-- config.unix_domains = {
--   {
--     name = 'quake',
--   }
-- }

config = {
	audible_bell = "Disabled",
	-- default_prog = { "zsh" }
	-- enable_wayland = false
	-- front_end = "WebGpu"
	visual_bell = {
    fade_in_duration_ms = 0,
    fade_out_duration_ms = 0,
	},
	window_background_opacity = 1.0,
	window_padding = {
    left = '1cell',
    right = '1cell',
    top = 0,
		bottom = 0,
	},
}

return config
