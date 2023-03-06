local steprate = {}

local StepRate = require("goldensun.memory.game.steprate").new {
    address = 0x02030194,
    size = 32
}

setmetatable(steprate, {__index = StepRate})

return steprate
