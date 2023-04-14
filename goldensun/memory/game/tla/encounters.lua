local encounters = {}

local Encounters = require("goldensun.memory.game.encounters").new {
    group = require("goldensun.memory.game.tla.enemy.group"),
    battle_group = require("goldensun.memory.game.tla.enemy.battlegroup"),
    flee_attempt = require("goldensun.memory.game.tla.fleeattempt"),
    lock = require("goldensun.memory.game.tla.encounters.lock"),
    step_count = require("goldensun.memory.game.tla.encounters.stepcount"),
    step_rate = require("goldensun.memory.game.tla.encounters.steprate"),

    address = 0x080EDACC,
    size = 8,

    zone_offset = 0x1C,

    recommended_level_offset = 2,
    recommended_level_size = 16
}

setmetatable(encounters, {__index = Encounters})

return encounters
