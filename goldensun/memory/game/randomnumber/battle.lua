local battle = {}

local Battle = require("goldensun.memory.game.randomnumber").new {
    letter_prefix = "B",
    ui = {x = 0, y = 40},

    analysis = {is_enabled = false},

    frame_counter = 0,

    value = 0,

    attacks_first = 0xF,
    -- This doesn't seem to be correct, but not sure what is
    caught_by_surprise = 0x1F
}

function Battle:draw_analysis() end

function Battle:is_attacks_first()
    return bit.band(self:read(), self.attacks_first) == 0
end

function Battle:is_caught_by_surprise()
    return bit.band(self:read(), self.caught_by_surprise) == 0
end

function battle.new(o)
    local self = o or {}
    setmetatable(self, {__index = Battle})
    self.__index = self
    return self
end

return battle
