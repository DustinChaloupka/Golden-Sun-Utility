local movetype = {}

local MoveType = require("goldensun.memory.game.movetype").new {
    address = 0x02000432,
    size = 8,

    -- what are these?
    normal = 0,
    overworld = 1,
    climbing_wall = 2,
    climbing_rope = 3,
    walking_rope = 4,
    sand = 5,
    normal_ship = 6,
    overworld_ship = 7,
    hover_ship = 8,
    overworld_sand = 9,
    hover = 10,
    slippery_ground = 11
}

setmetatable(movetype, {__index = MoveType})

return movetype
