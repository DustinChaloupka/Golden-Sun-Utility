local rom = {}

local Rom = require("goldensun.memory.rom").new({value = 0x444C4F47})

setmetatable(rom, {__index = Rom})

return rom
