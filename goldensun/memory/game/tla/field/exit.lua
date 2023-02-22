local exit = {}

local Chunk = require("goldensun.memory.chunk")
local Exit = Chunk.new {
    address = 0x02030158,
    -- something special about this value?
    trigger = 0x3E7
}

function Exit:trigger(game) self:write(game, self.trigger) end

setmetatable(exit, {__index = Exit})

return exit
