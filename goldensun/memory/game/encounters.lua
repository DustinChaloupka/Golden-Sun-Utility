local encounters = {}

local Encounters = {}

function Encounters:disable(game) self.lock:write(game, 0) end

local settings = require("config.settings")
function Encounters:disable_if_fast_travel(game)
    if not settings.encounters_if_fast_travel then self:disable(game) end
end

function Encounters:get_step_count(game) return self.step_count:read(game) end

function encounters.new(o)
    local self = o or {}
    setmetatable(self, {__index = Encounters})
    self.__index = self
    return self
end

return encounters
