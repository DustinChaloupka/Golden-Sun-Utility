local chunk = {}

local Chunk = {}

function Chunk:read(game)
    if self.size == 8 then
        self.value = game:read_byte(self.address)
    elseif self.size == 16 then
        self.value = game:read_word(self.address)
    elseif self.size == 32 then
        self.value = game:read_dword(self.address)
    end
end

function Chunk:write(game, value)
    if self.size == 8 then
        game:write_byte(self.address, value)
    elseif self.size == 16 then
        game:write_word(self.address, value)
    elseif self.size == 32 then
        game:write_dword(self.address, value)
    end

    self.value = value
end

function chunk.new(o)
    local self = o or {}
    setmetatable(self, {__index = Chunk})
    self.__index = self
    return self
end

return chunk
