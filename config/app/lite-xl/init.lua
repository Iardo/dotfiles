local command = require "core.command"
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
local VERSION_THEME = "v1.0"
local URL_THEME = "https://raw.githubusercontent.com/Iardo/uaihu-colorscheme/" .. VERSION_THEME .. "/build/uaihu-litexl.lua"
local PATH_THEME = USERDIR .. "/colors/uaihu.lua"

local function download_theme()
  local path_partial = PATH_THEME .. ".partial"
  local started, proc = pcall(process.start, {
    "curl", "--fail", "--silent", "--show-error", "--location",
    "--max-time", "30", "--output", path_partial, URL_THEME,
  })
  if not started then
    core.error("Uaihu: curl is not available")
    return false
  end
  local deadline = system.get_time() + 35
  while proc:running() and system.get_time() < deadline do
    system.sleep(0.05)
  end
  if proc:running() then
    proc:kill()
  end
  if proc:returncode() == 0 and os.rename(path_partial, PATH_THEME) then
    return true
  end
  os.remove(path_partial)
  core.error("Uaihu: download failed")
  return false
end

if not system.get_file_info(PATH_THEME) then
  download_theme()
end
if system.get_file_info(PATH_THEME) then
  core.reload_module("colors.uaihu")
end

command.add(nil, {
  ["uaihu:update"] = function()
    if download_theme() then
      core.reload_module("colors.uaihu")
      core.log("Uaihu: updated to " .. VERSION_THEME)
    end
  end,
})

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
config.plugins.scale.mode = "ui"
config.plugins.scale.default_scale = 2
