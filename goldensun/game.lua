local game = {}

local Game = {}

-- Hold L to go fast
local settings = require("config.settings")
local camSpeed
function Game:fast_travel()
    function move(xAddr, yAddr, speed)
        local x = memory.readword(xAddr)
        local y = memory.readword(yAddr)
        if emulator:key_pressed("down") then y = y + speed end
        if emulator:key_pressed("up") then y = y - speed end
        if emulator:key_pressed("left") then x = x - speed end
        if emulator:key_pressed("right") then x = x + speed end
        memory.writeword(xAddr, x)
        memory.writeword(yAddr, y)
        camSpeed = speed
    end

    if emulator:key_pressed("L") then
        local mapNumber = memory.readword(self.mapAddress)
        local movementType =
            memory.readbyte(self.movementAddresses.moveTypeAddr)
        if mapNumber == 2 then
            if movementType == 7 then
                move(self.movementAddresses.xBoat, self.movementAddresses.yBoat,
                     settings.boatSpeed)
            elseif movementType == 8 then
                move(self.movementAddresses.xBoat, self.movementAddresses.yBoat,
                     settings.hoverBoatSpeed)
            elseif emulator:key_pressed("B") then
                move(self.movementAddresses.xOver, self.movementAddresses.yOver,
                     settings.overRunSpeed)
            else
                move(self.movementAddresses.xOver, self.movementAddresses.yOver,
                     settings.overWorldSpeed)
            end

            local xCamera = memory.readdword(self.movementAddresses.camAddr) +
                                0x2
            local yCamera = memory.readdword(self.movementAddresses.camAddr) +
                                0xA
            move(xCamera, yCamera, camSpeed - 1)
        else
            if movementType == 6 then
                move(self.movementAddresses.xTownBoat,
                     self.movementAddresses.yTownBoat, settings.townSpeed)
            else
                move(self.movementAddresses.xTown, self.movementAddresses.yTown,
                     settings.townSpeed)
            end
        end

        if settings.encountersIfHoldingL == false then
            memory.writeword(self.movementAddresses.encounters, 0)
        end
    end
end

function Game:lock_zoom()
    local mapNumber = memory.readword(self.mapAddress)
    if self.addresses and mapNumber == 2 then
        memory.writebyte(self.addresses.zoomLock, 2)
    end
end

function Game:teleport_boat() end

-- Press A on world map to teleport to cursor
local switch = false
local xCursor
local yCursor
function Game:teleport_to_cursor()
    local mapState =
        bit.band(memory.readbyte(self.movementAddresses.mapFlag), 1)
    if mapState == 0 then switch = false end
    if mapState == 1 and switch == false and emulator:key_pressed("A") == true then
        local x = self:calculate_map_x(xCursor)
        local y = self:calculate_map_y(yCursor)

        local movementType =
            memory.readbyte(self.movementAddresses.moveTypeAddr)
        if movementType == 7 or movementType == 8 then
            memory.writeword(self.movementAddresses.xBoat, x)
            memory.writeword(self.movementAddresses.yBoat, y)
        else
            memory.writeword(self.movementAddresses.xOver, x)
            memory.writeword(self.movementAddresses.yOver, y)
        end

        local xCamera = memory.readdword(self.movementAddresses.camAddr) + 0x2
        local yCamera = memory.readdword(self.movementAddresses.camAddr) + 0xA

        memory.writeword(xCamera, x)
        memory.writeword(yCamera, y)
        switch = true
    end

    xCursor = memory.readword(self.movementAddresses.xMapCursor)
    yCursor = memory.readword(self.movementAddresses.yMapCursor)
end

function game.new()
    local self = setmetatable({}, {__index = Game})
    return self
end

return game
