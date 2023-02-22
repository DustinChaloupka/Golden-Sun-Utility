local overworldlocation = {}

local Chunk = require("goldensun.memory.chunk")
local OverworldLocation =
    require("goldensun.memory.game.overworldlocation").new {
        x = Chunk.new({address = 0x02032242, size = 16}),
        y = Chunk.new({address = 0x0203224A, size = 16}),
        z = nil
    }

setmetatable(overworldlocation, {__index = OverworldLocation})

return overworldlocation
