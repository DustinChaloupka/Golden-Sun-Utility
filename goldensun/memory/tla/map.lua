local map = {}

local Chunk = require("goldensun.memory.chunk")
local Map = Chunk.new {
    address = 0x02000420,
    size = 16,

    world = 2,
    sea_of_time_a = 197,
    sea_of_time_b = 198,
    northern_reaches = 268
}

function Map:is_overworld(game) return self:read(game) == self.world end

function Map:is_normal_ship(game)
    local value = self:read(game)
    return
        value == self.sea_of_time_a or value == self.sea_of_time_b or value ==
            self.northern_reaches
end

setmetatable(map, {__index = Map})

return map
