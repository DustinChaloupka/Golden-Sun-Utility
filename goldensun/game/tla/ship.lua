local ship = {}

local Ship = {
    boarding = require("goldensun.memory.tla.boarding"),
    normal_location = require("goldensun.memory.tla.ship.normallocation"),
    overworld_location = require("goldensun.memory.tla.ship.overworldlocation")
}

function Ship:board(game) self.boarding:board(game) end
function Ship:is_aboard(game) return self.boarding:is_aboard(game) end
function Ship:set_overworld_location(game, location)
    self.overworld_location:set_location(game, location)
end

function Ship:set_normal_location(game, location)
    self.normal_location:set_location(game, location)
end

setmetatable(ship, {__index = Ship})

return ship
