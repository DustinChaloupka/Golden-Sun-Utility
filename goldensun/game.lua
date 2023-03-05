local game = {}

local Game = {state = require("goldensun.memory.game.state")}

-- Show information around encounters
function Game:encounter_checks()
    local step_count = self.encounters:get_step_count()
    emulator.gui:draw_step_count(step_count)
end

-- Hold L to go fast
function Game:fast_travel()
    if emulator:key_pressed("L") then
        local speed = self.move_type:speed_up()

        if speed then self.camera:add_speed(speed) end

        self.encounters:disable_if_fast_travel()
    end
end

function Game:maybe_get_teleport_location()
    if self.overworld_map:is_teleport_available() and emulator:key_pressed("A") then
        local cursor_location = self.overworld_map:get_teleport_location()
        local location = self:calculate_map_location(cursor_location)

        return location
    end
end

-- The state takes a bit to change, but the map changes right away?
function Game:is_in_battle()
    return self.state:is_battle() or self.map:is_battle()
end
function Game:is_current_rom() return self.rom:is_current_rom() end
function Game:is_in_menu() return self.state:is_menu() end

function Game:lock_zoom()
    if not self:is_in_menu() and self.map:is_overworld() then
        self.zoom:lock()
    end
end

-- Press A on world map to teleport to cursor
function Game:teleport_to_cursor()
    local location = self:maybe_get_teleport_location()

    if location then
        self.field_player:set_overworld_location(location)
        self.camera:set_location(location)
    end
end

function game.new(o)
    local self = o or game
    setmetatable(self, {__index = Game})
    self.__index = self
    return self
end

return game
