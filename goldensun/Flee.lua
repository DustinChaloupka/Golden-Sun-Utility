Flee = {
    acs = {
        coords = {
            Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5 + 65, 379
        }
    }
}

Flee.Info = {}

function Flee.update()
    if State.in_battle() then
        Flee.Info = {}
    else
        Flee.update_analysis_acs()
    end
end

function Flee.draw()
    for _, info in pairs(Flee.Info) do Drawing.drawText(info) end
end

function Flee.get_attempt(enemy_average_level, current_attempts)
    local front_average_level = Party.get_front_average_level()

    local level_difference = math.floor(front_average_level * 500) -
                                 math.floor(enemy_average_level * 500)
    return math.min(10000, math.max(0, 5000 + level_difference) +
                        (2000 * current_attempts))
end

function Flee.get_acs_for_rn(rn, attempt)
    local first_rn_advance_success = 0
    local grn = RandomNumber.next(rn, 1)
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

    return first_rn_advance_success
end

function Flee.update_analysis_acs()
    if Encounters.Info.Buttons == nil then return end

    local rn_advances = 0
    for i, encounter in ipairs(Encounters.Info.Buttons) do
        rn_advances = encounter.rn_advances
        local enemies = {}
        local j = 0
        for id, count in pairs(encounter.enemies) do

            for k = 1, count do
                local enemy = {}
                for k, v in pairs(GameSettings.Enemy[id]) do
                    enemy[k] = v
                end

                if string.len(enemy.Name) >= 14 and k > 1 then
                    enemy.BattleLevel = 0
                else
                    enemy.BattleLevel = enemy.Level
                end

                enemies[j] = enemy
                j = j + 1
            end
        end

        local enemy_average_level = Enemies.get_average_level(enemies)
        local attempt = Flee.get_attempt(enemy_average_level, 0)

        local rn = RandomNumber.next(RandomNumber.General.Value,
                                     (i - 1) + rn_advances)
        local acs = Flee.get_acs_for_rn(rn, attempt)

        local x_offset = (i - 1) * 120
        local y_offset = 0
        if i > 4 then
            x_offset = (i - 5) * 120
            y_offset = 100
        end

        Flee.Info[i] = {
            coords = {
                Flee.acs.coords[1] + x_offset, Flee.acs.coords[2] + y_offset
            },
            getText = function()
                local attempts = acs
                if attempts > 100 then attempts = "N/A" end

                return "AC:" .. attempts
            end
        }
    end
end
