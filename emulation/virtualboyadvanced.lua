local virtualboyadvanced = {emulation = vba}

local Emulator = require("emulation.emulator")
local VirtualBoyAdvanced = Emulator.new()

setmetatable(virtualboyadvanced, {__index = VirtualBoyAdvanced})

return virtualboyadvanced
