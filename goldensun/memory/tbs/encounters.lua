local encounters = {}

local Chunk = require("goldensun.memory.chunk")
local Encounters = Chunk.new {address = 0x02000478, size = 16}

setmetatable(encounters, {__index = Encounters})

local settings = require("config.settings")
function Encounters:disable_if_fast_travel(game)
    if not settings.encounters_if_fast_travel then self:write(game, 0) end
end

return encounters
