local characterdata = {}

local Chunk = require("goldensun.memory.chunk")
local CharacterData = Chunk.new {
    address = 0x02000520,
    size = 8,

    current_pp_offset = 0x3A,
    current_pp_size = 16,

    total_offset = 0x14C
}

function CharacterData:get_current_pp(game, player_id)
    return self:read_offset_with_size(game, player_id * self.total_offset +
                                          self.current_pp_offset,
                                      self.current_pp_size)
end

function CharacterData:set_current_pp(game, player_id, value)
    self:write_offset_with_size(game, value, player_id * self.total_offset +
                                    self.current_pp_offset, self.current_pp_size)
end

setmetatable(characterdata, {__index = CharacterData})

return characterdata
