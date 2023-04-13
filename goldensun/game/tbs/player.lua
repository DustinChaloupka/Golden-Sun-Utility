local player = {}

local Player = require("goldensun.game.player").new {
    character_data = require("goldensun.memory.game.tbs.player.characterdata")
}

function Player:is_pp_lock_character() return self.id == 0 end

setmetatable(player, {__index = Player})

return player
