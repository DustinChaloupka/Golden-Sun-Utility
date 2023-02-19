local map = {}

local Chunk = require("goldensun.memory.chunk")
local Map = Chunk.new {address = 0x02000400, size = 16, overworld = 2}

function Map:is_overworld(game) return self:read(game) == self.overworld end

setmetatable(map, {__index = Map})

return map
