local movetype = {}

local Chunk = require("goldensun.memory.chunk")
local MoveType = Chunk.new {
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
function MoveType:is_slippery_ground(game)
    return self:read(game) == self.slippery_ground
end

local settings = require("config.settings")
function MoveType:speed_up(game)
    local speed
    local location
    if self:is_overworld(game) and game:key_pressed("B") then
        speed = get_speed(game, settings.overworld_run_speed)
        location = game.field_player.overworld_location
    elseif self:is_overworld(game) then
        speed = get_speed(game, settings.overworld_speed)
        location = game.field_player.overworld_location
    else
        speed = get_speed(game, settings.town_speed)
        location = game.field_player.normal_location
    end

    location:add_speed(game, speed)
    return speed
end

setmetatable(movetype, {__index = MoveType})

return movetype
