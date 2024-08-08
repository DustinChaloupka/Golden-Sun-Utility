Info = {}

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
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 360, 5},
        getText = function()
            if State.in_battle() then return "" end
            return "X: " .. string.format("0x%x", Map.Coordinates.X)
        end
    },
    playerY = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 360, 20},
        getText = function()
            if State.in_battle() then return "" end
            return "Y: " .. string.format("0x%x", Map.Coordinates.Y)
        end
    },
    retreat = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 210, 50},
        getText = function()
            if State.in_battle() then return "" end
            return "Retreat Map: " ..
                       emulator:read_word(GameSettings.Map.Retreat)
        end
    }
}

function Info.drawSections()
    for _, section in pairs(Info.sections) do Drawing.drawText(section) end
end

function Info.checkKeyInputs(keyInput)
    for _, section in pairs(Info.sections) do
        if section.checkInput ~= nil then section.checkInput(keyInput) end
    end
end
