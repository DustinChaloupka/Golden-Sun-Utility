Enemies = {}

Enemies.Active = {}

function Enemies.update()
    Enemies.Active = {}
    if not State.in_battle() or State.in_transition() then return end

    for slot = 0, 4 do
        local base = GameSettings.Battle.Enemy.Address +
                         GameSettings.Battle.Enemy.Offset * slot
        local current_hp = emulator:read_word(base +
                                                  GameSettings.Battle.Enemy
                                                      .CurrentHPOffset)

        if current_hp > 0 then
            local name = ""
            local enemy_name = ""
            for i = 0, 14 do
                local byte_letter = emulator:read_byte(base + i)
                if byte_letter ~= 0 then
                    local letter = string.char(byte_letter)
                    name = name .. letter
                    if tonumber(letter) == nil then
                        enemy_name = enemy_name .. letter
                    end
                end
            end

            local id = 0
            for i, e in pairs(GameSettings.EnemyNames) do
                if e == enemy_name then
                    id = i
                    break
                end
            end

            -- Get level from battle for enemies with 
            -- more than 14 characters in their name
            local level = emulator:read_byte(base +
                                                 GameSettings.Battle.Enemy
                                                     .LevelOffset)

            Enemies.Active[slot] = {}
            for k, v in pairs(GameSettings.Enemy[id]) do
                Enemies.Active[slot][k] = v
            end
            Enemies.Active[slot].BattleName = name
            Enemies.Active[slot].CurrentHP = current_hp
            Enemies.Active[slot].BattleLevel = level
        end
    end
end

function Enemies.get_average_level()
    local levels = 0
    local alive = 0
    for _, enemy in pairs(Enemies.Active) do
        alive = alive + 1
        levels = levels + enemy.BattleLevel
    end

    return levels / alive
end
