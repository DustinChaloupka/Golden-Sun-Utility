local battle_data = {}

local BattleData = require("goldensun.memory.game.character.battledata").new {
    -- This isn't actually just player character battle data, it seems to move between
    -- when selecting moves and when the animations are playing
    address = 0x02030338,
    size = 16,

    agility_offset = 0x04,
    agility_size = 16,

    total_offset = 0x10
}

setmetatable(battle_data, {__index = BattleData})

return battle_data
