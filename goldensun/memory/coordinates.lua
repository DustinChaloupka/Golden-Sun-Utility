local coordinates = {}

local Coordinates = {}

function Coordinates:get_x(game) return self.x:read(game) end
function Coordinates:get_y(game) return self.y:read(game) end
function Coordinates:get_z(game) return self.z:read(game) end
function Coordinates:set_x(game, x) self.x:write(game, x) end
function Coordinates:set_y(game, y) self.y:write(game, y) end
function Coordinates:set_z(game, z) self.z:write(game, z) end

function coordinates.new(o)
    local self = o or {}
    setmetatable(self, {__index = Coordinates})
    self.__index = self
    return self
end

return coordinates
