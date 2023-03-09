local movement = {}

local Movement = {
    tick = require("goldensun.memory.game.tla.movement.tick"),
    type = require("goldensun.memory.game.tla.movement.type")
}

setmetatable(movement, {__index = Movement})

return movement
