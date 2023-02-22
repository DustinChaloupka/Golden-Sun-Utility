local movetype = {}

local MoveType = require("goldensun.memory.game.movetype").new {
    address = 0x02000452,
    size = 8,

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

local MoveTypeTla = {}
setmetatable(MoveTypeTla, {__index = MoveType})

function MoveTypeTla:is_sand(game) return self:read(game) == self.sand end
function MoveTypeTla:is_normal_ship(game)
    return self:read(game) == self.normal_ship
end
function MoveTypeTla:is_overworld_ship(game)
    return self:read(game) == self.overworld_ship
end
function MoveTypeTla:is_hover_ship(game)
    return self:read(game) == self.hover_ship
end
function MoveTypeTla:is_ship(game)
    return self:is_normal_ship(game) or self:is_overworld_ship(game) or
               self:is_hover_ship(game)
end
function MoveTypeTla:is_overworld_sand(game)
    return self:read(game) == self.overworld_sand
end
function MoveTypeTla:is_hover(game) return self:read(game) == self.hover end

local settings = require("config.settings")
function MoveTypeTla:speed_up(game)
    local speed
    local location
    if self:is_overworld_ship(game) then
        speed = self:get_speed(game, settings.boat_speed)
        location = game.ship.overworld_location
    elseif self:is_hover_ship(game) then
        speed = self:get_speed(game, settings.hover_boat_speed)
        location = game.ship.overworld_location
    elseif self:is_normal_ship(game) then
        speed = self:get_speed(game, settings.town_speed)
        location = game.ship.normal_location
    end

    if speed and location then
        location:add_speed(game, speed)
        return speed
    end

    return MoveType:speed_up(game)
end

setmetatable(movetype, {__index = MoveTypeTla})

return movetype
