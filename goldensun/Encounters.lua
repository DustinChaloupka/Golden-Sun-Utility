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

    Drawing.drawButtons(Encounters.Info.buttons)
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
    if Encounters.previous_brn ~= RandomNumber.Battle.Value then
        Encounters.previous_brn = RandomNumber.Battle.Value
        Encounters.update_encounter_checks()
    end
end

function Encounters.update_encounter_groups()
    Encounters.Info.buttons = {}

    local grn = RandomNumber.General.Value

    local zone = 0
    if emulator:read_byte(GameSettings.Map.Type) == 2 then
        zone = emulator:read_byte(GameSettings.Map.Zone)
        if zone == 0 then
            zone = emulator:read_byte(GameSettings.Map.Zone + 1)
        end
    else
        zone = get_overworld_zone()
    end

    if zone == 0 then return end

    local encounter_data = GameSettings.Encounters.Data[zone]
    for i = 0, 7 do
        local encounter_rn = grn

        if emulator:read_dword(GameSettings.Movement.StepRate) == 0 then
            encounter_rn = RandomNumber.next(encounter_rn, 4)
        end

        encounter_rn = RandomNumber.next(encounter_rn, i)

        local ratio_total = 0
        for _, group in pairs(encounter_data.Groups) do
            ratio_total = ratio_total + group.Ratio
        end

        encounter_rn = RandomNumber.next(encounter_rn, 1)
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
                local count_rng = RandomNumber.generate(encounter_rn)
                local count_distribution =
                    RandomNumber.distribution(count_rng,
                                              enemy.Max - enemy.Min + 1)
                enemies[enemy.ID] = enemy.Min + count_distribution
            else
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

        local x_offset = i * 120
        local y_offset = 0
        if i > 3 then
            x_offset = (i - 4) * 120
            y_offset = 80
        end

        Encounters.Info.buttons[i] = {
            type = Encounters.Info.enemies.type,
            box = {
                Encounters.Info.enemies.box[1] + x_offset,
                Encounters.Info.enemies.box[2] + y_offset,
                Encounters.Info.enemies.box[3], Encounters.Info.enemies.box[4]
            },
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

function Encounters.update_encounter_checks() end

function get_overworld_zone()
    local encounter_data
    if Map.Movement.Type == GameSettings.Movement.Overworld then
        encounter_data = GameSettings.Encounters.OverworldData
    elseif Map.Movement.Type == GameSettings.Movement.ShipOverworld then
        encounter_data = GameSettings.Encounters.OverworldShipData
    else
        return 0
    end

    for _, encounter in pairs(encounter_data) do
        if type(encounter) == "table" then
            local area_match = encounter.AreaType ==
                                   (emulator:band(Map.Tileset.Area, 0x3F) % 0x14)
            local terrain_match = Map.Movement.Type ==
                                      GameSettings.Movement.ShipOverworld or
                                      encounter.TerrainType ==
                                      Map.Tileset.Terrain

            if area_match and terrain_match then
                return encounter.BattleEncountersIndex
            end
        end
    end

    return 0
end
