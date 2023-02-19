local game = {rom = 0x080000A0}

local Game = {}

function Game:read_word(...) return self.emulator.memory.readword(...) end
function Game:read_dword(...) return self.emulator.memory.readdword(...) end
function Game:write_word(...) return self.emulator.memory.writeword(...) end
function Game:write_dword(...) return self.emulator.memory.writedword(...) end
function Game:read_byte(...) return self.emulator.memory.readbyte(...) end
function Game:write_byte(...) return self.emulator.memory.writebyte(...) end
function Game:key_pressed(...) return self.emulator:key_pressed(...) end

-- Hold L to go fast
local settings = require("config.settings")
local camSpeed
function Game:fast_travel()
    function move(xAddr, yAddr, speed)
        local x = self:read_word(xAddr)
        local y = self:read_word(yAddr)
        if self:key_pressed("down") then y = y + speed end
        if self:key_pressed("up") then y = y - speed end
        if self:key_pressed("left") then x = x - speed end
        if self:key_pressed("right") then x = x + speed end
        self:write_word(xAddr, x)
        self:write_word(yAddr, y)
        camSpeed = speed
    end

    if self.emulator:key_pressed("L") then
        if self.map:is_overworld(self) then
            if self.move_type:is_overworld_ship(self) then
                move(self.coordinates.xBoat, self.coordinates.yBoat,
                     settings.boatSpeed)
            elseif self.move_type:is_hover_ship(self) then
                move(self.coordinates.xBoat, self.coordinates.yBoat,
                     settings.hoverBoatSpeed)
            elseif self.emulator:key_pressed("B") then
                move(self.coordinates.xOver, self.coordinates.yOver,
                     settings.overRunSpeed)
            else
                move(self.coordinates.xOver, self.coordinates.yOver,
                     settings.overWorldSpeed)
            end

            local xCamera = self:read_dword(self.camera) + 0x2
            local yCamera = self:read_dword(self.camera) + 0xA
            move(xCamera, yCamera, camSpeed - 1)
        else
            if self.move_type:is_normal_ship(self) then
                move(self.coordinates.xTownBoat, self.coordinates.yTownBoat,
                     settings.townSpeed)
            else
                move(self.coordinates.xTown, self.coordinates.yTown,
                     settings.townSpeed)
            end
        end

        if settings.encountersIfHoldingL == false then
            self:write_word(self.encounters, 0)
        end
    end
end

function Game:is_battle()
    return bit.band(bit.rshift(self:read_byte(0x02000060), 3), 1) == 1
end

function Game:lock_zoom()
    if self.map:is_overworld(self) then self:write_byte(self.zoomLock, 2) end
end

function Game:teleport_boat() end

-- Press A on world map to teleport to cursor
local switch = false
local xCursor
local yCursor
function Game:teleport_to_cursor()
    local mapState = bit.band(self:read_byte(self.mapFlag), 1)
    if mapState == 0 then switch = false end
    if mapState == 1 and switch == false and self:key_pressed("A") == true then
        local x = self:calculate_map_x(xCursor)
        local y = self:calculate_map_y(yCursor)

        self.move_type:read(self)
        if self.move_type:is_ship(self) then
            self:write_word(self.coordinates.xBoat, x)
            self:write_word(self.coordinates.yBoat, y)
        else
            self:write_word(self.coordinates.xOver, x)
            self:write_word(self.coordinates.yOver, y)
        end

        local xCamera = self:read_dword(self.camera) + 0x2
        local yCamera = self:read_dword(self.camera) + 0xA

        self:write_word(xCamera, x)
        self:write_word(yCamera, y)
        switch = true
    end

    xCursor = self:read_word(self.coordinates.xMapCursor)
    yCursor = self:read_word(self.coordinates.yMapCursor)
end

function game.new(o)
    local self = o or game
    setmetatable(self, {__index = Game})
    self.__index = self
    return self
end

return game
