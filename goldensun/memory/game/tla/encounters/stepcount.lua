local stepcount = {}

local Chunk = require("goldensun.memory.chunk")
local StepCount = Chunk.new({address = 0x0200049A, size = 16})

setmetatable(stepcount, {__index = StepCount})

return stepcount
