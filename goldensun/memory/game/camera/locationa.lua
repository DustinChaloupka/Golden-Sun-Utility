local location = {}

local Coordinates = require("goldensun.memory.coordinates")
local Location = Coordinates.new {
    -- how do these offsets from the value at the address calculate the coordinates?
    x_offset = 0x2,
    y_offset = 0xA
}

function Location:get_z(game) return 0 end
function Location:set_z(game, z) end

function location.new(o)
    self = o or {}
    setmetatable(self, {__index = Location})
    self.__index = self
    return self
end

return location
