local battle_group = {}

local Chunk = require("goldensun.memory.chunk")
local BattleGroup = Chunk.new()

function BattleGroup:draw_battle()
    for i, enemy in ipairs(self:get_enemies()) do enemy:draw_battle(i) end
end

function BattleGroup:get_enemies()
    local enemies = {}
    for i = 1, 5 do
        local enemy = self:new_enemy()
        enemies[i] = enemy
    end

    return enemies
end

function battle_group.new(o)
    local self = o or {}
    setmetatable(self, {__index = BattleGroup})
    self.__index = self
    return self
end

return battle_group
