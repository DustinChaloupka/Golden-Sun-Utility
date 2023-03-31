local battle_group = {}

local BattleGroup = require("goldensun.memory.game.battlegroup").new {
    address = 0x020308C8,
    size = 8,

    total_offset = 0x14C
}

function BattleGroup:new_enemy(slot)
    return require("goldensun.game.tla.enemy").new({slot = slot})
end

setmetatable(battle_group, {__index = BattleGroup})

return battle_group
