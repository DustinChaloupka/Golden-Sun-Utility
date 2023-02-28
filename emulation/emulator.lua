local emulator = {}

local Emulator = {controller = joypad.get(0)}

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

function Emulator:key_pressed(key)
    return self.controller and self.controller[key]
end

function emulator.new(o)
    local self = o or {}
    setmetatable(self, {__index = Emulator})
    return self
end

return emulator
