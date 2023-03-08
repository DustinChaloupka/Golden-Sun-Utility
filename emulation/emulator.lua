local emulator = {}

local Emulator = {checking = {}, controller = joypad.get(0)}

function Emulator:read_word(...) return self.memory.readword(...) end
function Emulator:read_dword(...) return self.memory.readdword(...) end
function Emulator:write_word(...) return self.memory.writeword(...) end
function Emulator:write_dword(...) return self.memory.writedword(...) end
function Emulator:read_byte(...) return self.memory.readbyte(...) end
function Emulator:write_byte(...) return self.memory.writebyte(...) end
function Emulator:key_pressed(...) return self:key_pressed(...) end

function Emulator:frameadvance()
    if self.emulation then self.emulation.frameadvance() end
end

function Emulator:load_joypad(joypad_number)
    self.controller = joypad.get(joypad_number)
end

function Emulator:load_input() self.input = input.get() end

function Emulator:key_pressed(key)
    if self.checking[key] and self.input[key] then
        return false
    elseif self.input[key] then
        self.checking[key] = true
        return true
    else
        self.checking[key] = false
    end

    return false
end

function Emulator:button_pressed(button)
    return self.controller and self.controller[button]
end

function emulator.new(o)
    local self = o or {}
    setmetatable(self, {__index = Emulator})
    return self
end

return emulator
