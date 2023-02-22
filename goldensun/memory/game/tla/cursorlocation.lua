local cursorlocation = {}

local Chunk = require("goldensun.memory.chunk")
local CursorLocation = require("goldensun.memory.game.cursorlocation").new {
    x = Chunk.new({address = 0x0202A006, size = 16}),
    y = Chunk.new({address = 0x0202A00A, size = 16}),
    z = nil
}

setmetatable(cursorlocation, {__index = CursorLocation})

return cursorlocation
