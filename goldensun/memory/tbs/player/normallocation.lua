local normallocation = {}

local Chunk = require("goldensun.memory.chunk")
local Coordinates = require("goldensun.memory.coordinates")
local NormalLocation = Coordinates.new {
    x = Chunk.new({address = 0x02030EC6, size = 16}),
    y = Chunk.new({address = 0x02030ECE, size = 16}),
    z = nil
}

function NormalLocation:get_z(game) return 0 end
function NormalLocation:set_z(game, z) end

setmetatable(normallocation, {__index = NormalLocation})

return normallocation