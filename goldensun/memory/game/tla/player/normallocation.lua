local normallocation = {}

local Chunk = require("goldensun.memory.chunk")
local NormalLocation = require("goldensun.memory.game.normallocation").new {
    x = Chunk.new({address = 0x020322F6, size = 16}),
    y = Chunk.new({address = 0x020322FE, size = 16}),
    z = nil
}

setmetatable(normallocation, {__index = NormalLocation})

return normallocation
