local overworldmap = {}

local OverworldMap = {
    cursor_location = require("goldensun.memory.tla.cursorlocation"),
    map_flag = require("goldensun.memory.tla.mapflag"),

    -- When the overworld map closes, the map flag is still enabled, so
    -- checks to see it is open need to also check that it has finished closing
    has_closed = true
}

function OverworldMap:get_cursor_location(game)
    return self.cursor_location:get_location(game)
end

function OverworldMap:get_teleport_location(game)
    self.has_closed = false
    return self:get_cursor_location(game)
end

function OverworldMap:is_open(game) return self.map_flag:is_enabled(game) end

function OverworldMap:is_teleport_available(game)
    if self:is_open(game) and self.has_closed then
        return true
    elseif not self:is_open(game) then
        self.has_closed = true
    end

    return false
end

setmetatable(overworldmap, {__index = OverworldMap})

return overworldmap
