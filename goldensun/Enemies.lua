Enemies = {}

Enemies.Active = {}

function Enemies.update()
    if not State.in_battle() or State.in_transition() then
        Enemies.Active = {}
        return
    end

    for slot = 0, 4 do
        local base = GameSettings.Battle.Enemy.Address +
                         GameSettings.Battle.Enemy.Offset * slot
        local current_hp = emulator:read_word(base +
                                                  GameSettings.Battle.Enemy
                                                      .CurrentHPOffset)

        if current_hp > 0 then
            name = ""
            for i = 0, 14 do
                local byte_letter = emulator:read_byte(base + 0x1 * i)
                if byte_letter ~= 0 then
                    name = name .. string.char(byte_letter)
                end
            end

            local max_hp = emulator:read_word(base +
                                                  GameSettings.Battle.Enemy
                                                      .MaxHPOffset)
            local agility = emulator:read_byte(base +
                                                   GameSettings.Battle.Enemy
                                                       .AgilityOffset)

            local level = emulator:read_byte(base +
                                                 GameSettings.Battle.Enemy
                                                     .LevelOffset)

            Enemies.Active[slot] = {
                Name = name,
                Agility = agility,
                MaxHP = max_hp,
                CurrentHP = current_hp,
                Level = level
            }
        end
    end
end

function Enemies.get_average_level()
    local levels = 0
    local alive = 0
    for _, enemy in pairs(Enemies.Active) do
        alive = alive + 1
        levels = levels + enemy.Level
    end

    return levels / alive
end
