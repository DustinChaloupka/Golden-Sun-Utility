local stepcount = {}

local StepCount = require("goldensun.memory.game.stepcount").new {
    address = 0x0200049A,
    size = 16
}

setmetatable(stepcount, {__index = StepCount})

return stepcount
