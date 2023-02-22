local camera = {}

local Chunk = require("goldensun.memory.chunk")
local Camera = Chunk.new()

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

function Camera:add_speed(game, speed)
    update_location(self, game)
    self.location:add_speed(game, speed)
end

function camera.new(o)
    local self = o or {}
    setmetatable(self, {__index = Camera})
    self.__index = self
    return self
end

return camera
