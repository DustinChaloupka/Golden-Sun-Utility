local player = {}

local Player = require("goldensun.game.player").new {
    character_data = require("goldensun.memory.tla.player.characterdata")
}

setmetatable(player, {__index = Player})

return player
