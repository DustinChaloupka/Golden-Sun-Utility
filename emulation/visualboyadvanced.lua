local visualboyadvanced = {emulation = vba}

local Emulator = require("emulation.emulator")
local VisualBoyAdvanced = Emulator.new({memory = memory})

setmetatable(visualboyadvanced, {__index = VisualBoyAdvanced})

return visualboyadvanced
