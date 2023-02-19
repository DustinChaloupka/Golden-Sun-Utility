local coordinates = {}

local Coordinates = {}

function Coordinates:get_x(game) return self.x:read(game) end
function Coordinates:get_y(game) return self.y:read(game) end
function Coordinates:get_z(game) return self.z:read(game) end
function Coordinates:set_x(game, x) self.x:write(game, x) end
function Coordinates:set_y(game, y) self.y:write(game, y) end
function Coordinates:set_z(game, z) self.z:write(game, z) end
function Coordinates:get_location(game)
    return {x = self:get_x(game), y = self:get_y(game), z = self:get_z(game)}
end
function Coordinates:set_location(game, location)
    self:set_x(game, location.x)
    self:set_y(game, location.y)
    self:set_z(game, location.z)
end

function coordinates.new(o)
    local self = o or {}
    setmetatable(self, {__index = Coordinates})
    self.__index = self
    return self
end

return coordinates
