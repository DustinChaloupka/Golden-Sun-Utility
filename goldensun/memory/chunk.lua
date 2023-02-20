local chunk = {}

local Chunk = {}

function Chunk:read(game) return self:read_offset(game, 0) end
function Chunk:read_offset(game, offset)
    return self:read_offset_with_size(game, offset, self.size)
end
function Chunk:read_with_size(game, size)
    return self:read_offset_with_size(game, 0, size)
end
function Chunk:read_offset_with_size(game, offset, size)
    if size == 8 then
        return game:read_byte(self.address + offset)
    elseif size == 16 then
        return game:read_word(self.address + offset)
    elseif size == 32 then
        return game:read_dword(self.address + offset)
    end
end

function Chunk:write(game, value) self:write_offset(game, value, 0) end
function Chunk:write_offset(game, value, offset)
    self:write_offset_with_size(game, value, offset, self.size)
end
function Chunk:write_with_size(game, value, size)
    self:write_offset_with_size(game, value, 0, size)
end
function Chunk:write_offset_with_size(game, value, offset, size)
    if size == 8 then
        game:write_byte(self.address + offset, value)
    elseif size == 16 then
        game:write_word(self.address + offset, value)
    elseif size == 32 then
        game:write_dword(self.address + offset, value)
    end
end

function chunk.new(o)
    local self = o or {}
    setmetatable(self, {__index = Chunk})
    self.__index = self
    return self
end

return chunk
