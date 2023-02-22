local location = {}

local Chunk = require("goldensun.memory.chunk")
local Location = require("goldensun.memory.game.camera.location").new {
    -- These aren't actually used because it changes when the camera moves
    x = Chunk.new({address = 0x03002000, size = 16}),
    y = Chunk.new({address = 0x03002000, size = 16}),
    z = nil
}

setmetatable(location, {__index = Location})

return location
