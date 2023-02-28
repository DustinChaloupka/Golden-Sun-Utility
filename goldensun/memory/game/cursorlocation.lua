local cursorlocation = {}

local Coordinates = require("goldensun.memory.coordinates")
local CursorLocation = Coordinates.new()

function CursorLocation:get_z() return 0 end
function CursorLocation:set_z(z) end

function cursorlocation.new(o)
    local self = o or {}
    setmetatable(self, {__index = CursorLocation})
    self.__index = self
    return self
end

return cursorlocation
