local bizhawk = {emulation = emu}

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
    },
    gui = require("emulation.emulator.gui.dialog"),
    memory = memory
}
BizHawk.memory.readword = memory.read_u16_le
BizHawk.memory.readdword = memory.read_u32_le
BizHawk.memory.writeword = memory.write_s16_le

function BizHawk:load_joypad(joypad_number) self.controller = joypad.get() end
function BizHawk:key_pressed(key)
    local checking = key
    if self.controller_keys[key] then checking = self.controller_keys[key] end

    return self.controller and self.controller[checking]
end

setmetatable(bizhawk, {__index = BizHawk})

return bizhawk

