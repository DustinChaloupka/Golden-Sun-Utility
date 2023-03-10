local general = {}

local General = require("goldensun.memory.game.randomnumber.general").new {
    -- what is this?
    address = 0x030011BC,
    size = 32
}

setmetatable(general, {__index = General})

return general
