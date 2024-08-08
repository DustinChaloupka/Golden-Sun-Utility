Movement = {
    encounter_rates = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 379}
    }
}

Movement.Info = {}

function Movement.update()
    if State.in_battle() then
        Movement.Info = {}
        return
    end

    local step_rate = emulator:read_dword(GameSettings.Movement.StepRate)
    if step_rate ~= 0 then
        step_rate = normalize_step_rate(step_rate)
        Movement.Info = {}
    else
        Movement.update_step_rates()
    end

    Movement.StepRate = step_rate
end

function Movement.draw()
    for _, info in pairs(Movement.Info) do Drawing.drawText(info) end
end

function Movement.update_step_rates()
    for i = 0, 7 do
        local rate = Movement.predict_step_rate(RandomNumber.next(
                                                    RandomNumber.General.Value,
                                                    i))

        local x_offset = i * 120
        local y_offset = 0
        if i > 3 then
            x_offset = (i - 4) * 120
            y_offset = 100
        end

        Movement.Info[i] = {
            coords = {
                Movement.encounter_rates.coords[1] + x_offset,
                Movement.encounter_rates.coords[2] + y_offset
            },
            getText = function() return "Rate:" .. rate end
        }
    end
end

function Movement.predict_step_rate(rn)
    local step_rate_rn = RandomNumber.next(rn, 1)
    local rng1 = RandomNumber.generate(step_rate_rn)

    step_rate_rn = RandomNumber.next(step_rate_rn, 1)
    local rng2 = RandomNumber.generate(step_rate_rn)

    step_rate_rn = RandomNumber.next(step_rate_rn, 1)
    local rng3 = RandomNumber.generate(step_rate_rn)

    step_rate_rn = RandomNumber.next(step_rate_rn, 1)
    local rng4 = RandomNumber.generate(step_rate_rn)

    local prediction = math.floor(rng1 - rng2 + rng3 - rng4) / 2
    return normalize_step_rate(prediction)
end

function normalize_step_rate(rate)
    if rate >= 0xFFFF0000 then rate = rate - 0xFFFFFFFF end
    return math.floor((0xFFFF - rate) / 0xFF0)
end
