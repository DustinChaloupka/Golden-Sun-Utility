local steprate = {}

local Chunk = require("goldensun.memory.chunk")
local StepRate = Chunk.new({ui = {x = 0, y = 10}})

function StepRate:draw()
    drawing:set_text("Step Rate: " .. self:read(), self.ui.x, self.ui.y)
end

-- Normalizes the step rate value to something between 0 and 30, 0 being
-- a slow rate, 30 being a fast rate
function StepRate:read()
    local value = self:read_offset(0)
    if value == 0 then return "" end

    -- Unsure how all of these were calculated
    if value >= 0xFFFF0000 then value = value - 0xFFFFFFFF end
    return math.floor((0xFFFF - value) / 0xFF0)
end

function steprate.new(o)
    local self = o or {}
    setmetatable(self, {__index = StepRate})
    self.__index = self
    return self
end

return steprate
