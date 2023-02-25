local map = {}

local Map = require("goldensun.memory.game.map").new {
    address = 0x02000400,
    size = 16,
    overworld = 2,

    battle = 510
}

setmetatable(map, {__index = Map})

return map
