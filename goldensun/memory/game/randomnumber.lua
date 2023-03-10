local randomnumber = {}

local Chunk = require("goldensun.memory.chunk")
local RandomNumber = Chunk.new()

function RandomNumber:set_analysis_enabled(is_enabled)
    self.is_analysis_enabled = is_enabled
end

function RandomNumber:draw()
    if self.is_analysis_enabled then
        self:draw_analysis()
    else
        drawing:set_text(self.letter_prefix .. "RN: " .. self:read(), self.ui.x,
                         self.ui.y, self.color)
    end
end

function randomnumber.new(o)
    local self = o or {}
    setmetatable(self, {__index = RandomNumber})
    self.__index = self
    return self
end

return randomnumber
