local randomnumber = {}

local Chunk = require("goldensun.memory.chunk")
local RandomNumber = Chunk.new {
    advancing = {
        factor = 0x41c64e6d,
        first_factor = 0x4e6d,
        second_factor = 0x41c6,
        interval = 0x3039,

        -- binary representation of factor
        factor_bits = {
            1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1,
            1, 1, 0, 0, 0, 0, 0, 1, 0
        }
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
        local increase_advance = factor_advance + self.advancing.interval
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

-- Don't fully understand how this works, but it does, so the names might be misleading
function RandomNumber:rewind(count)
    local rn = self:read()
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

            remainder = math.floor(
                            (final_rn_bits[bit_location] + matching_bits) / 2)
        end

        rn = bit.band(rn, 0xFFFFFFFF)
    end

    self:write(rn)
    self.frame_counter = 30
    self.count_change = count
    self.count_symbol = "-"
end

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
