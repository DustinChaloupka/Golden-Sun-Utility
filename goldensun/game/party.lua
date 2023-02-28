local party = {}

local Party = {}

function Party:player_ids() return self.order:get_ids() end

function party.new(o)
    local self = o or {}
    setmetatable(self, {__index = Party})
    self.__index = self
    return self
end

return party
