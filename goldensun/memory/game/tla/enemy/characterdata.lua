local characterdata = {}

local CharacterData = require("goldensun.memory.game.characterdata").new {
    address = 0x080B9E7C,
    size = 8,

    level_offset = 0xF,
    level_size = 8,

    total_offset = 0x4C
}

setmetatable(characterdata, {__index = CharacterData})

return characterdata
