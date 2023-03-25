local battle_group = {}

local BattleGroup = require("goldensun.memory.game.battlegroup").new {
    address = 0x020308C8,
    size = 8,

    total_offset = 0x18
}

function BattleGroup:new_enemy() return
    require("goldensun.game.tla.enemy").new() end

setmetatable(battle_group, {__index = BattleGroup})

return battle_group
