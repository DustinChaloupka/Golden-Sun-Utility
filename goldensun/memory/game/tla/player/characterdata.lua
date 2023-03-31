local character_data = {}

local CharacterData = require("goldensun.memory.game.characterdata").new {
    battle_data = require("goldensun.memory.game.tla.player.battledata"),

    address = 0x02000520,
    size = 8,

    agility_offset = 0x40,
    agility_size = 16,

    current_hp_offset = 0x38,
    current_hp_size = 16,

    current_pp_offset = 0x3A,
    current_pp_size = 16,

    level_offset = 0xF,
    level_size = 8,

    total_offset = 0x14C
}

setmetatable(character_data, {__index = CharacterData})

return character_data
