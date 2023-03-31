local order = {}

local Chunk = require("goldensun.memory.chunk")
local Order = Chunk.new()

function Order:get_ids()
    local player_ids = {}
    for i = 0, (self.max_size - 1) do
        table.insert(player_ids, self:read_offset(i))
    end

    -- Before getting Piers, the 4th slot has id 3 (Mia) in it
    -- What's this like in TBS?
    if player_ids[5] == 0 and player_ids[4] == 3 then
        local actual_ids = {}
        for i = 1, 3 do table.insert(actual_ids, player_ids[i]) end
        player_ids = actual_ids
    elseif player_ids[6] == 0 and player_ids[7] == 0 then
        -- This isn't accurate with Isaac from Gabomba, but, oh well?
        local actual_ids = {}
        for i = 1, 4 do table.insert(actual_ids, player_ids[i]) end
        player_ids = actual_ids
    end

    return player_ids
end

function order.new(o)
    local self = o or {}
    setmetatable(self, {__index = Order})
    self.__index = self
    return self
end

return order
