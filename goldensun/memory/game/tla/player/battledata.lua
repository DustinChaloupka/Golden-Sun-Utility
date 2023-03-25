local battle_data = {}

local BattleData = require("goldensun.memory.game.character.battledata").new {
    address = 0x02030338,
    size = 16,

    agility_offset = 0x04,
    agility_size = 16,

    total_offset = 0x10
}

setmetatable(battle_data, {__index = BattleData})

return battle_data
