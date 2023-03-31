local player = {}

local Player = {
    ui = {battle = {x = {pos = 0, interval = 0}, y = {pos = 40, interval = 10}}}
}

function Player:get_current_hp()
    return self.character_data:get_current_hp(self.id)
end

function Player:get_current_pp()
    return self.character_data:get_current_pp(self.id)
end

function Player:set_current_pp(value)
    self.character_data:set_current_pp(self.id, value)
end

function Player:get_level() return self.character_data:get_level(self.id) end

function Player:get_turn_agility(slot)
    return self.character_data:get_turn_agility(slot)
end

function Player:draw_battle(slot)
    local text = "PC" .. slot .. " Agi: " .. self:get_turn_agility(slot)
    drawing:set_text(text, self.ui.battle.x.pos,
                     self.ui.battle.y.pos + slot * self.ui.battle.y.interval)
end

function player.new(o)
    local self = o or {}
    setmetatable(self, {__index = Player})
    self.__index = self
    return self
end

return player
