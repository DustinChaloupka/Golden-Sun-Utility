local camera = {}

local Chunk = require("goldensun.memory.chunk")
local Camera = Chunk.new {
    address = 0x03002000,
    size = 32,

    location = require("goldensun.memory.tbs.camera.location")
}

local function update_location(self, game)
    local value = self:read(game)
    self.location.x.address = value + self.location.x_offset
    self.location.y.address = value + self.location.y_offset
end

function Camera:get_location(game)
    update_location(self, game)
    return self.location
end

function Camera:set_location(game, location)
    update_location(self, game)
    self.location:set_location(game, location)
end

setmetatable(camera, {__index = Camera})

return camera
