local order = {}

local Chunk = require("goldensun.memory.chunk")
local Order = Chunk.new()

function Order:get_ids()
    local player_ids = {}
    for i = 0, 7, 1 do table.insert(player_ids, self:read_offset(i)) end
    return player_ids
end

function order.new(o)
    local self = o or {}
    setmetatable(self, {__index = Order})
    self.__index = self
    return self
end

return order
