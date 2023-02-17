local bizhawk = {}
local controller = joypad.get()
local controllerKeys = {
    down = "Down",
    up = "Up",
    left = "Left",
    right = "Right",
    start = "Start",
    select = "Select"
}

function bizhawk.memory()
    memory.readword = memory.read_u16_le
    memory.readdword = memory.read_u32_le
    memory.writeword = memory.write_s16_le
    return memory
end

function bizhawk.loadJoypad(joypadNumber) controller = joypad.get() end
function bizhawk.keyPressed(key)
    if controllerKeys[key] then key = controllerKeys[key] end

    return controller[key]
end

function bizhawk.frameadvance() emu.frameadvance() end

return bizhawk
