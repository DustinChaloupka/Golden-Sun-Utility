local stepcount = {}

local Chunk = require("goldensun.memory.chunk")
local StepCount = Chunk.new({ui = {x = 0, y = 10}})

local previousCounter = 0
function StepCount:draw()
    local counter = self.counter:read()
    local color = 0xFFFFFF
    if counter ~= previousCounter then color = 0x00FF00 end
    previousCounter = counter

    drawing:set_text("Step Count: " .. self:read(), self.ui.x, self.ui.y, color)
end

function stepcount.new(o)
    local self = o or {}
    setmetatable(self, {__index = StepCount})
    self.__index = self
    return self
end

return stepcount
