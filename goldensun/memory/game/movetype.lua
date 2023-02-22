local movetype = {}

local Chunk = require("goldensun.memory.chunk")
local MoveType = Chunk.new()

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
function MoveType:is_overworld_sand(game)
    return self:read(game) == self.overworld_sand
end
function MoveType:is_slippery_ground(game)
    return self:read(game) == self.slippery_ground
end

function MoveType:get_speed(game, speed)
    local s = {x = 0, y = 0, z = 0}
    if game:key_pressed("down") then s.y = s.y + speed end
    if game:key_pressed("up") then s.y = s.y - speed end
    if game:key_pressed("left") then s.x = s.x - speed end
    if game:key_pressed("right") then s.x = s.x + speed end
    return s
end

local settings = require("config.settings")
function MoveType:speed_up(game)
    local speed
    local location
    if self:is_overworld(game) and game:key_pressed("B") then
        speed = self:get_speed(game, settings.overworld_run_speed)
        location = game.field_player.overworld_location
    elseif self:is_overworld(game) then
        speed = self:get_speed(game, settings.overworld_speed)
        location = game.field_player.overworld_location
    elseif self:is_normal(game) then
        speed = self:get_speed(game, settings.town_speed)
        location = game.field_player.normal_location
    end

    location:add_speed(game, speed)
    return speed
end

function movetype.new(o)
    local self = o or {}
    setmetatable(self, {__index = MoveType})
    self.__index = self
    return self
end

return movetype
