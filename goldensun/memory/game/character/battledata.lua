local battle_data = {}

local Chunk = require("goldensun.memory.chunk")
local BattleData = Chunk.new()

function BattleData:get_current_hp(slot)
    return self:read_offset_with_size((slot - 1) * self.total_offset +
                                          self.current_hp_offset,
                                      self.current_hp_size)
end

function BattleData:get_level(slot)
    return self:read_offset_with_size((slot - 1) * self.total_offset +
                                          self.level_offset, self.level_size)
end

function BattleData:get_name(slot)
    name = ""
    for i = 0, 14 do
        local byte_letter = self:read_offset_with_size((slot - 1) *
                                                           self.total_offset +
                                                           self.name_offset +
                                                           0x1 * i,
                                                       self.name_size)
        if byte_letter ~= 0 then name = name .. string.char(byte_letter) end
    end

    return name
end

function BattleData:get_turn_agility(slot)
    local agility = self:read_offset_with_size(
                        (slot - 1) * self.total_offset + self.agility_offset,
                        self.agility_size)

    return agility > 1000 and 0 or agility
end

function battle_data.new(o)
    local self = o or {}
    setmetatable(self, {__index = BattleData})
    self.__index = self
    return self
end

return battle_data
