local emulator = {}

local Emulator = {controller = joypad.get(0)}

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
