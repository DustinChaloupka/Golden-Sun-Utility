local tick = {}

local Tick = require("goldensun.memory.game.movement.tick").new {
    -- What is this?
    address = 0x020301A0,
    size = 16
}

setmetatable(tick, {__index = Tick})

return tick
