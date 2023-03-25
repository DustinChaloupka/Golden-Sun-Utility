local enemy = {}

local Enemy = {
    ui = {
        battle = {x = {pos = 60, interval = 50}, y = {pos = 40, interval = 10}}
    }
}

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

function Enemy:get_turn_agility(slot)
    return self.character_data:get_turn_agility(slot)
end

function Enemy:get_current_hp(slot)
    return self.character_data.battle_data:get_current_hp(slot)
end

function Enemy:draw_battle(slot)
    local current_hp = self:get_current_hp(slot)
    -- slot 5 seems to hold some data on encounter load that puts the hp value above 61k
    if current_hp <= 0 or current_hp > 61000 then return end

    local agility_text = "E" .. slot .. " Agi: " .. self:get_turn_agility(slot)
    drawing:set_text(agility_text, self.ui.battle.x.pos,
                     self.ui.battle.y.pos + slot * self.ui.battle.y.interval)
    local hp_text = "HP: " .. self:get_current_hp(slot)
    drawing:set_text(hp_text, self.ui.battle.x.pos + self.ui.battle.x.interval,
                     self.ui.battle.y.pos + slot * self.ui.battle.y.interval)
end

function enemy.new(o)
    local self = o or {}
    setmetatable(self, {__index = Enemy})
    self.__index = self
    return self
end

return enemy
