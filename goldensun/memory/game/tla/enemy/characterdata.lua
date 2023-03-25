local character_data = {}

local CharacterData = require("goldensun.memory.game.characterdata").new {
    battle_data = require("goldensun.memory.game.tla.enemy.battledata"),

    address = 0x080B9E7C,
    size = 8,

    level_offset = 0xF,
    level_size = 8,

    total_offset = 0x4C
}

setmetatable(character_data, {__index = CharacterData})

return character_data
