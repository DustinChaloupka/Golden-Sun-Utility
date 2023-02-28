local chunk = {}

local Chunk = {}

function Chunk:read() return self:read_offset(0) end
function Chunk:read_offset(offset)
    return self:read_offset_with_size(offset, self.size)
end
function Chunk:read_with_size(size) return self:read_offset_with_size(0, size) end
function Chunk:read_offset_with_size(offset, size)
    if size == 8 then
        return emulator:read_byte(self.address + offset)
    elseif size == 16 then
        return emulator:read_word(self.address + offset)
    elseif size == 32 then
        return emulator:read_dword(self.address + offset)
    end
end

function Chunk:write(value) self:write_offset(value, 0) end
function Chunk:write_offset(value, offset)
    self:write_offset_with_size(value, offset, self.size)
end
function Chunk:write_with_size(value, size)
    self:write_offset_with_size(value, 0, size)
end
function Chunk:write_offset_with_size(value, offset, size)
    if size == 8 then
        emulator:write_byte(self.address + offset, value)
    elseif size == 16 then
        emulator:write_word(self.address + offset, value)
    elseif size == 32 then
        emulator:write_dword(self.address + offset, value)
    end
end

function chunk.new(o)
    local self = o or {}
    setmetatable(self, {__index = Chunk})
    self.__index = self
    return self
end

return chunk
