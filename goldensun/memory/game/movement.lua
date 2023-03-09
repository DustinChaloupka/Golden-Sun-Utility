local movement = {}

local Movement = {}

function movement.new(o)
    local self = o or {}
    setmetatable(self, {__index = Movement})
    self.__index = self
    return self
end

return movement
