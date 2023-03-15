local randomnumber = {}

local Chunk = require("goldensun.memory.chunk")
local RandomNumber = Chunk.new {
    advancing = {
        factor = 0x41c64e6d,
        lower_factor = 0x4e6d,
        upper_factor = 0x41c6,
        interval = 0x3039,

        -- binary representation of factor
        factor_bits = {
            1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1,
            1, 1, 0, 0, 0, 0, 0, 1, 0
        }
    },
    max = 0x80000000,

    frame_counter = 0,

    value = 0
}

-- This is the actual value used in calculating things
function RandomNumber:generate() return
    bit.rshift(bit.lshift(self.value, 8), 16) end

-- This generates a number between 0-distribution?
function RandomNumber:distribution(distribution)
    local rng = self:generate()
    if distribution then
        return bit.rshift(rng * distribution, 16)
    else
        -- Is this just the 0-100 case?
        return bit.rshift(rng, 8)
    end
end

function RandomNumber:next(count)
    for i = 1, count do
        local lower_factor_advance = self.advancing.lower_factor * self.value
        local upper_factor_advance = self.advancing.upper_factor * self.value
        upper_factor_advance = bit.band(upper_factor_advance, 0xFFFF)
        local factor_advance = lower_factor_advance + upper_factor_advance *
                                   0x10000
        factor_advance = bit.band(factor_advance, 0xFFFFFFFF)
        local increase_advance = factor_advance + self.advancing.interval
        self.value = bit.band(increase_advance, 0xFFFFFFFF)
    end
end

function RandomNumber:advance(count)
    self.value = self:read()
    self:next(count)

    self:write(self.value)
    self.frame_counter = 30
    self.count_change = count
    self.count_symbol = "+"
end

function RandomNumber:increase(count)
    self.value = self:read() + count
    self:write(self.value % self.max)
    self.frame_counter = 30
    self.count_change = count
    self.count_symbol = "+"
end

-- Don't fully understand how this works, but it does, so the names might be misleading
function RandomNumber:rewind(count)
    self.value = self:read()
    local rn = self.value
    for i = 1, count do
        local decrease = bit.band(rn - self.advancing.interval, 0xFFFFFFFF)

        local final_rn_bits = {
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0
        }
        remainder = 0
        rn = 0
        for bit_location = 1, 32 do
            local matching_bits = 0
            local decrease_bit =
                bit.band(decrease, 2 ^ (bit_location - 1)) == 0 and 0 or 1

            for j = bit_location, 2, -1 do
                matching_bits = matching_bits +
                                    final_rn_bits[-j + bit_location + 1] *
                                    self.advancing.factor_bits[j]
            end

            matching_bits = matching_bits + remainder
            final_rn_bits[bit_location] = (decrease_bit + matching_bits) % 2
            if final_rn_bits[bit_location] == 1 then
                rn = rn + 2 ^ (bit_location - 1)
            end

            remainder = bit.rshift(final_rn_bits[bit_location] + matching_bits,
                                   1)
        end

        self.value = bit.band(rn, 0xFFFFFFFF)
    end

    self:write(self.value)
    self.frame_counter = 30
    self.count_change = count
    self.count_symbol = "-"
end

function RandomNumber:set_analysis_enabled(is_enabled)
    self.is_analysis_enabled = is_enabled
end

function RandomNumber:draw()
    self.value = self:read()
    if self.is_analysis_enabled then
        self:draw_analysis()
    else
        local text = self.letter_prefix .. "RN: " .. self.value
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
