local order = {}

local Chunk = require("goldensun.memory.chunk")
local Order = Chunk.new()

function Order:get_ids(group_offset)
    local enemy_ids = {}
    for i = 0, 4 do
        table.insert(enemy_ids, self:read_offset_with_size(
                         group_offset + i * self.id_offset, self.id_size))
    end
    return enemy_ids
end

function order.new(o)
    local self = o or {}
    setmetatable(self, {__index = Order})
    self.__index = self
    return self
end

return order
