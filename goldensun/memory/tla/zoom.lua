local zoom = {}

local Chunk = require("goldensun.memory.chunk")
local Zoom = Chunk.new({address = 0x03001169, size = 8, locked = 2})

function Zoom:lock(game) self:write(game, self.locked) end

setmetatable(zoom, {__index = Zoom})

return zoom
