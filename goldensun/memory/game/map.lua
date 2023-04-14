local map = {}

local Chunk = require("goldensun.memory.chunk")
local Map = Chunk.new()

function Map:is_battle() return self:read() == self.battle end
function Map:is_overworld() return self:read() == self.world end
function Map:get_zones() return self.zone:read(), self.zone:read_offset(1) end

function map.new(o)
    local self = o or {}
    setmetatable(self, {__index = Map})
    self.__index = self
    return self
end

return map
