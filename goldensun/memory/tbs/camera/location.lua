local location = {}

local Chunk = require("goldensun.memory.chunk")
local Coordinates = require("goldensun.memory.coordinates")
local Location = Coordinates.new {
    -- how do these offsets from the value at the address calculate the coordinates?
    x_offset = 0x2,
    y_offset = 0xA,

    -- These aren't actually used because it changes when the camera moves
    x = Chunk.new({address = 0x03002000, size = 16}),
    y = Chunk.new({address = 0x03002000, size = 16}),
    z = nil
}

function Location:get_z(game) return 0 end
function Location:set_z(game, z) end

setmetatable(location, {__index = Location})

return location
