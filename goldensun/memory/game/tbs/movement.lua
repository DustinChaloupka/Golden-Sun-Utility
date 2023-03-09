local movement = {}

local Movement = {
    tick = require("goldensun.memory.game.tbs.movement.tick"),
    type = require("goldensun.memory.game.tbs.movement.type")
}

setmetatable(movement, {__index = Movement})

return movement
