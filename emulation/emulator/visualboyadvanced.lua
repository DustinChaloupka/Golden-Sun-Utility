local visualboyadvanced = {emulation = vba}

local Emulator = require("emulation.emulator")
local VisualBoyAdvanced = Emulator.new({
    gui = require("emulation.emulator.gui.onscreen"),
    memory = memory
})

setmetatable(visualboyadvanced, {__index = VisualBoyAdvanced})

return visualboyadvanced
