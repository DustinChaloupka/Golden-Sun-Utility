local normallocation = {}

local Coordinates = require("goldensun.memory.coordinates")
local NormalLocation = Coordinates.new()

function NormalLocation:get_z(game) return 0 end
function NormalLocation:set_z(game, z) end

function normallocation.new(o)
    local self = o or {}
    setmetatable(self, {__index = NormalLocation})
    self.__index = self
    return self
end

return normallocation
