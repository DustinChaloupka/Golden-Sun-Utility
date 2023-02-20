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
local cam_speed
function Game:fast_travel()
    function move_coordinates(coordinates, speed)
        local x = coordinates:get_x(self)
        local y = coordinates:get_y(self)
        if self:key_pressed("down") then y = y + speed end
        if self:key_pressed("up") then y = y - speed end
        if self:key_pressed("left") then x = x - speed end
        if self:key_pressed("right") then x = x + speed end
        coordinates:set_x(self, x)
        coordinates:set_y(self, y)
        cam_speed = speed
    end

    if self.emulator:key_pressed("L") then
        if self.map:is_overworld(self) then
            if self.move_type:is_overworld_ship(self) then
                move_coordinates(self.ship.overworld_location,
                                 settings.boatSpeed)
            elseif self.move_type:is_hover_ship(self) then
                move_coordinates(self.ship.overworld_location,
                                 settings.hoverBoatSpeed)
            elseif self.emulator:key_pressed("B") then
                move_coordinates(self.field_player.overworld_location,
                                 settings.overRunSpeed)
            else
                move_coordinates(self.field_player.overworld_location,
                                 settings.overWorldSpeed)
            end

            move_coordinates(self.camera:get_location(self), cam_speed - 1)
        else
            if self.move_type:is_normal_ship(self) then
                move_coordinates(self.ship.normal_location, settings.townSpeed)
            else
                move_coordinates(self.field_player.normal_location,
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
    if self.map:is_overworld(self) then self.zoom_lock:write(self, 2) end
end

function Game:teleport_ship() end

-- Press A on world map to teleport to cursor
local switch = false
local cursor_location
function Game:teleport_to_cursor()
    local mapState = bit.band(self:read_byte(self.mapFlag), 1)
    if mapState == 0 then switch = false end
    if mapState == 1 and switch == false and self:key_pressed("A") == true then
        local location = self:calculate_map_location(cursor_location)

        if self.move_type:is_ship(self) then
            self.ship:set_overworld_location(self, location)
        else
            self.field_player:set_overworld_location(self, location)
        end

        self.camera:set_location(self, location)
        switch = true
    end

    cursor_location = self.overworld_map:get_cursor_location(self)
end

function game.new(o)
    local self = o or game
    setmetatable(self, {__index = Game})
    self.__index = self
    return self
end

return game
