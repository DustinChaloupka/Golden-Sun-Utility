local map = {}

local Chunk = require("goldensun.memory.chunk")
local Map = Chunk.new()

function Map:is_overworld(game) return self:read(game) == self.world end

function map.new(o)
    local self = o or {}
    setmetatable(map, {__index = Map})
    self.__index = self
    return self
end

return map
