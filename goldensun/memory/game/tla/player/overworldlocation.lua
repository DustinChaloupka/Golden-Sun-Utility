local overworldlocation = {}

local Chunk = require("goldensun.memory.chunk")
local OverworldLocation =
    require("goldensun.memory.game.overworldlocation").new {
        x = Chunk.new({address = 0x020321C2, size = 16}),
        y = Chunk.new({address = 0x020321CA, size = 16}),
        z = nil
    }

setmetatable(overworldlocation, {__index = OverworldLocation})

return overworldlocation
