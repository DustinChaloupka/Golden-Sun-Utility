Battle = {}

function Battle.update() if State.in_battle() then Battle.update_turn_data() end end

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
