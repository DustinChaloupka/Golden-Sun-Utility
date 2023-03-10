local movement = {}

local Movement = require("goldensun.memory.game.movement").new {
    tick = require("goldensun.memory.game.tla.movement.tick"),
    type = require("goldensun.memory.game.tla.movement.type")
}

setmetatable(movement, {__index = Movement})

return movement
