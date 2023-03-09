local tick = {}

local Chunk = require("goldensun.memory.chunk")
local Tick = Chunk.new({ui = {x = 0, y = 40}})

function Tick:draw()
    drawing:set_text("Movement Tick: " .. (math.floor(self:read() / 0xFFF)),
                     self.ui.x, self.ui.y)
end

function tick.new(o)
    local self = o or {}
    setmetatable(self, {__index = Tick})
    self.__index = self
    return self
end

return tick

