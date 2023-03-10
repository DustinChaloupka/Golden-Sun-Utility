local randomnumber = {}

local Chunk = require("goldensun.memory.chunk")
local RandomNumber = Chunk.new {
    advancing = {
        first_factor = 0x4e6d,
        second_factor = 0x41c6,
        increase = 0x3039
    },
    max = 0x80000000,

    frame_counter = 0
}

function RandomNumber:advance(count)
    local rn = self:read()
    for i = 1, count do
        local first_factor_advance = self.advancing.first_factor * rn
        local second_factor_advance = self.advancing.second_factor * rn
        second_factor_advance = bit.band(second_factor_advance, 0xFFFF)
        local factor_advance = first_factor_advance + second_factor_advance *
                                   0x10000
        factor_advance = bit.band(factor_advance, 0xFFFFFFFF)
        local increase_advance = factor_advance + self.advancing.increase
        rn = bit.band(increase_advance, 0xFFFFFFFF)
    end

    self:write(rn)
    self.frame_counter = 30
    self.count_change = count
    self.count_symbol = "+"
end

function RandomNumber:increase(count)
    self:write((self:read() + count) % self.max)
    self.frame_counter = 30
    self.count_change = count
    self.count_symbol = "+"
end

function RandomNumber:rewind(count) end

function RandomNumber:set_analysis_enabled(is_enabled)
    self.is_analysis_enabled = is_enabled
end

function RandomNumber:draw()
    if self.is_analysis_enabled then
        self:draw_analysis()
    else
        local text = self.letter_prefix .. "RN: " .. self:read()
        if self.frame_counter > 0 then
            text = text .. " " .. self.count_symbol .. self.count_change
            self.frame_counter = self.frame_counter - 1
        end
        drawing:set_text(text, self.ui.x, self.ui.y, self.color)
    end
end

function randomnumber.new(o)
    local self = o or {}
    setmetatable(self, {__index = RandomNumber})
    self.__index = self
    return self
end

return randomnumber
