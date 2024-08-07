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

            local rate = emulator:read_dword(GameSettings.Movement.StepRate)
            if rate == 0 then return "" end

            -- Unsure how all of these were calculated
            if rate >= 0xFFFF0000 then rate = rate - 0xFFFFFFFF end
            return "Step Rate: " .. math.floor((0xFFFF - rate) / 0xFF0)
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
            local zone = emulator:read_byte(GameSettings.Map.Zone)
            if zone == 0 then
                zone = emulator:read_byte(GameSettings.Map.Zone + 1)
            end

            return "Encounter Index: " .. zone
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
    },
    player_agilities = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 200},
        getText = function()
            if not State.in_battle() then return "" end

            local text = "Player Agilities:\n"
            for slot, id in pairs(Party.Front) do
                local name = GameSettings.Characters[id]
                local current_agility = emulator:read_word(
                                            GameSettings.Character[name]
                                                .CurrentAgility)
                local max_agility = current_agility + current_agility *
                                        GameSettings.RandomModifiers.Agility

                local turn_agility = "N/A"
                for _, data in pairs(Battle.turn_data) do
                    if data.id == id then
                        turn_agility = data.agility
                    end
                end

                text = text .. name .. ": " .. turn_agility .. " (" ..
                           current_agility .. "-" .. math.floor(max_agility) ..
                           ")\n"
            end

            return text
        end
    },
    fleeing = {
        coords = {
            Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 300, 200
        },
        getText = function()
            if not State.in_battle() or State.cannot_flee() then
                return ""
            end

            local front_average_level = Party.get_front_average_level()
            local enemy_average_level = Enemies.get_average_level()
            local current_attempts = emulator:read_byte(GameSettings.Battle
                                                            .FleeAttempts)

            local level_difference = math.floor(front_average_level * 500) -
                                         math.floor(enemy_average_level * 500)
            local attempt = math.min(10000,
                                     math.max(0, 5000 + level_difference) +
                                         (2000 * current_attempts))

            local first_rn_advance_success = 0
            local grn = RandomNumber.next(RandomNumber.General.Value, 1)
            for _ = 0, 100 do
                local rng = RandomNumber.generate(grn)
                local threshold = RandomNumber.distribution(rng, 10000)

                if threshold < attempt then
                    break
                else
                    first_rn_advance_success = first_rn_advance_success + 1
                end

                grn = RandomNumber.next(grn, 1)
            end

            local flee_percent = attempt / 100

            local flee_probability = flee_percent / 100
            local ev_tries = 1
            local turn_probability = 1
            local ev = flee_probability * ev_tries * turn_probability
            while flee_probability < 1 do
                turn_probability = (1 - flee_probability) * turn_probability
                flee_probability = math.min(flee_probability + 0.2, 1)
                ev_tries = ev_tries + 1
                ev = ev + flee_probability * ev_tries * turn_probability
            end

            ev = math.ceil(ev * 100) / 100

            return "Fleeing:\nACs for Success: " .. first_rn_advance_success ..
                       "\nPercent for Success: " .. flee_percent ..
                       "\nEV for Success: " .. ev
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
