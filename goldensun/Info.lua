Info = {}

Info.Battle = {Timer = {[0] = 0, [1] = 0, [2] = 0, Enabled = false}}

Info.Timer = {Enabled = false, Paused = false, Ticks = 0}

Info.sections = {
    tile_address = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 5},
        getText = function()
            if State.in_battle() then return "" end
            return string.format("Tile Address: 0x0%x",
                                 Map.Tile.CurrentTileAddress)
        end
    },
    brn = {
        checkInput = function(keyInput)
            local new_value
            if keyInput["R"] then
                new_value = RandomNumber.next(RandomNumber.Battle.Value,
                                              math.random(1, 100))
            end

            if keyInput["B"] then
                new_value = RandomNumber.next(RandomNumber.Battle.Value, 1)
            end

            if keyInput["N"] then
                new_value = RandomNumber.previous(RandomNumber.Battle.Value)
            end

            if new_value ~= nil and RandomNumber.Battle.Value ~= new_value then
                RandomNumber.Battle.Value = new_value
                emulator:write_dword(GameSettings.RandomNumber.Battle, new_value)
            end
        end,
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 20},
        getText = function() return "BRN: " .. RandomNumber.Battle.Value end
    },
    grn = {
        checkInput = function(keyInput)
            local new_value
            if keyInput["R"] then
                new_value = RandomNumber.next(RandomNumber.General.Value,
                                              math.random(1, 100))
            end

            if keyInput["G"] then
                new_value = RandomNumber.next(RandomNumber.General.Value, 1)
            end

            if keyInput["H"] then
                new_value = RandomNumber.previous(RandomNumber.General.Value)
            end

            if new_value ~= nil and RandomNumber.General.Value ~= new_value then
                RandomNumber.General.Value = new_value
                emulator:write_dword(GameSettings.RandomNumber.General,
                                     new_value)
            end
        end,
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 35},
        getText = function() return "GRN: " .. RandomNumber.General.Value end
    },
    step_rate = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 50},
        getText = function()
            if State.in_battle() then return "" end

            local rate = Movement.StepRate
            if rate == 0 then return "" end

            return "Step Rate: " .. rate
        end
    },
    step_count = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 65},
        getText = function()
            if State.in_battle() then return "" end
            return "Step Count: " ..
                       emulator:read_word(GameSettings.Movement.StepCount)
        end
    },
    movement_tick = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 80},
        getText = function()
            if State.in_battle() then return "" end
            local counter = emulator:read_word(GameSettings.Movement.Tick)
            return "Movement Tick: " .. (math.floor(counter / 0xFFF))
        end
    },
    party_average_level = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 95},
        getText = function()
            return "Front Average Level: " .. Party.get_front_average_level()
        end
    },
    avoid_threshold = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 110},
        getText = function()
            if State.in_battle() then return "" end
            local zone = emulator:read_byte(GameSettings.Map.Zone)
            if zone == 0 then
                zone = emulator:read_byte(GameSettings.Map.Zone + 1)
            end

            return "Avoid Threshold: " ..
                       GameSettings.Encounters.Data[zone].Level
        end
    },
    timer = {
        checkInput = function(keyInput)
            if keyInput["Q"] then
                Info.Timer.Enabled = not Info.Timer.Enabled
                Info.Timer.Ticks = 0
            end

            if keyInput["W"] then
                Info.Timer.Paused = not Info.Timer.Paused
            end
        end,
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 125},
        onFrameAdvance = function()
            if not Info.Timer.Paused and Info.Timer.Enabled then
                Info.Timer.Ticks = Info.Timer.Ticks + 1
            end
        end,
        getText = function()
            if Info.Timer.Enabled then
                return "Timer: " .. math.floor(Info.Timer.Ticks / 60) .. "s"
            else
                return ""
            end
        end
    },
    map = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 210, 5},
        getText = function()
            if State.in_battle() then return "" end
            return "Map: " .. emulator:read_word(GameSettings.Map.Number)
        end
    },
    door = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 210, 20},
        getText = function()
            if State.in_battle() then return "" end
            return "Door: " .. emulator:read_byte(GameSettings.Map.Door)
        end
    },
    zone = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 210, 35},
        getText = function()
            if State.in_battle() then return "" end
            return "Encounter Index: " .. Map.get_encounter_index()
        end
    },
    playerX = {
        checkInput = function()
            if State.on_overworld_map() and emulator:button_pressed("A") then
                Map.Coordinates.UpdateNeeded = true
                Camera.Coordinates.UpdateNeeded = true
            end
        end,
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 360, 5},
        getText = function()
            if State.in_battle() then return "" end
            local x = Map.Coordinates.X
            if State.on_overworld_map() then x = Map.Overworld.Map.X end
            return "X: " .. string.format("0x%x", x)
        end
    },
    playerY = {
        checkInput = function()
            if State.on_overworld_map() and emulator:button_pressed("A") then
                Map.Coordinates.UpdateNeeded = true
                Camera.Coordinates.UpdateNeeded = true
            end
        end,
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 360, 20},
        getText = function()
            if State.in_battle() then return "" end
            local y = Map.Coordinates.Y
            if State.on_overworld_map() then y = Map.Overworld.Map.Y end
            return "Y: " .. string.format("0x%x", y)
        end
    },
    retreat = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 210, 50},
        getText = function()
            if State.in_battle() then return "" end
            return "Retreat Map: " ..
                       emulator:read_word(GameSettings.Map.Retreat)
        end
    },
    af = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 210, 65},
        getText = function()
            if State.in_battle() then return "" end
            return "AF: " .. Encounters.AttackFirsts[0] .. " " ..
                       Encounters.AttackFirsts[1] .. " " ..
                       Encounters.AttackFirsts[2]
        end
    },
    cbs = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 210, 80},
        getText = function()
            if State.in_battle() then return "" end
            return "CBS: " .. Encounters.CaughtBySurprises[0] .. " " ..
                       Encounters.CaughtBySurprises[1] .. " " ..
                       Encounters.CaughtBySurprises[2]
        end
    },
    battle_timers = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 210, 95},
        isVisible = function() return Battle.Timer.Enabled end,
        getText = function()
            if State.in_battle() then return "" end
            return "Battle T0: " .. Info.Battle.Timer[0] .. "s\nBattle T1: " ..
                       Info.Battle.Timer[1] .. "s\nBattle T2: " ..
                       Info.Battle.Timer[2] .. "s"
        end
    }
}

function Info.update()
    for _, section in pairs(Info.sections) do
        if section.onFrameAdvance ~= nil then section.onFrameAdvance() end
    end
end

function Info.drawSections()
    for _, section in pairs(Info.sections) do Drawing.drawText(section) end
end

function Info.checkKeyInputs(keyInput)
    for _, section in pairs(Info.sections) do
        if section.checkInput ~= nil then section.checkInput(keyInput) end
    end
end
