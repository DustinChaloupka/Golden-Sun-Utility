local fieldplayer = {}

local FieldPlayer = require("goldensun.game.fieldplayer").new {
    normal_location = require("goldensun.memory.game.tla.player.normallocation"),
    overworld_location = require(
        "goldensun.memory.game.tla.player.overworldlocation")
}

setmetatable(fieldplayer, {__index = FieldPlayer})

return fieldplayer
