local order = {}

local Chunk = require("goldensun.memory.chunk")
local Order = Chunk.new {address = 0x02000458, size = 8}

function Order:get_ids()
    local player_ids = {}
    for i = 0, 7, 1 do player_ids[i] = self:read_offset(i) end
    return player_ids
end

setmetatable(order, {__index = Order})

return order
