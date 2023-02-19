local movetype = {}

local Chunk = require("goldensun.memory.chunk")
local MoveType = Chunk.new {
    address = 0x02000452,
    size = 8,
    value = 0,

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

function MoveType:is_normal(game) return self:read(game) == self.normal end
function MoveType:is_overworld(game) return self:read(game) == self.overworld end
function MoveType:is_climbing_wall(game)
    return self:read(game) == self.climbing_wall
end
function MoveType:is_climbing_rope(game)
    return self:read(game) == self.climbing_rope
end
function MoveType:is_walking_rope(game)
    return self:read(game) == self.walking_rope
end
function MoveType:is_sand(game) return self:read(game) == self.sand end
function MoveType:is_normal_ship(game) return
    self:read(game) == self.normal_ship end
function MoveType:is_overworld_ship(game)
    return self:read(game) == self.overworld_ship
end
function MoveType:is_hover_ship(game) return self:read(game) == self.hover_ship end
function MoveType:is_ship(game)
    return self:is_normal_ship(game) or self:is_overworld_ship(game) or
               self:is_hover_ship(game)
end
function MoveType:is_overworld_sand(game)
    return self:read(game) == self.overworld_sand
end
function MoveType:is_hover(game) return self:read(game) == self.hover end
function MoveType:is_slippery_ground(game)
    return self:read(game) == self.slippery_ground
end

setmetatable(movetype, {__index = MoveType})

return movetype
