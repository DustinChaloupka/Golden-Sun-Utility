local group = {}

local Group = require("goldensun.memory.game.group").new {
    address = 0x0812CE7C,
    size = 8,

    id_offset = 0,
    id_size = 16,

    min_offset = 10,
    min_size = 8,

    max_offset = 15,
    max_size = 8,

    total_offset = 0x18
}

function Group:new_enemy(id, min, max)
    return require("goldensun.game.tla.enemy").new {
        id = id,
        min = min,
        max = max
    }
end

function group.new(o)
    local self = o or {}
    setmetatable(self, {__index = Group})
    self.__index = self
    return self
end

return group
