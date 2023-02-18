local game = {rom = 0x080000A0}

local Game = {}

-- Hold L to go fast
local settings = require("config.settings")
local camSpeed
function Game:fast_travel()
    function move(xAddr, yAddr, speed)
        local x = self.emulator.memory.readword(xAddr)
        local y = self.emulator.memory.readword(yAddr)
        if self.emulator:key_pressed("down") then y = y + speed end
        if self.emulator:key_pressed("up") then y = y - speed end
        if self.emulator:key_pressed("left") then x = x - speed end
        if self.emulator:key_pressed("right") then x = x + speed end
        self.emulator.memory.writeword(xAddr, x)
        self.emulator.memory.writeword(yAddr, y)
        camSpeed = speed
    end

    if self.emulator:key_pressed("L") then
        local mapNumber = self.emulator.memory.readword(self.map)
        local movementType = self.emulator.memory.readbyte(self.moveType)
        if mapNumber == 2 then
            if movementType == 7 then
                move(self.coordinates.xBoat, self.coordinates.yBoat,
                     settings.boatSpeed)
            elseif movementType == 8 then
                move(self.coordinates.xBoat, self.coordinates.yBoat,
                     settings.hoverBoatSpeed)
            elseif self.emulator:key_pressed("B") then
                move(self.coordinates.xOver, self.coordinates.yOver,
                     settings.overRunSpeed)
            else
                move(self.coordinates.xOver, self.coordinates.yOver,
                     settings.overWorldSpeed)
            end

            local xCamera = self.emulator.memory.readdword(self.camera) + 0x2
            local yCamera = self.emulator.memory.readdword(self.camera) + 0xA
            move(xCamera, yCamera, camSpeed - 1)
        else
            if movementType == 6 then
                move(self.coordinates.xTownBoat, self.coordinates.yTownBoat,
                     settings.townSpeed)
            else
                move(self.coordinates.xTown, self.coordinates.yTown,
                     settings.townSpeed)
            end
        end

        if settings.encountersIfHoldingL == false then
            self.emulator.memory.writeword(self.encounters, 0)
        end
    end
end

function Game:is_battle()
    return
        bit.band(bit.rshift(self.emulator.memory.readbyte(0x02000060), 3), 1) ==
            1
end

function Game:lock_zoom()
    local mapNumber = memory.readword(self.map)
    if self and mapNumber == 2 then
        self.emulator.memory.writebyte(self.zoomLock, 2)
    end
end

function Game:teleport_boat() end

-- Press A on world map to teleport to cursor
local switch = false
local xCursor
local yCursor
function Game:teleport_to_cursor()
    local mapState = bit.band(self.emulator.memory.readbyte(self.mapFlag), 1)
    if mapState == 0 then switch = false end
    if mapState == 1 and switch == false and self.emulator:key_pressed("A") ==
        true then
        local x = self:calculate_map_x(xCursor)
        local y = self:calculate_map_y(yCursor)

        local movementType = self.emulator.memory.readbyte(self.moveType)
        if movementType == 7 or movementType == 8 then
            self.emulator.memory.writeword(self.coordinates.xBoat, x)
            self.emulator.memory.writeword(self.coordinates.yBoat, y)
        else
            self.emulator.memory.writeword(self.coordinates.xOver, x)
            self.emulator.memory.writeword(self.coordinates.yOver, y)
        end

        local xCamera = self.emulator.memory.readdword(self.camera) + 0x2
        local yCamera = self.emulator.memory.readdword(self.camera) + 0xA

        self.emulator.memory.writeword(xCamera, x)
        self.emulator.memory.writeword(yCamera, y)
        switch = true
    end

    xCursor = self.emulator.memory.readword(self.coordinates.xMapCursor)
    yCursor = self.emulator.memory.readword(self.coordinates.yMapCursor)
end

function game.new()
    local self = game
    setmetatable(self, {__index = Game})
    self.__index = self
    return self
end

return game
