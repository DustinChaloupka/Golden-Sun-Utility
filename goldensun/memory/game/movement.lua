local movement = {}

local Movement = {analysis = {is_enabled = false}}

function Movement:draw()
    if self.analysis.is_enabled then
        -- draw analysis
    else
        self.tick:draw()
    end
end

function Movement:toggle_analysis_enabled()
    self.analysis.is_enabled = not self.analysis.is_enabled
end

function movement.new(o)
    local self = o or {}
    setmetatable(self, {__index = Movement})
    self.__index = self
    return self
end

return movement
