local characterdata = {}

local CharacterData = require("goldensun.memory.game.characterdata").new {
    address = 0x02000520,
    size = 8,

    current_pp_offset = 0x3A,
    current_pp_size = 16,

    level_offset = 0xF,
    level_size = 8,

    total_offset = 0x14C
}

setmetatable(characterdata, {__index = CharacterData})

return characterdata
