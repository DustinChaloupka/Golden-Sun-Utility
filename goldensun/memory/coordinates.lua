local coordinates = {}

local Coordinates = {}

function Coordinates:get_x() return self.x:read() end
function Coordinates:get_y() return self.y:read() end
function Coordinates:get_z() return self.z:read() end
function Coordinates:set_x(x) self.x:write(x) end
function Coordinates:set_y(y) self.y:write(y) end
function Coordinates:set_z(z) self.z:write(z) end
function Coordinates:get_location()
    return {x = self:get_x(), y = self:get_y(), z = self:get_z()}
end
function Coordinates:set_location(location)
    self:set_x(location.x)
    self:set_y(location.y)
    self:set_z(location.z)
end

function Coordinates:add_speed(speed)
    local location = self:get_location()
    location.x = location.x + speed.x
    location.y = location.y + speed.y
    location.z = location.z + speed.z
    self:set_location(location)
end

function coordinates.new(o)
    local self = o or {}
    setmetatable(self, {__index = Coordinates})
    self.__index = self
    return self
end

return coordinates
