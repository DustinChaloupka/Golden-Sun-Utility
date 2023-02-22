local player = {}

local Player = require("goldensun.game.player").new {
    character_data = require("goldensun.memory.game.tla.player.characterdata")
}

setmetatable(player, {__index = Player})

return player
