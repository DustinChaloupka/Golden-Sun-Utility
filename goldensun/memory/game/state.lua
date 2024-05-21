local state = {}

local Chunk = require("goldensun.memory.chunk")
local State = Chunk.new({
    address = 0x02000060,
    size = 8,

    battle_flag = 3,
    menu_flag = 6
})

function State:is_battle()
    return emulator:band(emulator:rshift(self:read(), self.battle_flag), 1) == 1
end

function State:is_menu()
    return emulator:band(emulator:rshift(self:read(), self.menu_flag), 1) == 1
end

setmetatable(state, {__index = State})

return state
