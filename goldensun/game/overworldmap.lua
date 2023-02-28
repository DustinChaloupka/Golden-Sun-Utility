local overworldmap = {}

local OverworldMap = {
    -- When the overworld map closes, the map flag is still enabled, so
    -- checks to see it is open need to also check that it has finished closing
    has_closed = true
}

function OverworldMap:get_cursor_location()
    return self.cursor_location:get_location()
end

function OverworldMap:get_teleport_location()
    self.has_closed = false
    return self:get_cursor_location()
end

function OverworldMap:is_open() return self.map_flag:is_enabled() end

function OverworldMap:is_teleport_available()
    if self:is_open() and self.has_closed then
        return true
    elseif not self:is_open() and not self.has_closed then
        self.has_closed = true
    end

    return false
end

function overworldmap.new(o)
    local self = o or {}
    setmetatable(self, {__index = OverworldMap})
    self.__index = self
    return self
end

return overworldmap
