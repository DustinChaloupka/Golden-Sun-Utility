local player = {}

local Player = {}

function Player:get_current_pp()
    return self.character_data:get_current_pp(self.id)
end

function Player:set_current_pp(value)
    self.character_data:set_current_pp(self.id, value)
end

function Player:get_level() return self.character_data:get_level(self.id) end

function player.new(o)
    local self = o or {}
    setmetatable(self, {__index = Player})
    self.__index = self
    return self
end

return player
