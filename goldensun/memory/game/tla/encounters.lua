local encounters = {}

local Chunk = require("goldensun.memory.chunk")
local Encounters = require("goldensun.memory.game.encounters").new {
    lock = require("goldensun.memory.game.tla.encounters.lock"),
    step_count = require("goldensun.memory.game.tla.encounters.stepcount"),

    address = 0x080EDACC, -- ??
    size = 8
}

setmetatable(encounters, {__index = Encounters})

return encounters
