State = {}

State.Flags = {in_battle = 3, in_menu = 6}

function State.update()
    State.current_state = emulator:read_byte(GameSettings.State.address)
end

function State.in_transition()
    return emulator:read_byte(GameSettings.State.address + 0x5) > 0
end

function State.in_battle()
    return emulator:band(emulator:rshift(State.current_state,
                                         State.Flags.in_battle), 1) == 1
end

function State.in_menu()
    return emulator:band(emulator:rshift(State.current_state,
                                         State.Flags.in_menu), 1) == 1
end
