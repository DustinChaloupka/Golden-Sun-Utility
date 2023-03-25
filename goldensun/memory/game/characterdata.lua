local character_data = {}

local Chunk = require("goldensun.memory.chunk")
local CharacterData = Chunk.new()

function CharacterData:get_current_pp(character_id)
    return self:read_offset_with_size(character_id * self.total_offset +
                                          self.current_pp_offset,
                                      self.current_pp_size)
end

function CharacterData:set_current_pp(character_id, value)
    self:write_offset_with_size(value, character_id * self.total_offset +
                                    self.current_pp_offset, self.current_pp_size)
end

function CharacterData:get_level(character_id)
    return self:read_offset_with_size(character_id * self.total_offset +
                                          self.level_offset, self.level_size)
end

function CharacterData:get_turn_agility(slot)
    return self.battle_data:get_turn_agility(slot)
end

function character_data.new(o)
    local self = o or {}
    setmetatable(self, {__index = CharacterData})
    self.__index = self
    return self
end

return character_data
