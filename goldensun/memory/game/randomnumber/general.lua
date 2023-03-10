local general = {}

local General = require("goldensun.memory.game.randomnumber").new {
    letter_prefix = "G",
    ui = {analysis = {x = 160, y = 0}, x = 0, y = 30}
}

function General:draw_analysis()
    drawing:set_text("GRN: " .. self:read(), self.ui.analysis.x,
                     self.ui.analysis.y, self.color)
end

function general.new(o)
    local self = o or {}
    setmetatable(self, {__index = General})
    self.__index = self
    return self
end

return general
