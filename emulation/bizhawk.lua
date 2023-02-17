local bizhawk = {emulation = emu}

-- Can this get removed to not edit a global table somehow?
memory.readword = memory.read_u16_le
memory.readdword = memory.read_u32_le
memory.writeword = memory.write_s16_le

local Emulator = require("emulation.emulator")
local BizHawk = Emulator.new {
    controller = joypad.get(),
    controller_keys = {
        down = "Down",
        up = "Up",
        left = "Left",
        right = "Right",
        start = "Start",
        select = "Select"
    }
}

function BizHawk:load_joypad(joypad_number) self.controller = joypad.get() end
function BizHawk:key_pressed(key)
    local checking = key
    if self.controller_keys[key] then checking = self.controller_keys[key] end

    return self.controller and self.controller[checking]
end

setmetatable(bizhawk, {__index = BizHawk})

return bizhawk

