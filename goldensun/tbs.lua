local tbs = {}

local Game = require("goldensun.game")
local TBS = Game.new {
    camera = require("goldesun.memory.tbs.camera"),
    collision = {0x0800F3B0},
    encounters = 0x02000478,
    field_player = require("goldensun.tbs.fieldplayer"),
    map = require("goldensun.memory.tbs.map"),
    mapFlag = 0x02030CB6,
    move_type = require("goldensun.memory.tbs.movetype"),
    overworld_map = require("goldensun.tbs.overworldmap"),
    player = require("goldensun.tbs.player"),
    rom = 0x646C6F47,
    zoom_lock = require("goldensun.memory.tbs.zoomlock")
}

-- what are these values?
local function cursor_shift(cursor) return bit.lshift(cursor, 8) end
function TBS:calculate_map_location(location)
    return {
        x = cursor_shift(location.x) / 853,
        y = cursor_shift(location.y) / 640
    }
end

setmetatable(tbs, {__index = TBS})

return tbs
