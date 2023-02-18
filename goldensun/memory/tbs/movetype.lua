local movetype = {}

local Chunk = require("goldensun.memory.chunk")
local MoveType = Chunk.new {
    address = 0x02000432,
    size = 8,
    value = 0,

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

function MoveType:is_normal() return self.value == self.normal end
function MoveType:is_overworld() return self.value == self.overworld end
function MoveType:is_climbing_wall() return self.value == self.climbing_wall end
function MoveType:is_climbing_rope() return self.value == self.climbing_rope end
function MoveType:is_walking_rope() return self.value == self.walking_rope end
function MoveType:is_sand() return self.value == self.sand end
function MoveType:is_normal_ship() return self.value == self.normal_ship end
function MoveType:is_overworld_ship() return self.value == self.overworld_ship end
function MoveType:is_hover_ship() return self.value == self.hover_ship end
function MoveType:is_ship()
    return self:is_normal_ship() or self:is_overworld_ship() or
               self:is_hover_ship()
end
function MoveType:is_overworld_sand() return self.value == self.overworld_sand end
function MoveType:is_hover() return self.value == self.hover end
function MoveType:is_slippery_ground() return self.value == self.slippery_ground end

setmetatable(movetype, {__index = MoveType})

return movetype
