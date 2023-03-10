local battle = {}

local Battle = require("goldensun.memory.game.randomnumber.battle").new {
    -- what is this?
    address = 0x020054C8,
    size = 32
}

setmetatable(battle, {__index = Battle})

return battle
