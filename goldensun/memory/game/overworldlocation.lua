local overworldlocation = {}

local Coordinates = require("goldensun.memory.coordinates")
local OverworldLocation = Coordinates.new()

function OverworldLocation:get_z(game) return 0 end
function OverworldLocation:set_z(game, z) end

function overworldlocation.new(o)
    local self = o or {}
    setmetatable(self, {__index = OverworldLocation})
    self.__index = self
    return self
end

return overworldlocation
