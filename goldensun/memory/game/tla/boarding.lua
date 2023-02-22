local boarding = {}

local Chunk = require("goldensun.memory.chunk")
local Boarding = Chunk.new {address = 0x020004B6, size = 8, aboard = 1}

function Boarding:is_aboard(game) return self:read(game) == self.aboard end

function Boarding:board(game) self:write(game, self.aboard) end

setmetatable(boarding, {__index = Boarding})

return boarding
