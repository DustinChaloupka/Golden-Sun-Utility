local battle = {}

local Battle = require("goldensun.memory.game.randomnumber").new {
    letter_prefix = "B",
    ui = {x = 0, y = 40},

    analysis = {is_enabled = false},

    frame_counter = 0,

    value = 0
}

function Battle:draw_analysis() end

function battle.new(o)
    local self = o or {}
    setmetatable(self, {__index = Battle})
    self.__index = self
    return self
end

return battle
