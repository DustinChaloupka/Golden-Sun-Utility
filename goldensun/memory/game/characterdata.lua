local characterdata = {}

local Chunk = require("goldensun.memory.chunk")
local CharacterData = Chunk.new()

function CharacterData:get_current_pp(game, player_id)
    return self:read_offset_with_size(game, player_id * self.total_offset +
                                          self.current_pp_offset,
                                      self.current_pp_size)
end

function CharacterData:set_current_pp(game, player_id, value)
    self:write_offset_with_size(game, value, player_id * self.total_offset +
                                    self.current_pp_offset, self.current_pp_size)
end

function characterdata.new(o)
    local self = o or {}
    setmetatable(self, {__index = CharacterData})
    self.__index = self
    return self
end

return characterdata
