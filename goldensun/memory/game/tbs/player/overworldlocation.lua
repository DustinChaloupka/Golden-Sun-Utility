local overworldlocation = {}

local Chunk = require("goldensun.memory.chunk")
local OverworldLocation =
    require("goldensun.memory.game.overworldlocation").new {
        x = Chunk.new({address = 0x02030DAE, size = 16}),
        y = Chunk.new({address = 0x02030DB6, size = 16}),
        z = nil
    }

setmetatable(overworldlocation, {__index = OverworldLocation})

return overworldlocation
