local encounters = {}

local Encounters = {}

function Encounters:disable() self.lock:write(0) end

function Encounters:maybe_disable() if self.is_disabled then self:disable() end end

function Encounters:draw(is_overworld)
    if self.is_analysis_enabled then
        -- draw analysis
    else
        self.step_count:draw()
        self.step_rate:draw(is_overworld)
    end
end

function Encounters:set_analysis_enabled(is_enabled)
    self.is_analysis_enabled = is_enabled
end

function Encounters:set_disabled(is_disabled)
    print("Encounters " ..
              string.format(is_disabled and "disabled" or "enabled"))
    self.is_disabled = is_disabled
end

function encounters.new(o)
    local self = o or {}
    setmetatable(self, {__index = Encounters})
    self.__index = self
    return self
end

return encounters
