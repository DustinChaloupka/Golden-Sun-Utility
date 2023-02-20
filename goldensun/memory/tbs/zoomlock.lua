local zoomlock = {}

local Chunk = require("goldensun.memory.chunk")
local ZoomLock = Chunk.new({address = 0x03001CF5, size = 8})

setmetatable(zoomlock, {__index = ZoomLock})

return zoomlock
