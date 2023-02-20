local cursorlocation = {}

local Chunk = require("goldensun.memory.chunk")
local Coordinates = require("goldensun.memory.coordinates")
local CursorLocation = Coordinates.new {
    x = Chunk.new({address = 0x02010006, size = 16}),
    y = Chunk.new({address = 0x0201000A, size = 16}),
    z = nil
}

function CursorLocation:get_z(game) return 0 end
function CursorLocation:set_z(game, z) end

setmetatable(cursorlocation, {__index = CursorLocation})

return cursorlocation
