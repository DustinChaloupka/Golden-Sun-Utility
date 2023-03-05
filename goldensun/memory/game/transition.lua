local transition = {}

local Chunk = require("goldensun.memory.chunk")
-- Not sure this is entirely accurate. There seem to be some movement/map type flags
-- maybe related to transitions that get set at 0x02000064 as well according to the doc?
local Transition = Chunk.new({address = 0x02000065, size = 8})

function Transition:is_in_progress() return self:read() > 0 end

setmetatable(transition, {__index = Transition})

return transition
