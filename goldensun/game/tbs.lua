local tbs = {}

local Game = require("goldensun.game")
local TBS = Game.new {
    camera = require("goldensun.memory.game.tbs.camera"),
    encounters = require("goldensun.memory.game.tbs.encounters"),
    field_player = require("goldensun.game.tbs.fieldplayer"),
    map = require("goldensun.memory.game.tbs.map"),
    movement = require("goldensun.memory.game.tbs.movement"),
    overworld_map = require("goldensun.game.tbs.overworldmap"),
    party = require("goldensun.game.tbs.party"),
    random_number = {
        battle = require("goldensun.memory.game.tbs.randomnumber.battle"),
        general = require("goldensun.memory.game.tbs.randomnumber.general")
    },
    rom = require("goldensun.memory.game.tbs.rom"),
    zoom = require("goldensun.memory.game.tbs.zoom")
}

-- what are these values?
local function cursor_shift(cursor) return emulator:lshift(cursor, 8) end
function TBS:calculate_map_location(location)
    return {
        x = cursor_shift(location.x) / 853,
        y = cursor_shift(location.y) / 640
    }
end

function TBS:specific_checks() end

setmetatable(tbs, {__index = TBS})

return tbs
