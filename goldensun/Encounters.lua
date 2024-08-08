Encounters = {enabled = true}

Encounters.Tile = {}

Encounters.Info = {
    enemies = {
        type = Constants.ButtonTypes.BORDERED,
        box = {
            Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 397, 115,
            75
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
function Encounters.check() if not Encounters.enabled then Encounters.lock() end end

function Encounters.lock()
    emulator:write_word(GameSettings.Movement.StepCount, 0)
end

function Encounters.draw()
    if State.in_battle() then return end

    Drawing.drawButtons(Encounters.Info.Buttons)
end

function Encounters.update()
    if State.in_battle() then return end

    if State.on_overworld() and Map.Tile.CurrentTileAddress ~=
        Encounters.Tile.CurrentTileAddress then
        Encounters.Tile.CurrentTileAddress = Map.Tile.CurrentTileAddress
        Encounters.update_encounter_groups()
    end

    if Encounters.previous_grn ~= RandomNumber.General.Value then
        Encounters.previous_grn = RandomNumber.General.Value
        Encounters.update_encounter_groups()
    end

    if Encounters.previous_brnn ~= RandomNumber.Battle.Value then
        Encounters.previous_brn = RandomNumber.Battle.Value
        Encounters.update_encounter_priority()
    end
end

function Encounters.update_encounter_groups()
    Encounters.Info.Buttons = {}

    local zone = Map.get_encounter_index()

    if zone == 0 then return end

    local encounter_data = GameSettings.Encounters.Data[zone]
    for i = 1, 8 do
        local rn_advances = i - 1
        local encounter_rn = RandomNumber.next(RandomNumber.General.Value,
                                               rn_advances)

        local rate = Movement.StepRate
        if rate == 0 then
            encounter_rn = RandomNumber.next(encounter_rn, 4)
            rn_advances = rn_advances + 4
        end

        local ratio_total = 0
        for _, group in pairs(encounter_data.Groups) do
            ratio_total = ratio_total + group.Ratio
        end

        encounter_rn = RandomNumber.next(encounter_rn, 1)
        rn_advances = rn_advances + 1
        local group_rng = RandomNumber.generate(encounter_rn)
        local group_distribution = RandomNumber.distribution(group_rng,
                                                             ratio_total)
        local group
        for _, g in ipairs(encounter_data.Groups) do
            group_distribution = group_distribution - g.Ratio

            if group_distribution < 0 then
                group = GameSettings.Encounters.Groups[g.ID]
                break
            end
        end

        local enemies = {}
        for _, enemy in ipairs(group.Enemies) do
            if enemy.Min < enemy.Max then
                encounter_rn = RandomNumber.next(encounter_rn, 1)
                rn_advances = rn_advances + 1
                local count_rng = RandomNumber.generate(encounter_rn)
                local count_distribution =
                    RandomNumber.distribution(count_rng,
                                              enemy.Max - enemy.Min + 1)
                enemies[enemy.ID] = enemy.Min + count_distribution
            elseif enemy.ID ~= 0 then
                enemies[enemy.ID] = enemy.Min
            end
        end

        for _ = 0, 9 do
            encounter_rn = RandomNumber.next(encounter_rn, 1)
            local slot_a_rng = RandomNumber.generate(encounter_rn)
            local slot_a = RandomNumber.distribution(slot_a_rng, 5) + 1

            encounter_rn = RandomNumber.next(encounter_rn, 1)
            local slot_b_rng = RandomNumber.generate(encounter_rn)
            local slot_b = RandomNumber.distribution(slot_b_rng, 5) + 1

            local enemy = enemies[slot_a]
            enemies[slot_a] = enemies[slot_b]
            enemies[slot_b] = enemy
        end

        rn_advances = rn_advances + 20

        local x_offset = (i - 1) * 120
        local y_offset = 0
        if i > 4 then
            x_offset = (i - 5) * 120
            y_offset = 100
        end

        Encounters.Info.Buttons[i] = {
            type = Encounters.Info.enemies.type,
            box = {
                Encounters.Info.enemies.box[1] + x_offset,
                Encounters.Info.enemies.box[2] + y_offset,
                Encounters.Info.enemies.box[3], Encounters.Info.enemies.box[4]
            },
            rn_advances = rn_advances,
            enemies = enemies,
            getText = function(self)
                local text = ""
                for id, count in pairs(enemies) do
                    for i = 1, count do
                        text = text .. GameSettings.EnemyNames[id] .. "\n"
                    end
                end

                return text
            end
        }
    end
end

function Encounters.update_encounter_priority()
    Encounters.AttackFirsts = {}
    Encounters.CaughtBySurprises = {}

    local af_brn = RandomNumber.next(RandomNumber.Battle.Value, 1)
    local cbs_brn = RandomNumber.next(RandomNumber.Battle.Value, 2)
    local af_count = 0
    local cbs_count = 0
    for i = 0, 2 do
        local af_tries = af_count
        local af_rng = RandomNumber.generate(af_brn)
        while emulator:band(af_rng, 0xF) ~= 0 do
            af_brn = RandomNumber.next(af_brn, 1)
            af_rng = RandomNumber.generate(af_brn)
            af_tries = af_tries + 1
        end

        Encounters.AttackFirsts[i] = af_tries

        local cbs_tries = cbs_count
        local cbs_rng = RandomNumber.generate(cbs_brn)
        while emulator:band(cbs_rng, 0x1F) ~= 0 do
            cbs_brn = RandomNumber.next(cbs_brn, 1)
            cbs_rng = RandomNumber.generate(cbs_brn)
            cbs_tries = cbs_tries + 1
        end

        Encounters.CaughtBySurprises[i] = cbs_tries

        af_brn = RandomNumber.next(af_brn, 1)
        cbs_brn = RandomNumber.next(cbs_brn, 1)
        af_count = af_tries + 1
        cbs_count = cbs_tries + 1
    end
end
