local tla = {}

local Game = require("goldensun.game")
local TLA = Game.new {
    camera = 0x03001300,
    collision = {0x08027A52, 0x0802860C, 0x08028B9A},
    coordinates = {
        xOver = 0x020321C2,
        yOver = 0x020321CA,
        xTown = 0x020322F6,
        yTown = 0x020322FE,
        xMapCursor = 0x0202A006,
        yMapCursor = 0x0202A00A
    },
    encounters = 0x02000498,
    field_flags = require("goldensun.tla.fieldflags"),
    map = require("goldensun.memory.tla.map"),
    mapFlag = 0x02030CA2,
    move_type = require("goldensun.memory.tla.movetype"),
    party = require("goldensun.tla.party"),
    player = require("goldensun.tla.player"),
    ship = require("goldensun.tla.ship"),
    rom = 0x444C4F47,
    zoomLock = 0x03001169
}

local function check_hover_pp(self)
    if self.move_type:is_hover_ship(self) then
        local player_id = self.party:player_ids(self)[0]
        local player = require("goldensun.tla.player")
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

function TLA:calculate_map_x(cursor) return bit.lshift(cursor + 269, 14) / 853 end
function TLA:calculate_map_y(cursor) return bit.lshift(cursor + 112, 14) / 640 end

function TLA:ship_checks()
    check_ship_map_enter(self)
    check_hover_pp(self)
end

function TLA:teleport_ship()
    if self:key_pressed("L") and self:key_pressed("B") and
        self.map:is_overworld(self) and
        bit.band(bit.rshift(self:read_byte(0x02000060), 6), 1) == 1 and
        self:read_word(0x020004B6) == 0 then
        self.ship:set_overworld_location(self, self:read_word(
                                             self.coordinates.xOver),
                                         self:read_word(self.coordinates.yOver))
    end
end

setmetatable(tla, {__index = TLA})

return tla
