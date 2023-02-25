local lock = {}

local Chunk = require("goldensun.memory.chunk")
local Lock = Chunk.new({address = 0x02000498, size = 16})

setmetatable(lock, {__index = Lock})

return lock
