local wezterm = require "wezterm"
local config = wezterm.config_builder()

-- Quake Mode
-- config.unix_domains = {
--   {
--     name = 'quake',
--   }
-- }

config = {
    default_prog = { 'powershell.exe', '-NoLogo' },
    -- launch_menu = {
    --     { label = "PowerShell 7",         args = { "pwsh.exe" } },
    --     { label = "PowerShell 7 (Admin)", args = { "pwsh.exe" } },
    --     { label = "Git Bash",             args = { "C:\\Program Files\\Git\\bin\\bash.exe", "-l" } },
    --     { label = "Windows PowerShell",   args = { "powershell.exe" } },
    --     { label = "CMD",                  args = { "cmd.exe" } },
    -- },

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
