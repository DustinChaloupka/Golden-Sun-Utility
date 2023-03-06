local stepcount = {}

local Chunk = require("goldensun.memory.chunk")
local StepCount = Chunk.new({ui = {x = 0, y = 0}})

function StepCount:draw()
    drawing:set_text("Step Count: " .. self:read(), self.ui.x, self.ui.y)
end

function stepcount.new(o)
    local self = o or {}
    setmetatable(self, {__index = StepCount})
    self.__index = self
    return self
end

return stepcount
