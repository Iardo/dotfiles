local core = require "core"
local keymap = require "core.keymap"
local config = require "core.config"
local styles = require "core.style"

-- NOTE
--------------------
-- DATADIR is the location of the installed Lua code.
-- USERDIR is the location of the configuration directory.


-- General
--------------------
config.ignore_files = {}
config.disable_blink = true

-- Themes
--------------------
core.reload_module("colors.uaihu")

styles.font = renderer.font.group {
  renderer.font.load(USERDIR.."/fonts/iosevka-custom-regular.ttf", 18 * SCALE,
    {antialiasing="subpixel", hinting="full", bold=false, italic=false, underline=false, smoothing=false, strikethrough=false}),
}
styles.code_font = renderer.font.group {
  renderer.font.load(USERDIR.."/fonts/iosevka-custom-regular.ttf", 22 * SCALE,
    {antialiasing="subpixel", hinting="full", bold=false, italic=false, underline=false, smoothing=false, strikethrough=false}),
}

-- Plugins
--------------------
config.plugins.detectindent = true
