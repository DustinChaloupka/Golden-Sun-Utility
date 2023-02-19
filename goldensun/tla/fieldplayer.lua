local fieldplayer = {}

local FieldPlayer = {
    normal_location = require("goldensun.memory.tla.player.normallocation"),
    overworld_location = require("goldensun.memory.tla.player.overworldlocation")
}

function FieldPlayer:get_normal_location(game)
    return self.overworld_location:get_location(game)
end

function FieldPlayer:get_overworld_location(game)
    return self.overworld_location:get_location(game)
end

function FieldPlayer:set_overworld_location(game, location)
    self.overworld_location:set_location(game, location)
end

function FieldPlayer:set_normal_location(game, location)
    self.normal_location:set_location(game, location)
end

setmetatable(fieldplayer, {__index = FieldPlayer})

return fieldplayer
