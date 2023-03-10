local general = {}

local General = require("goldensun.memory.game.randomnumber.general").new {
    address = 0x030011BC,
    size = 32
}

setmetatable(general, {__index = General})

return general
