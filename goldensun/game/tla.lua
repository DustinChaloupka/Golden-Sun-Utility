local tla = {}

local Game = require("goldensun.game")
local TLA = Game.new {
    camera = require("goldensun.memory.game.tla.camera"),
    encounters = require("goldensun.memory.game.tla.encounters"),
    field_flags = require("goldensun.game.tla.fieldflags"),
    field_player = require("goldensun.game.tla.fieldplayer"),
    map = require("goldensun.memory.game.tla.map"),
    movement = require("goldensun.memory.game.tla.movement"),
    overworld_map = require("goldensun.game.tla.overworldmap"),
    party = require("goldensun.game.tla.party"),
    ship = require("goldensun.game.tla.ship"),
    random_number = {
        battle = require("goldensun.memory.game.tla.randomnumber.battle"),
        general = require("goldensun.memory.game.tla.randomnumber.general")
    },
    rom = require("goldensun.memory.game.tla.rom"),
    zoom = require("goldensun.memory.game.tla.zoom")
}

function TLA:check_hover_pp()
    if self.movement.type:is_hover_ship() then
        local player = self.party:get_players()[1]
        if player:get_current_pp() < 1 then player:set_current_pp(1) end
    end
end

function TLA:check_ship_map_enter()
    if self.map:is_normal_ship() and not self.ship:is_aboard() then
        self.ship:board()
        self.field_flags:trigger_exit()
    end
end

-- what are these values?
function TLA:calculate_map_location(location)
    return {
        x = emulator:lshift(location.x + 269, 14) / 853,
        y = emulator:lshift(location.y + 112, 14) / 640
    }
end

function TLA:specific_checks()
    self:check_ship_map_enter()
    self:check_hover_pp()
    self:teleport_ship()
end

function TLA:teleport_ship()
    if emulator:button_pressed("L") and emulator:button_pressed("B") and
        self.map:is_overworld() and self:is_in_menu() and
        not self.ship:is_aboard() then
        self.ship:set_overworld_location(
            self.field_player:get_overworld_location())
    end
end

-- Press A on world map to teleport to cursor
function TLA:teleport_to_cursor()
    local location = self:maybe_get_teleport_location()

    if location then
        if self.movement.type:is_ship() then
            self.ship:set_overworld_location(location)
        else
            self.field_player:set_overworld_location(location)
        end
        self.camera:set_location(location)
    end
end

setmetatable(tla, {__index = TLA})

return tla
