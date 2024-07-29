Info = {}

Info.sections = {
    tile_address = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 5},
        getText = function(self)
            if State.in_battle() then return "" end
            return string.format("Tile Address: 0x0%x", emulator:read_dword(
                                     GameSettings.Map.TileAddress))
        end
    },
    brn = {
        checkInput = function(self, keyInput)
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
        getText = function(self)
            return "BRN: " .. RandomNumber.Battle.Value
        end
    },
    grn = {
        checkInput = function(self, keyInput)
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
        getText = function(self)
            return "GRN: " .. RandomNumber.General.Value
        end
    },
    step_rate = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 50},
        getText = function(self)
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
        getText = function(self)
            if State.in_battle() then return "" end
            return "Step Count: " ..
                       emulator:read_word(GameSettings.Movement.StepCount)
        end
    },
    movement_tick = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 80},
        getText = function(self)
            if State.in_battle() then return "" end
            local counter = emulator:read_word(GameSettings.Movement.Tick)
            return "Movement Tick: " .. (math.floor(counter / 0xFFF))
        end
    },
    player_agilities = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 200},
        getText = function(self)
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
    enemy_stats = {
        coords = {
            Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 175, 200
        },
        getText = function(self)
            if not State.in_battle() then return "" end

            local text = "Enemies:\n"
            for slot, enemy in pairs(Enemies.Active) do
                text = text .. enemy.Name .. ":\n  HP: " .. enemy.CurrentHP ..
                           "/" .. enemy.MaxHP .. "\n  Agility: " ..
                           enemy.Agility .. "\n"
            end

            return text
        end
    },
    fleeing = {
        coords = {
            Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 300, 200
        },
        getText = function(self)
            if not State.in_battle() then return "" end

            local front_average_level = Party.get_front_average_level()
            local enemy_average_level = Enemies.get_average_level()
            local current_attempts = emulator:read_byte(GameSettings.Battle
                                                            .FleeAttempts)

            local level_difference = math.floor(front_average_level * 500) -
                                         math.floor(enemy_average_level * 500)
            local attempt = 5000 + (2000 * current_attempts) + level_difference

            -- Not sure the calculations on EV and flee percent are accurate, but they are close
            local first_rn_advance_success = 0
            local total_flees = 0
            local found_flee = false
            local grn = RandomNumber.next(RandomNumber.General.Value, 1)
            local rng = RandomNumber.generate(grn)
            local threshold = RandomNumber.distribution(rng, 10000)
            for _ = 0, 1000 do
                if not found_flee and threshold >= attempt then
                    first_rn_advance_success = first_rn_advance_success + 1
                elseif not found_flee then
                    found_flee = true
                end

                if threshold < attempt then
                    total_flees = total_flees + 1
                end

                grn = RandomNumber.next(grn, 1)
                rng = RandomNumber.generate(grn)
                threshold = RandomNumber.distribution(rng, 10000)
            end

            local flee_percent = total_flees / 10

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
    for _, section in pairs(Info.sections) do
        local x = section.coords[1]
        local y = section.coords[2]
        local text = section:getText()

        gui.drawText(x + 1, y + 1, text, Drawing.Text.SHADOW_COLOR)
        gui.drawText(x, y, text)

        if section.buttons ~= nil then
            Drawing.drawButtons(section.buttons)
        end
    end
end

function Info.onFrameAdvance()
    for _, section in pairs(Info.sections) do
        if section.onFrameAdvance ~= nil then section:onFrameAdvance() end
    end
end

function Info.checkKeyInputs(keyInput)
    for _, section in pairs(Info.sections) do
        if section.checkInput ~= nil then section:checkInput(keyInput) end
    end
end
