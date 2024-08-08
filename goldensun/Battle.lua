Battle = {
    enemies = {
        type = Constants.ButtonTypes.BORDERED,
        box = {
            Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 397, 115,
            45
        },
        onClick = function(self)
            Battle.Info.detailedEnemy = {
                coords = {
                    Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 400
                },
                getText = function()
                    return
                        self.enemy.Name .. "\n Level: " .. self.enemy.Level ..
                            "\n HP: " .. self.enemy.HP .. "\n Attack: " ..
                            self.enemy.Attack .. "\n Defense: " ..
                            self.enemy.Defense .. "\n Agility: " ..
                            self.enemy.Agility .. "\n Luck: " .. self.enemy.Luck ..
                            "\n Turns: " .. self.enemy.Turns .. "\n EXP: " ..
                            self.enemy.Exp
                end
            }
        end
    }
}

Battle.Buttons = {
    back = {
        type = Constants.ButtonTypes.BORDERED,
        box = {Constants.Screen.WIDTH - 40, 600, 35, 20},
        getText = function() return "Back" end,
        isVisible = function() return Battle.Info.detailedEnemy ~= nil end,
        onClick = function(self) Battle.Info.detailedEnemy = nil end
    }
}

Battle.Info = {
    player_agilities = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 200},
        getText = function()
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
            if State.cannot_flee() then return "" end

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

function Battle.update()
    Battle.update_enemies()
    Battle.update_turn_data()
end

function Battle.draw()
    for _, info in pairs(Battle.Info) do Drawing.drawText(info) end
    Drawing.drawButtons(Battle.Buttons)
end

function Battle.update_turn_data()
    local turn = {}
    for slot = 0, 19 do
        local id = emulator:read_word(GameSettings.Battle.Turn.Address + slot *
                                          GameSettings.Battle.Turn.SlotOffset)

        turn[slot] = {id = id}
        turn[slot].agility = emulator:read_word(
                                 GameSettings.Battle.Turn.Address + slot *
                                     GameSettings.Battle.Turn.SlotOffset +
                                     GameSettings.Battle.Turn.AgilityOffset)
    end

    Battle.turn_data = turn
end

function Battle.update_enemies()
    for slot, enemy in pairs(Enemies.Active) do
        if enemy.CurrentHP > 0 then
            local slot_offset = slot * 120
            Battle.Buttons[slot] = {
                enemy = enemy,
                type = Battle.enemies.type,
                box = {
                    Battle.enemies.box[1] + slot_offset, Battle.enemies.box[2],
                    Battle.enemies.box[3], Battle.enemies.box[4]
                },
                isVisible = function()
                    return not Battle.Buttons.back.isVisible()
                end,
                getText = function()
                    return enemy.BattleName .. "\n HP: " .. enemy.CurrentHP ..
                               "/" .. enemy.HP .. "\n Agility: " ..
                               enemy.Agility
                end,
                onClick = Battle.enemies.onClick
            }
        end
    end
end
