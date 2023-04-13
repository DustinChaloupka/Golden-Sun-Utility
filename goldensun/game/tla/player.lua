local player = {}

local Player = require("goldensun.game.player").new {
    character_data = require("goldensun.memory.game.tla.player.characterdata")
}

function Player:is_pp_lock_character() return self.id == 4 end

function player.new(o)
    local self = o or {}
    setmetatable(self, {__index = Player})
    self.__index = self
    return self
end

return player
