local ship = {}

local Ship = {
    boarding = require("goldensun.memory.game.tla.boarding"),
    normal_location = require("goldensun.memory.game.tla.ship.normallocation"),
    overworld_location = require(
        "goldensun.memory.game.tla.ship.overworldlocation")
}

function Ship:board() self.boarding:board() end
function Ship:is_aboard() return self.boarding:is_aboard() end
function Ship:set_overworld_location(location)
    self.overworld_location:set_location(location)
end

function Ship:set_normal_location(location)
    self.normal_location:set_location(location)
end

setmetatable(ship, {__index = Ship})

return ship
