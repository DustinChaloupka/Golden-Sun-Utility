local encounters = {}

local Encounters = {ui = {x = 0, y = 20}}

function Encounters:disable() self.lock:write(0) end

local settings = require("config.settings")
function Encounters:disable_if_fast_travel()
    if not settings.encounters_if_fast_travel then self:disable() end
end

function Encounters:draw()
    drawing:set_text("Step Count: " .. self.step_count:read(), self.ui.x,
                     self.ui.y)
end

function encounters.new(o)
    local self = o or {}
    setmetatable(self, {__index = Encounters})
    self.__index = self
    return self
end

return encounters
