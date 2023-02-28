local rom = {}

local Chunk = require("goldensun.memory.chunk")
local Rom = Chunk.new({address = 0x080000A0, size = 32})

function Rom:is_current_rom() return self:read() == self.value end

function rom.new(o)
    local self = o or {}
    setmetatable(self, {__index = Rom})
    self.__index = self
    return self
end

return rom
