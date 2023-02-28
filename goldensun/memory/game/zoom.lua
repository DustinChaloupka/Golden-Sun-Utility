local zoom = {}

local Chunk = require("goldensun.memory.chunk")
local Zoom = Chunk.new()

function Zoom:lock() self:write(self.locked) end

function zoom.new(o)
    local self = o or {}
    setmetatable(self, {__index = Zoom})
    self.__index = self
    return self
end

return zoom
