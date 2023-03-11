local general = {}

local General = require("goldensun.memory.game.randomnumber").new {
    letter_prefix = "G",
    ui = {analysis = {x = 160, y = 0}, x = 0, y = 30}
}

function General:draw_analysis()
    local text = "GRN: " .. self:read()
    if self.frame_counter > 0 then
        text = text .. " " .. self.count_symbol .. self.count_change
        self.frame_counter = self.frame_counter - 1
    end
    drawing:set_text(text, self.ui.analysis.x, self.ui.analysis.y, self.color)
end

function general.new(o)
    local self = o or {}
    setmetatable(self, {__index = General})
    self.__index = self
    return self
end

return general
