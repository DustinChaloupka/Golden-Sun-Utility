Movement = {
    encounter_rates = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 379}
    }
}

Movement.FastTravel = {Enabled = false}
Movement.Speed = {X = 0, Y = 0, Z = 0}

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

    if Map.Movement.Type == GameSettings.Movement.Overworld and
        emulator:button_pressed("B") then
        Movement.Speed = get_speed(Constants.Speed.OverworldRun)
    elseif Map.Movement.Type == GameSettings.Movement.Overworld then
        Movement.peed = get_speed(Constants.Speed.Overworld)
    elseif Map.Movement.Type == GameSettings.Movement.Normal or
        Map.Movement.Type == GameSettings.Movement.ShipNormal then
        Movement.Speed = get_speed(Constants.Speed.Town)
    elseif Map.Movement.Type == GameSettings.Movement.ShipOverworld then
        Movement.Speed = get_speed(Constants.Speed.Ship)
    elseif Map.Movement.Type == GameSettings.Movement.ShipHover then
        Movement.Speed = get_speed(Constants.Speed.HoverShip)
    end

    if Movement.FastTravel.Enabled and emulator:button_pressed("L") then
        Movement.speed_up()
    end
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

function get_speed(speed)
    local s = {X = 0, Y = 0, Z = 0}
    if emulator:button_pressed("down") then s.Y = s.Y + speed end
    if emulator:button_pressed("up") then s.Y = s.Y - speed end
    if emulator:button_pressed("left") then s.X = s.X - speed end
    if emulator:button_pressed("right") then s.X = s.X + speed end
    return s
end

function Movement.speed_up()
    Map.Coordinates.X = Map.Coordinates.X + Movement.Speed.X
    Map.Coordinates.Y = Map.Coordinates.Y + Movement.Speed.Y
    -- Map.Coordinates.Z = Map.Coordinates.Z + Movement.Speed.Z

    Map.set_current_coordinates()
end
