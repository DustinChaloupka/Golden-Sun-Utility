local mapflag = {}

local Chunk = require("goldensun.memory.chunk")
local MapFlag = Chunk.new({address = 0x02030CA2, size = 8, enabled = 1})

function MapFlag:is_enabled(game)
    return bit.band(self:read(game), 1) == self.enabled
end

setmetatable(mapflag, {__index = MapFlag})

return mapflag
