local player = {}

local Player = {}

function Player:get_current_pp(game)
    return self.character_data:get_current_pp(game, self.id)
end

function Player:set_current_pp(game, value)
    self.character_data:set_current_pp(game, self.id, value)
end

function player.new(o)
    local self = o or {}
    setmetatable(self, {__index = Player})
    self.__index = self
    return self
end

return player
