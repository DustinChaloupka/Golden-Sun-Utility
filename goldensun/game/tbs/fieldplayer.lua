local fieldplayer = {}

local FieldPlayer = require("goldensun.game.fieldplayer").new {
    normal_location = require("goldensun.memory.tbs.player.normallocation"),
    overworld_location = require("goldensun.memory.tbs.player.overworldlocation")
}

setmetatable(fieldplayer, {__index = FieldPlayer})

return fieldplayer
