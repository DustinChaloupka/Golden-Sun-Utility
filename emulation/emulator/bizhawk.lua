local bizhawk = {emulation = emu}

local Emulator = require("emulation.emulator")
local BizHawk = Emulator.new {
    controller = joypad.get(),
    controller_buttons = {
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
BizHawk.memory.writeword = memory.write_u16_le
BizHawk.memory.writedword = memory.write_u32_le

function BizHawk:load_joypad(joypad_number) self.controller = joypad.get() end
function BizHawk:button_pressed(button)
    local checking = button
    if self.controller_buttons[button] then
        checking = self.controller_buttons[button]
    end

    return self.controller and self.controller[checking]
end

-- convert to signed 32-bit
local function normalize(n) return n & 0xFFFFFFFF end

function BizHawk:band(a, b) return normalize(a & b) end
function BizHawk:lshift(a, b) return normalize(a << b) end
function BizHawk:rshift(a, b) return normalize(a >> b) end
-- bit = {
--     band    = function(a,b) return normalize(a & b) end,
--     bor     = function(a,b) return normalize(a | b) end,
--     bnot    = function(a)   return normalize(~a) end,
--     bxor    = function(a,b) return normalize(a ~ b) end,
--     ror     = function(a,b) return normalize(a >> b | a << 32-b) end,
--     rol     = function(a,b) return normalize(a << b | a >> 32-b) end,
--     lshift  = function(a,b) return normalize(a << b) end,
--     rshift  = function(a,b) return normalize(a >> b) end,
--     arshift = function(a,b) return normalize(a >> b) end,
--     tobit   = function(a)   return normalize(a) end,
--     tohex   = function(a,n) return ("%%0%dx"):format(n or 8):format(a) end
-- }

function BizHawk:math_mod(a, b) return math.fmod(a, b) end

setmetatable(bizhawk, {__index = BizHawk})

return bizhawk

