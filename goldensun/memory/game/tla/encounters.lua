local encounters = {}

local Chunk = require("goldensun.memory.chunk")
local Encounters = require("goldensun.memory.game.encounters").new {
    lock = require("goldensun.memory.game.tla.encounters.lock"),
    step_count = require("goldensun.memory.game.tla.encounters.stepcount"),

    address = 0x080EDACC, -- ??
    size = 8
}

-- gui.text(0, 20, "Encounter: " .. (memory.readword(0x0200049A)), encounterColor)

setmetatable(encounters, {__index = Encounters})

return encounters
