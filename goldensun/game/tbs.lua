local tbs = {}

local Game = require("goldensun.game")
local TBS = Game.new {
    camera = require("goldensun.memory.tbs.camera"),
    encounters = require("goldensun.memory.tbs.encounters"),
    field_player = require("goldensun.game.tbs.fieldplayer"),
    map = require("goldensun.memory.tbs.map"),
    move_type = require("goldensun.memory.tbs.movetype"),
    overworld_map = require("goldensun.game.tbs.overworldmap"),
    player = require("goldensun.game.tbs.player"),
    rom = require("goldensun.memory.tbs.rom"),
    zoom = require("goldensun.memory.tbs.zoom")
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
