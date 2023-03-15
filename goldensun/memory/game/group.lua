local group = {}

local Chunk = require("goldensun.memory.chunk")
local Group = Chunk.new()

function Group:get_data(offset, size, i)
    return self:read_offset_with_size(
               self.group_id * self.total_offset + offset + i * size / 8, size)
end
function Group:get_id(i) return self:get_data(self.id_offset, self.id_size, i) end

function Group:get_min(i) return
    self:get_data(self.min_offset, self.min_size, i) end

function Group:get_max(i) return
    self:get_data(self.max_offset, self.max_size, i) end

function Group:get_enemies()
    local enemies = {}
    for i = 0, 4 do
        local enemy_id = self:get_id(i)
        local min = self:get_min(i)
        local max = self:get_max(i)
        local enemy = self:new_enemy(enemy_id, min, max)
        enemies[i + 1] = enemy
    end

    return enemies
end

function group.new(o)
    local self = o or {}
    setmetatable(self, {__index = Group})
    self.__index = self
    return self
end

return group
