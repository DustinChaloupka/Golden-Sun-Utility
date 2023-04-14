local zone = {}

local Chunk = require("goldensun.memory.chunk")
local Zone = Chunk.new({address = 0x0203018C, size = 8})

setmetatable(zone, {__index = Zone})

return zone
