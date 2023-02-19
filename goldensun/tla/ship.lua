local ship = {}

local Ship = {
    boarding = require("goldensun.memory.tla.boarding"),
    normal_location = require("goldensun.memory.tla.ship.normallocation"),
    overworld_location = require("goldensun.memory.tla.ship.overworldlocation")
}

function Ship:board(game) self.boarding:board(game) end
function Ship:is_aboard(game) return self.boarding:is_aboard(game) end
function Ship:set_overworld_location(game, x, y)
    self.overworld_location:set_x(game, x)
    self.overworld_location:set_y(game, y)
end

function Ship:set_normal_location(game, x, y)
    self.normal_location:set_x(game, x)
    self.normal_location:set_y(game, y)
end

setmetatable(ship, {__index = Ship})

return ship
