local steprate = {}

local Chunk = require("goldensun.memory.chunk")
local StepRate = Chunk.new {
    ui = {
        analysis = {
            x = {pos = 20, interval = 60},
            y = {pos = 10, interval = 75}
        },
        x = 0,
        y = 0
    },
    current_rate = "",
    color = 0xFFFFFF
}

-- Rate of change in color to go with rate of 0-30? Old utility script did, but was
-- really difficult to understand and used RGB tables
local function get_color(rate)
    if rate == "" then
        return 0xFFFFFF
    elseif rate <= 10 then
        return 0x0000FF
    elseif rate <= 20 then
        return 0x00FF00
    elseif rate <= 30 then
        return 0xFF0000
    end
end

function StepRate:draw_analysis(grn, advances, column, row)
    local rate = self:read()
    if rate == "" then
        local rn = require("goldensun.memory.game.randomnumber").new {
            value = grn.value
        }
        rn:next(advances)
        local rate, color = self:prediction(rn)
        drawing:set_text("Rate:" .. rate, self.ui.analysis.x.pos +
                             self.ui.analysis.x.interval * column, self.ui
                             .analysis.y.pos + self.ui.analysis.y.interval * row,
                         color)
    end
end

function StepRate:draw()
    local rate = self:read() -- normalized
    local color = get_color(rate)
    if rate ~= self.current_rate then self.current_rate = rate end

    drawing:set_text("Step Rate: " .. rate, self.ui.x, self.ui.y, color)
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
    local rate = self:normalize(prediction)
    return rate, get_color(rate)
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
