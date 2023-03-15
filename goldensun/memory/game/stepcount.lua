local stepcount = {}

local Chunk = require("goldensun.memory.chunk")
local StepCount = Chunk.new({ui = {x = 0, y = 10, analysis = {x = 70, y = 0}}})

function StepCount:draw_at(x, y)
    local counter = self.counter:read()
    local color = 0xFFFFFF
    if counter ~= self.previousCounter then color = 0x00FF00 end
    self.previousCounter = counter

    drawing:set_text("Step Count: " .. self:read(), x, y, color)
end

function StepCount:draw() self:draw_at(self.ui.x, self.ui.y) end

function StepCount:draw_analysis()
    self:draw_at(self.ui.analysis.x, self.ui.analysis.y)
end

function stepcount.new(o)
    local self = o or {}
    setmetatable(self, {__index = StepCount})
    self.__index = self
    return self
end

return stepcount
