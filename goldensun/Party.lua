Party = {pp_lock_enabled = false}

Party.Front = {}

function Party.update()
    for slot = 0, 3 do
        local id = emulator:read_word(GameSettings.Battle.FrontParty + slot *
                                          0x2)

        if id <= 7 then Party.Front[slot] = id end
    end

    if Party.pp_lock_enabled then Party.lock_pp() end
end

function Party.lock_pp()
    emulator:write_word(GameSettings.Character.Felix.CurrentPP, 5)
end

function Party.get_front_average_level()
    local alive = 0
    local levels = 0
    for _, id in pairs(Party.Front) do
        local name = GameSettings.Characters[id]
        local current_hp = GameSettings.Character[name].CurrentHP
        if current_hp ~= 0 then
            local level = emulator:read_byte(GameSettings.Character[name].Level)
            alive = alive + 1
            levels = levels + level
        end
    end

    return levels / alive
end
