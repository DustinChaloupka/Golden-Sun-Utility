local timer = {}

local Timer = {}

function Timer:draw() end

function Timer:toggle()
    self.is_enabled = not self.is_enabled
    self.ticks = 0
    print(self.name .. " timer " ..
              string.format(self.is_enabled and "enabled" or "disabled"))

end

function Timer:toggle_analysis_enabled()
    self.analysis.is_enabled = not self.analysis.is_enabled
end

function timer.new(o)
    local self = o or {}
    setmetatable(self, {__index = Timer})
    self.__index = self
    return self
end

return timer
