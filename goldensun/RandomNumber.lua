RandomNumber = {}

RandomNumber.Advance = {
    LowerFactor = 0x4e6d,
    UpperFactor = 0x41c6,
    Interval = 0x3039,

    -- binary representation of factor
    FactorBits = {
        1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1,
        1, 0, 0, 0, 0, 0, 1, 0
    }
}

RandomNumber.General = {}
RandomNumber.Battle = {}

function RandomNumber.update()
    RandomNumber.General.Value = emulator:read_dword(
                                     GameSettings.RandomNumber.General)
    RandomNumber.Battle.Value = emulator:read_dword(
                                    GameSettings.RandomNumber.Battle)
end

function RandomNumber.next(value, count)
    for i = 1, count do
        local lower_factor_advance = RandomNumber.Advance.LowerFactor * value
        local upper_factor_advance = RandomNumber.Advance.UpperFactor * value
        upper_factor_advance = emulator:band(upper_factor_advance, 0xFFFF)
        local factor_advance = lower_factor_advance + upper_factor_advance *
                                   0x10000
        factor_advance = factor_advance & 0xFFFFFFFF
        local increase_advance = factor_advance + RandomNumber.Advance.Interval
        return increase_advance & 0xFFFFFFFF
    end

    return value
end

function RandomNumber.previous(value)
    local decrease = emulator:band(value - RandomNumber.Advance.Interval,
                                   0xFFFFFFFF)

    local final_rn_bits = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0
    }
    remainder = 0
    rn = 0
    for bit_location = 1, 32 do
        local matching_bits = 0
        local decrease_bit = emulator:band(decrease, 2 ^ (bit_location - 1)) ==
                                 0 and 0 or 1

        for j = bit_location, 2, -1 do
            matching_bits =
                matching_bits + final_rn_bits[-j + bit_location + 1] *
                    RandomNumber.Advance.FactorBits[j]
        end

        matching_bits = matching_bits + remainder
        final_rn_bits[bit_location] = (decrease_bit + matching_bits) % 2
        if final_rn_bits[bit_location] == 1 then
            rn = rn + 2 ^ (bit_location - 1)
        end

        remainder = emulator:rshift(final_rn_bits[bit_location] + matching_bits,
                                    1)
    end

    return emulator:band(rn, 0xFFFFFFFF)
end

-- This is the actual value used in calculating things
function RandomNumber.generate(value)
    return emulator:rshift(emulator:lshift(value, 8), 16)
end

-- This coverts the generated number to a value between 0-distribution
function RandomNumber.distribution(rng, distribution)
    return emulator:rshift(rng * distribution, 16)
end
