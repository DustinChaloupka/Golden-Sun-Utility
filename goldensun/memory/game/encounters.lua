local encounters = {}

local Encounters = {}

function Encounters:disable() self.lock:write(0) end

local settings = require("config.settings")
function Encounters:disable_if_fast_travel()
    if not settings.encounters_if_fast_travel then self:disable() end
end

function Encounters:draw(is_overworld)
    self.step_count:draw()
    self.step_rate:draw(is_overworld)
end

function encounters.new(o)
    local self = o or {}
    setmetatable(self, {__index = Encounters})
    self.__index = self
    return self
end

return encounters
