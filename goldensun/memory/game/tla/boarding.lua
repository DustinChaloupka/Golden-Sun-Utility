local boarding = {}

local Chunk = require("goldensun.memory.chunk")
local Boarding = Chunk.new({address = 0x020004B6, size = 8, aboard = 1})

function Boarding:is_aboard() return self:read() == self.aboard end

function Boarding:board() self:write(self.aboard) end

setmetatable(boarding, {__index = Boarding})

return boarding
