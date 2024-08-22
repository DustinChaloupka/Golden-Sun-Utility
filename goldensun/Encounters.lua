Encounters = {enabled = true}

Encounters.Tile = {}

Encounters.RandomNumber = {Advance = 0}

Encounters.Templates = {
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
    },
    Buttons = {
        move = {
            type = Constants.ButtonTypes.BORDERED,
            box = {
                Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 350,
                35, 20
            },
            border_color = 0xFFFFFFFF,
            fill_color = nil,
            on_border_color = 0xFF000000,
            off_border_color = 0xFFFFFFFF,
            preDraw = function(self)
                if Encounters.RandomNumber.Advance == GameSettings.Psynergy.Move then
                    self.border_color = self.on_border_color
                else
                    self.border_color = self.off_border_color
                end
            end,
            getText = function() return "Move" end,
            onClick = function(self)
                if Encounters.RandomNumber.Advance ~= GameSettings.Psynergy.Move then
                    Encounters.RandomNumber.Advance = GameSettings.Psynergy.Move
                else
                    Encounters.RandomNumber.Advance = 0
                end
            end
        },
        lash = {
            type = Constants.ButtonTypes.BORDERED,
            box = {
                Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 45, 350,
                35, 20
            },
            border_color = 0xFFFFFFFF,
            fill_color = nil,
            on_border_color = 0xFF000000,
            off_border_color = 0xFFFFFFFF,
            preDraw = function(self)
                if Encounters.RandomNumber.Advance == GameSettings.Psynergy.Lash then
                    self.border_color = self.on_border_color
                else
                    self.border_color = self.off_border_color
                end
            end,
            getText = function() return "Lash" end,
            onClick = function(self)
                if Encounters.RandomNumber.Advance ~= GameSettings.Psynergy.Lash then
                    Encounters.RandomNumber.Advance = GameSettings.Psynergy.Lash
                else
                    Encounters.RandomNumber.Advance = 0
                end
            end
        },
        scoop = {
            type = Constants.ButtonTypes.BORDERED,
            box = {
                Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 85, 350,
                45, 20
            },
            border_color = 0xFFFFFFFF,
            fill_color = nil,
            on_border_color = 0xFF000000,
            off_border_color = 0xFFFFFFFF,
            preDraw = function(self)
                if Encounters.RandomNumber.Advance ==
                    GameSettings.Psynergy.Scoop then
                    self.border_color = self.on_border_color
                else
                    self.border_color = self.off_border_color
                end
            end,
            getText = function() return "Scoop" end,
            onClick = function(self)
                if Encounters.RandomNumber.Advance ~=
                    GameSettings.Psynergy.Scoop then
                    Encounters.RandomNumber.Advance =
                        GameSettings.Psynergy.Scoop
                else
                    Encounters.RandomNumber.Advance = 0
                end
            end
        },
        frost = {
            type = Constants.ButtonTypes.BORDERED,
            box = {
                Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 135, 350,
                45, 20
            },
            border_color = 0xFFFFFFFF,
            fill_color = nil,
            on_border_color = 0xFF000000,
            off_border_color = 0xFFFFFFFF,
            preDraw = function(self)
                if Encounters.RandomNumber.Advance ==
                    GameSettings.Psynergy.Frost then
                    self.border_color = self.on_border_color
                else
                    self.border_color = self.off_border_color
                end
            end,
            getText = function() return "Frost" end,
            onClick = function(self)
                if Encounters.RandomNumber.Advance ~=
                    GameSettings.Psynergy.Frost then
                    Encounters.RandomNumber.Advance =
                        GameSettings.Psynergy.Frost
                else
                    Encounters.RandomNumber.Advance = 0
                end
            end
        },
        pound = {
            type = Constants.ButtonTypes.BORDERED,
            box = {
                Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 185, 350,
                45, 20
            },
            border_color = 0xFFFFFFFF,
            fill_color = nil,
            on_border_color = 0xFF000000,
            off_border_color = 0xFFFFFFFF,
            preDraw = function(self)
                if Encounters.RandomNumber.Advance ==
                    GameSettings.Psynergy.Pound then
                    self.border_color = self.on_border_color
                else
                    self.border_color = self.off_border_color
                end
            end,
            getText = function() return "Pound" end,
            onClick = function(self)
                if Encounters.RandomNumber.Advance ~=
                    GameSettings.Psynergy.Pound then
                    Encounters.RandomNumber.Advance =
                        GameSettings.Psynergy.Pound
                else
                    Encounters.RandomNumber.Advance = 0
                end
            end
        },
        growth = {
            type = Constants.ButtonTypes.BORDERED,
            box = {
                Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 235, 350,
                55, 20
            },
            border_color = 0xFFFFFFFF,
            fill_color = nil,
            on_border_color = 0xFF000000,
            off_border_color = 0xFFFFFFFF,
            preDraw = function(self)
                if Encounters.RandomNumber.Advance ==
                    GameSettings.Psynergy.Growth then
                    self.border_color = self.on_border_color
                else
                    self.border_color = self.off_border_color
                end
            end,
            getText = function() return "Growth" end,
            onClick = function(self)
                if Encounters.RandomNumber.Advance ~=
                    GameSettings.Psynergy.Growth then
                    Encounters.RandomNumber.Advance =
                        GameSettings.Psynergy.Growth
                else
                    Encounters.RandomNumber.Advance = 0
                end
            end
        },
        cyclone = {
            type = Constants.ButtonTypes.BORDERED,
            box = {
                Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 295, 350,
                60, 20
            },
            border_color = 0xFFFFFFFF,
            fill_color = nil,
            on_border_color = 0xFF000000,
            off_border_color = 0xFFFFFFFF,
            preDraw = function(self)
                if Encounters.RandomNumber.Advance ==
                    GameSettings.Psynergy.Cyclone then
                    self.border_color = self.on_border_color
                else
                    self.border_color = self.off_border_color
                end
            end,
            getText = function() return "Cyclone" end,
            onClick = function(self)
                if Encounters.RandomNumber.Advance ~=
                    GameSettings.Psynergy.Cyclone then
                    Encounters.RandomNumber.Advance =
                        GameSettings.Psynergy.Cyclone
                else
                    Encounters.RandomNumber.Advance = 0
                end
            end
        },
        douse = {
            type = Constants.ButtonTypes.BORDERED,
            box = {
                Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 360, 350,
                45, 20
            },
            border_color = 0xFFFFFFFF,
            fill_color = nil,
            on_border_color = 0xFF000000,
            off_border_color = 0xFFFFFFFF,
            preDraw = function(self)
                if Encounters.RandomNumber.Advance ==
                    GameSettings.Psynergy.Douse then
                    self.border_color = self.on_border_color
                else
                    self.border_color = self.off_border_color
                end
            end,
            getText = function() return "Douse" end,
            onClick = function(self)
                if Encounters.RandomNumber.Advance ~=
                    GameSettings.Psynergy.Douse then
                    Encounters.RandomNumber.Advance =
                        GameSettings.Psynergy.Douse
                else
                    Encounters.RandomNumber.Advance = 0
                end
            end
        },
        sand = {
            type = Constants.ButtonTypes.BORDERED,
            box = {
                Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 410, 350,
                35, 20
            },
            border_color = 0xFFFFFFFF,
            fill_color = nil,
            on_border_color = 0xFF000000,
            off_border_color = 0xFFFFFFFF,
            preDraw = function(self)
                if Encounters.RandomNumber.Advance == GameSettings.Psynergy.Sand then
                    self.border_color = self.on_border_color
                else
                    self.border_color = self.off_border_color
                end
            end,
            getText = function() return "Sand" end,
            onClick = function(self)
                if Encounters.RandomNumber.Advance ~= GameSettings.Psynergy.Sand then
                    Encounters.RandomNumber.Advance = GameSettings.Psynergy.Sand
                else
                    Encounters.RandomNumber.Advance = 0
                end
            end
        },
        lift = {
            type = Constants.ButtonTypes.BORDERED,
            box = {
                Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 450, 350,
                35, 20
            },
            border_color = 0xFFFFFFFF,
            fill_color = nil,
            on_border_color = 0xFF000000,
            off_border_color = 0xFFFFFFFF,
            preDraw = function(self)
                if Encounters.RandomNumber.Advance == GameSettings.Psynergy.Lift then
                    self.border_color = self.on_border_color
                else
                    self.border_color = self.off_border_color
                end
            end,
            getText = function() return "Lift" end,
            onClick = function(self)
                if Encounters.RandomNumber.Advance ~= GameSettings.Psynergy.Lift then
                    Encounters.RandomNumber.Advance = GameSettings.Psynergy.Lift
                else
                    Encounters.RandomNumber.Advance = 0
                end
            end
        }
    }
}

Encounters.Buttons = {}

function Encounters.check() if not Encounters.enabled then Encounters.lock() end end

function Encounters.lock()
    emulator:write_word(GameSettings.Movement.StepCount, 0)
end

function Encounters.draw()
    if State.in_battle() then return end

    Drawing.drawButtons(Encounters.Buttons)
end

function Encounters.update()
    if State.in_battle() then return end

    if State.on_overworld() and Map.Tile.CurrentTileAddress ~=
        Encounters.Tile.CurrentTileAddress then
        Encounters.Tile.CurrentTileAddress = Map.Tile.CurrentTileAddress
        Encounters.update_encounter_groups()
    end

    if (Encounters.previous_grn ~= RandomNumber.General.Value) or
        (Encounters.previous_advance ~= Encounters.RandomNumber.Advance) then
        Encounters.previous_grn = RandomNumber.General.Value
        Encounters.previous_advance = Encounters.RandomNumber.Advance
        Encounters.update_encounter_groups()
    end

    if Encounters.previous_brnn ~= RandomNumber.Battle.Value then
        Encounters.previous_brn = RandomNumber.Battle.Value
        Encounters.update_encounter_priority()
    end
end

function Encounters.update_encounter_groups()
    Encounters.Buttons = Encounters.Templates.Buttons

    local zone = Map.get_encounter_index()

    if zone == 0 then return end

    local psynergy_grn = RandomNumber.next(RandomNumber.General.Value,
                                           Encounters.RandomNumber.Advance)

    local encounter_data = GameSettings.Encounters.Data[zone]
    for i = 1, 8 do
        local rn_advances = i - 1
        local encounter_rn = RandomNumber.next(psynergy_grn, rn_advances)

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

        Encounters.Buttons[i] = {
            type = Encounters.Templates.enemies.type,
            box = {
                Encounters.Templates.enemies.box[1] + x_offset,
                Encounters.Templates.enemies.box[2] + y_offset,
                Encounters.Templates.enemies.box[3],
                Encounters.Templates.enemies.box[4]
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
