local tbs = {}

local Game = require("goldensun.game")
local TBS = Game.new {
    camera = 0x03002000,
    collision = {0x0800F3B0},
    coordinates = {xMapCursor = 0x02010006, yMapCursor = 0x0201000A},
    encounters = 0x02000478,
    field_player = require("goldensun.tbs.fieldplayer"),
    map = require("goldensun.memory.tbs.map"),
    mapFlag = 0x02030CB6,
    move_type = require("goldensun.memory.tbs.movetype"),
    player = require("goldensun.tbs.player"),
    rom = 0x646C6F47,
    zoom_lock = require("goldensun.memory.tbs.zoomlock")
}

-- what is this actually doing?
local function cursor_shift(cursor) return bit.lshift(cursor, 8) end

function TBS:calculate_map_x(cursor) return cursor_shift(cursor) / 15 + 0x1000 end

function TBS:calculate_map_y(cursor) return cursor_shift(cursor) / 10 end

setmetatable(tbs, {__index = TBS})

return tbs
