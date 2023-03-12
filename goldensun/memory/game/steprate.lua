local steprate = {}

local Chunk = require("goldensun.memory.chunk")
local StepRate = Chunk.new {
    ui = {x = 0, y = 0},
    current_rate = "",
    color = 0xFFFFFF
}

function StepRate:draw(is_overworld)
    drawing:set_text("Step Rate: " .. self.current_rate, self.ui.x, self.ui.y,
                     self.color)

    local rate = self:read() -- normalized
    if rate ~= self.current_rate then
        self.current_rate = rate

        -- Rate of change in color to go with rate of 0-30? Old Utility script did, but was
        -- really difficult to understand and used RGB tables
        if rate == "" then
            self.color = 0xFFFFFF
        elseif rate <= 10 then
            self.color = 0x0000FF
        elseif rate <= 20 then
            self.color = 0x00FF00
        elseif rate <= 30 then
            self.color = 0xFF0000
        end
    end
end

function StepRate:normalize(rate)
    if rate == 0 then return "" end

    -- Unsure how all of these were calculated
    if rate >= 0xFFFF0000 then rate = rate - 0xFFFFFFFF end
    return math.floor((0xFFFF - rate) / 0xFF0)
end

function StepRate:prediction(rn)
    rn:next(1)
    local rate1 = math.floor(rn:generate())
    rn:next(1)
    local rate2 = math.floor(rn:generate())
    rn:next(1)
    local rate3 = math.floor(rn:generate())
    rn:next(1)
    local rate4 = math.floor(rn:generate())
    local prediction = math.floor(rate1 - rate2 + rate3 - rate4) / 2
    return self:normalize(prediction)
end

-- Normalizes the step rate value to something between 0 and 30, 0 being
-- a slow rate, 30 being a fast rate
function StepRate:read() return self:normalize(self:read_offset(0)) end

function steprate.new(o)
    local self = o or {}
    setmetatable(self, {__index = StepRate})
    self.__index = self
    return self
end

return steprate
