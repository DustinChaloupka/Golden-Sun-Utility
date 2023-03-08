local encounters = {}

local Encounters = {}

function Encounters:disable() self.lock:write(0) end

function Encounters:maybe_disable() if self.is_disabled then self:disable() end end

function Encounters:draw(is_overworld)
    self.step_count:draw()
    self.step_rate:draw(is_overworld)
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
