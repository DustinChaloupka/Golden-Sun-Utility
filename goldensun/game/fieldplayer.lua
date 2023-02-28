local fieldplayer = {}

local FieldPlayer = {}

function FieldPlayer:get_normal_location()
    return self.overworld_location:get_location()
end

function FieldPlayer:get_overworld_location()
    return self.overworld_location:get_location()
end

function FieldPlayer:set_overworld_location(location)
    self.overworld_location:set_location(location)
end

function FieldPlayer:set_normal_location(location)
    self.normal_location:set_location(location)
end

function fieldplayer.new(o)
    local self = o or {}
    setmetatable(self, {__index = FieldPlayer})
    self.__index = self
    return self
end

return fieldplayer
