local overworldlocation = {}

local Chunk = require("goldensun.memory.chunk")
local Coordinates = require("goldensun.memory.coordinates")
local OverworldLocation = Coordinates.new {
    x = Chunk.new({address = 0x020321C2, size = 16}),
    y = Chunk.new({address = 0x020321CA, size = 16}),
    z = nil
}

function OverworldLocation:get_z(game) return 0 end
function OverworldLocation:set_z(game, z) end

setmetatable(overworldlocation, {__index = OverworldLocation})

return overworldlocation
