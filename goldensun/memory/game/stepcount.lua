local stepcount = {}

local Chunk = require("goldensun.memory.chunk")
local StepCount = Chunk.new({ui = {x = 0, y = 0}})

local previousCounterValue = 0
function StepCount:draw()
    local counterValue = self.counter:read()
    local color = "white"
    if counterValue ~= previousCounterValue then color = "green" end
    previousCounterValue = counterValue

    drawing:set_text("Step Count: " .. self:read(), self.ui.x, self.ui.y, color)
end

function stepcount.new(o)
    local self = o or {}
    setmetatable(self, {__index = StepCount})
    self.__index = self
    return self
end

return stepcount
