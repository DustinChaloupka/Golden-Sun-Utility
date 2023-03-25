local battle_data = {}

local Chunk = require("goldensun.memory.chunk")
local BattleData = Chunk.new()

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
