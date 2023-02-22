local encounters = {}

local Chunk = require("goldensun.memory.chunk")
local Encounters = Chunk.new()

local settings = require("config.settings")
function Encounters:disable_if_fast_travel(game)
    if not settings.encounters_if_fast_travel then self:write(game, 0) end
end

function encounters.new(o)
    local self = o or {}
    setmetatable(self, {__index = Encounters})
    self.__index = self
    return self
end

return encounters
