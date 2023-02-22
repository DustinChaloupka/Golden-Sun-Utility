local tla = {}

local Game = require("goldensun.game")
local TLA = Game.new {
    camera = require("goldensun.memory.game.tla.camera"),
    encounters = require("goldensun.memory.game.tla.encounters"),
    field_flags = require("goldensun.game.tla.fieldflags"),
    field_player = require("goldensun.game.tla.fieldplayer"),
    map = require("goldensun.memory.game.tla.map"),
    move_type = require("goldensun.memory.game.tla.movetype"),
    overworld_map = require("goldensun.game.tla.overworldmap"),
    party = require("goldensun.game.tla.party"),
    player = require("goldensun.game.tla.player"),
    ship = require("goldensun.game.tla.ship"),
    rom = require("goldensun.memory.game.tla.rom"),
    zoom = require("goldensun.memory.game.tla.zoom")
}

local function check_hover_pp(self)
    if self.move_type:is_hover_ship(self) then
        local player_id = self.party:player_ids(self)[0]
        local player = require("goldensun.game.tla.player")
        player.id = player_id
        if player:get_current_pp(self) < 1 then
            player:set_current_pp(self, 1)
        end
    end
end

local function check_ship_map_enter(self)
    if self.map:is_normal_ship(self) and not self.ship:is_aboard(self) then
        self.ship:board(self)
        self.field_flags:trigger_exit(self)
    end
end

-- what are these values?
function TLA:calculate_map_location(location)
    return {
        x = bit.lshift(location.x + 269, 14) / 853,
        y = bit.lshift(location.y + 112, 14) / 640
    }
end

function TLA:ship_checks()
    check_ship_map_enter(self)
    check_hover_pp(self)
end

function TLA:teleport_ship()
    if self:key_pressed("L") and self:key_pressed("B") and
        self.map:is_overworld(self) and self:is_in_menu() and
        not self.ship:is_aboard(self) then
        self.ship:set_overworld_location(self,
                                         self.field_player:get_overworld_location(
                                             self))
    end
end

setmetatable(tla, {__index = TLA})

return tla
