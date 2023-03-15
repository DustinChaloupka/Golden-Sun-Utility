local enemy = {}

local Enemy = {}

function Enemy:get_level() return self.character_data:get_level(self.id) end
function Enemy:get_name() return self.enemy_names[self.id] end
function Enemy:set_count(rn)
    self.count = self.min
    if self.max > self.min then
        rn:next(1)
        self.count = self.min + rn:distribution(self.max - self.min + 1)
    end
end

function Enemy:get_count() return self.count or 0 end

function enemy.new(o)
    local self = o or {}
    setmetatable(self, {__index = Enemy})
    self.__index = self
    return self
end

return enemy
