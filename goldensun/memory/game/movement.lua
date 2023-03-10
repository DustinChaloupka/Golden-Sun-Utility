local movement = {}

local Movement = {}

function Movement:draw()
    if self.is_analysis_enabled then
        -- draw analysis
    else
        self.tick:draw()
    end
end

function Movement:set_analysis_enabled(is_enabled)
    self.is_analysis_enabled = is_enabled
end

function movement.new(o)
    local self = o or {}
    setmetatable(self, {__index = Movement})
    self.__index = self
    return self
end

return movement
