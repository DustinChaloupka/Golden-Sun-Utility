local battle_group = {}

local Chunk = require("goldensun.memory.chunk")
local BattleGroup = Chunk.new()

function BattleGroup:draw_battle()
    for i, enemy in pairs(self:get_enemies()) do enemy:draw_battle(i) end
end

function BattleGroup:get_enemies()
    local enemies = {}
    for i = 1, 5 do
        local enemy = self:new_enemy(i)
        if enemy:get_current_hp() > 0 then enemies[i] = enemy end
    end
    return enemies
end

function BattleGroup:total_enemy_level()
    local level = 0
    for _, enemy in pairs(self:get_enemies()) do
        level = level + enemy:get_level()
    end

    return level
end

function BattleGroup:get_average_enemy_level()
    return self:total_enemy_level() / #self:get_enemies()
end

function battle_group.new(o)
    local self = o or {}
    setmetatable(self, {__index = BattleGroup})
    self.__index = self
    return self
end

return battle_group
