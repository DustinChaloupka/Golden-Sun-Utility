local camera = {}

local Chunk = require("goldensun.memory.chunk")
local Camera = Chunk.new()

local function update_location(self)
    local value = self:read()
    self.location.x.address = value + self.location.x_offset
    self.location.y.address = value + self.location.y_offset
end

function Camera:get_location()
    update_location(self)
    return self.location
end

function Camera:set_location(location)
    update_location(self)
    self.location:set_location(location)
end

function Camera:add_speed(speed)
    update_location(self)
    self.location:add_speed(speed)
end

function camera.new(o)
    local self = o or {}
    setmetatable(self, {__index = Camera})
    self.__index = self
    return self
end

return camera
