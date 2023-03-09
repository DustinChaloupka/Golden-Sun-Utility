local type = {}

local Type = require("goldensun.memory.game.movement.type").new {
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

local TypeTla = {}
setmetatable(TypeTla, {__index = Type})

function TypeTla:is_sand() return self:read() == self.sand end
function TypeTla:is_normal_ship() return self:read() == self.normal_ship end
function TypeTla:is_overworld_ship() return self:read() == self.overworld_ship end
function TypeTla:is_hover_ship() return self:read() == self.hover_ship end
function TypeTla:is_ship()
    return self:is_normal_ship() or self:is_overworld_ship() or
               self:is_hover_ship()
end
function TypeTla:is_overworld_sand() return self:read() == self.overworld_sand end
function TypeTla:is_hover() return self:read() == self.hover end

local settings = require("config.settings")
function TypeTla:speed_up()
    local speed
    local location
    if self:is_overworld_ship() then
        speed = self:get_speed(settings.boat_speed)
        location = game.ship.overworld_location
    elseif self:is_hover_ship() then
        speed = self:get_speed(settings.hover_boat_speed)
        location = game.ship.overworld_location
    elseif self:is_normal_ship(game) then
        speed = self:get_speed(settings.town_speed)
        location = game.ship.normal_location
    end

    if speed and location then
        location:add_speed(speed)
        return speed
    end

    return Type:speed_up()
end

setmetatable(type, {__index = TypeTla})

return type
