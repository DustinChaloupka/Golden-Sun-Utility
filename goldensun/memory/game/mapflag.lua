local mapflag = {}

local Chunk = require("goldensun.memory.chunk")
local MapFlag = Chunk.new()

function MapFlag:is_enabled()
    return emulator:band(self:read(), 1) == self.enabled
end

function mapflag.new(o)
    local self = o or {}
    setmetatable(self, {__index = MapFlag})
    self.__index = self
    return self
end

return mapflag
