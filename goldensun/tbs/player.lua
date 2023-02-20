local player = {}

local Player = {
    character_data = require("goldensun.memory.tbs.player.characterdata")
}

function Player:get_current_pp(game)
    return self.character_data:get_current_pp(game, self.id)
end

function Player:set_current_pp(game, value)
    self.character_data:set_current_pp(game, self.id, value)
end

setmetatable(player, {__index = Player})

return player
