local group = {}

local Chunk = require("goldensun.memory.chunk")
local Group = Chunk.new({total_enemy_count = 0})

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
    if self.enemies then return self.enemies end

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

function Group:get_total_enemy_count() return self.total_enemy_count end

function Group:set_enemy_counts(rn)
    if not self.enemies then self.enemies = self:get_enemies() end

    for _, enemy in pairs(self.enemies) do
        enemy:set_count(rn)
        for _ = 1, enemy:get_count() do
            self.total_enemy_count = self.total_enemy_count + 1
        end
    end
end

function Group:set_rn_advances_to_flee(rn, flee_attempt, comparing_average_level)
    local advances = flee_attempt:get_rn_advances_to_flee(rn,
                                                          comparing_average_level,
                                                          self:average_enemy_level(),
                                                          false)
    if advances < 100 then self.rn_advances_to_flee = advances end
end

function Group:get_rn_advances_to_flee() return
    self.rn_advances_to_flee or "N/A" end

-- Is this always done just 10 times between all 5 or 6 slots?
function Group:shuffle(rn)
    for _ = 1, 10 do
        rn:next(1)
        local a = rn:distribution(5) + 1
        rn:next(1)
        local b = rn:distribution(5) + 1
        local enemy = self.enemies[a]
        self.enemies[a] = self.enemies[b]
        self.enemies[b] = enemy
    end
end

function Group:average_enemy_level()
    return self:total_enemy_level() / self.total_enemy_count
end

function Group:total_enemy_level()
    local level = 0
    for _, enemy in pairs(self.enemies) do
        for i = 1, enemy:get_count() do
            if #enemy:get_name() < 14 or i == 1 then
                level = level + enemy:get_level()
            end
        end
    end

    return level
end

function group.new(o)
    local self = o or {}
    setmetatable(self, {__index = Group})
    self.__index = self
    return self
end

return group
