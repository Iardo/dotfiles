local mp = require 'mp'

local COMMAND_NEXT = 'playlist-next ; show-text "${playlist-pos-1}/${playlist-count}"'
local COMMAND_PREV = 'playlist-prev ; show-text "${playlist-pos-1}/${playlist-count}"'

local function is_image()
  local image = mp.get_property_native('current-tracks/video/image')
  local album_art = mp.get_property_native('current-tracks/video/albumart')
  return image == true and album_art ~= true
end

local function step(command)
  return function(event)
    if event.event == 'repeat' and not is_image() then
      return
    end
    if event.event == 'down' or event.event == 'press' or event.event == 'repeat' then
      mp.command(command)
    end
  end
end

mp.add_key_binding(nil, 'next', step(COMMAND_NEXT), { complex = true, repeatable = true })
mp.add_key_binding(nil, 'prev', step(COMMAND_PREV), { complex = true, repeatable = true })
