local game = {}

local Game = {
    state = require("goldensun.memory.game.state"),
    transition = require("goldensun.memory.game.transition")
}

-- Manage encounters
function Game:encounter_checks()
    if emulator:key_pressed("E") then
        self.encounters:set_disabled(not self.encounters.is_disabled)
    end

    self.encounters:maybe_disable()

    if emulator:key_pressed("M") then
        self.encounters:set_analysis_enabled(
            not self.encounters.analysis.is_enabled)
        self.movement:set_analysis_enabled(not self.movement.is_analysis_enabled)
        self.random_number.battle:set_analysis_enabled(
            not self.random_number.battle.is_analysis_enabled)
        self.random_number.general:set_analysis_enabled(
            not self.random_number.general.is_analysis_enabled)
    end

    self.encounters:draw(self.movement.type:is_overworld())
    self.encounters:draw_analysis(self.party:get_front_total_level(),
                                  self.random_number.general)
end

function Game:movement_checks() self.movement:draw() end

function Game:random_number_checks()
    if emulator:key_pressed("G") then self.random_number.general:advance(1) end
    if emulator:key_pressed("H") then self.random_number.general:rewind(1) end
    if emulator:key_pressed("B") then self.random_number.battle:advance(1) end
    if emulator:key_pressed("N") then self.random_number.battle:rewind(1) end
    if emulator:key_pressed("R") then
        local grn_advance = math.random(1, 100)
        local brn_advance = math.random(1, 100)
        self.random_number.general:advance(grn_advance)
        self.random_number.battle:advance(brn_advance)
    end

    self.random_number.battle:draw()
    self.random_number.general:draw()
end

-- Hold L to go fast
local settings = require("config.settings")
function Game:fast_travel()
    if emulator:button_pressed("L") and not self.transition:is_in_progress() then
        local speed = self.movement.type:speed_up()

        if speed then self.camera:add_speed(speed) end

        if not settings.encounters_if_fast_travel then
            self.encounters:disable()
        end
    end
end

function Game:maybe_get_teleport_location()
    if self.overworld_map:is_teleport_available() and
        emulator:button_pressed("A") then
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
