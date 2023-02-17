local game = {}

local Game = {}

function Game:maybe_lock_zoom(mapNumber)
    if self.addresses and mapNumber == 2 then
        memory.writebyte(self.addresses.zoomLock, 2)
    end
end

function Game:maybe_teleport_boat(mapNumber) end

function game.new()
    local self = setmetatable({}, {__index = Game})
    return self
end

return game
