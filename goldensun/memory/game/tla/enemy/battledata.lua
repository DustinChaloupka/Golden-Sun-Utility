local battle_data = {}

local BattleData = require("goldensun.memory.game.character.battledata").new {
    address = 0x020308C8,
    size = 8,

    agility_offset = 0x1C,
    agility_size = 8,

    current_hp_offset = 0x38,
    current_hp_size = 16,

    total_offset = 0x14C
}

setmetatable(battle_data, {__index = BattleData})

return battle_data
