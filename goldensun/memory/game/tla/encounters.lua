local encounters = {}

local Encounters = require("goldensun.memory.game.encounters").new {
    address = 0x02000498,
    size = 16
}

setmetatable(encounters, {__index = Encounters})

return encounters
