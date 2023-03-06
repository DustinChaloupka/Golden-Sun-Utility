local stepcount = {}

local StepCount = require("goldensun.memory.game.stepcount").new {
    address = 0x0200049A,
    size = 16,

    counter = require("goldensun.memory.chunk").new {
        address = 0x02000498,
        size = 32
    }
}

setmetatable(stepcount, {__index = StepCount})

return stepcount
