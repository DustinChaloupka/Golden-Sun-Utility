Battle = {}

Battle.buttons = {}

Battle.Info = {
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
    },
    back = {
        type = Constants.ButtonTypes.BORDERED,
        box = {Constants.Screen.WIDTH - 40, 600, 35, 20},
        getText = function() return "Back" end,
        onClick = function(self) Battle.Info.detailedEnemy = nil end
    }
}

function Battle.update()
    if State.in_battle() then
        Battle.update_buttons()
        Battle.update_turn_data()
    else
        Battle.buttons = {}
        Battle.Info.detailedEnemy = nil
    end
end

function Battle.draw()
    Drawing.drawButtons(Battle.buttons)

    if Battle.Info.detailedEnemy ~= nil then
        Drawing.drawText(Battle.Info.detailedEnemy)
    end
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

function Battle.update_buttons()
    Battle.buttons = {}
    if Battle.Info.detailedEnemy ~= nil then
        Battle.buttons[0] = Battle.Info.back
    else
        for slot, enemy in pairs(Enemies.Active) do
            local slot_offset = slot * 120
            Battle.buttons[slot] = {
                enemy = enemy,
                type = Battle.Info.enemies.type,
                box = {
                    Battle.Info.enemies.box[1] + slot_offset,
                    Battle.Info.enemies.box[2], Battle.Info.enemies.box[3],
                    Battle.Info.enemies.box[4]
                },
                getText = function()
                    return enemy.BattleName .. "\n HP: " .. enemy.CurrentHP ..
                               "/" .. enemy.HP .. "\n Agility: " ..
                               enemy.Agility
                end,
                onClick = Battle.Info.enemies.onClick
            }
        end
    end
end
