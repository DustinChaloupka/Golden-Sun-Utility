local flee_attempt = {}

local FleeAttempt = require("goldensun.memory.game.fleeattempt").new {
    address = 0x02030092,
    size = 8
}

setmetatable(flee_attempt, {__index = FleeAttempt})

return flee_attempt
