local game = {}

local Game = {state = require("goldensun.memory.game.state")}

function Game:read_word(...) return self.emulator.memory.readword(...) end
function Game:read_dword(...) return self.emulator.memory.readdword(...) end
function Game:write_word(...) return self.emulator.memory.writeword(...) end
function Game:write_dword(...) return self.emulator.memory.writedword(...) end
function Game:read_byte(...) return self.emulator.memory.readbyte(...) end
function Game:write_byte(...) return self.emulator.memory.writebyte(...) end
function Game:key_pressed(...) return self.emulator:key_pressed(...) end

-- Hold L to go fast
function Game:fast_travel()
    if self.emulator:key_pressed("L") then
        local speed = self.move_type:speed_up(self)

        self.camera:add_speed(self, speed)

        self.encounters:disable_if_fast_travel(self)
    end
end

function Game:maybe_get_teleport_location()
    if self.overworld_map:is_teleport_available(self) and self:key_pressed("A") then
        local cursor_location = self.overworld_map:get_teleport_location(self)
        local location = self:calculate_map_location(cursor_location)

        return location
    end
end

function Game:is_in_battle() return self.state:is_battle(self) end
function Game:is_current_rom() return self.rom:is_current_rom(self) end
function Game:is_in_menu() return self.state:is_menu(self) end

function Game:lock_zoom()
    if self.map:is_overworld(self) then self.zoom:lock(self) end
end

-- Press A on world map to teleport to cursor
function Game:teleport_to_cursor()
    local location = self:maybe_get_teleport_location()

    if location then
        self.field_player:set_overworld_location(self, location)
        self.camera:set_location(self, location)
    end
end

function game.new(o)
    local self = o or game
    setmetatable(self, {__index = Game})
    self.__index = self
    return self
end

return game
