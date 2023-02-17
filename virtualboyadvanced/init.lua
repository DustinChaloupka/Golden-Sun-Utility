local virtualboyadvanced = {}
local controller = joypad.get(0)

function virtualboyadvanced.memory() return memory end
function virtualboyadvanced.frameadvance() vba.frameadvance() end
function virtualboyadvanced.loadJoypad(joypadNumber)
    controller = joypad.get(joypadNumber)
end
function virtualboyadvanced.keyPressed(key) return controller[key] end

return virtualboyadvanced
