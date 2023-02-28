local encounters = {}

local Encounters = {}

function Encounters:disable() self.lock:write(0) end

local settings = require("config.settings")
function Encounters:disable_if_fast_travel()
    if not settings.encounters_if_fast_travel then self:disable() end
end

function Encounters:get_step_count() return self.step_count:read() end

function encounters.new(o)
    local self = o or {}
    setmetatable(self, {__index = Encounters})
    self.__index = self
    return self
end

return encounters
