local tla = {
    camera = 0x03001300,
    collision = {0x08027A52, 0x0802860C, 0x08028B9A},
    coordinates = {
        xOver = 0x020321C2,
        yOver = 0x020321CA,
        xBoat = 0x02032242,
        yBoat = 0x0203224A,
        xTown = 0x020322F6,
        yTown = 0x020322FE,
        xTownBoat = 0x02032376,
        yTownBoat = 0x0203237E,
        xMapCursor = 0x0202A006,
        yMapCursor = 0x0202A00A
    },
    encounters = 0x02000498,
    map = 0x02000420,
    mapFlag = 0x02030CA2,
    moveType = 0x02000452,
    rom = 0x444C4F47,
    zoomLock = 0x03001169
}

local Game = require("goldensun.game")
local TLA = Game.new()

function TLA:calculate_map_x(cursor) return bit.lshift(cursor + 269, 14) / 853 end
function TLA:calculate_map_y(cursor) return bit.lshift(cursor + 112, 14) / 640 end

function TLA:teleport_boat()
    local mapNumber = self.emulator.memory.readword(self.map)
    if (mapNumber == 0xc5 or mapNumber == 0xC6 or mapNumber == 0x10C) and
        self.emulator.memory.readword(0x020004B6) ~= 1 then
        self.emulator.memory.writeword(0x020004B6, 1)
        self.emulator.memory.writeword(0x02030158, 0x3E7)
    end
    if movementType == 8 then
        local playerPP = 0x02000520 + 0x3A + 0x14C *
                             self.emulator.memory.readbyte(0x02000458)
        if self.emulator.memory.readword(playerPP) < 1 then
            self.emulator.memory.writeword(playerPP, 1)
        end
    end
    -- Hold L and press B when in a menu to teleport the boat to you
    if self.emulator:key_pressed("L") and self.emulator:key_pressed("B") and
        mapNumber == 2 and
        bit.band(bit.rshift(self.emulator.memory.readbyte(0x02000060), 6), 1) ==
        1 and self.emulator.memory.readword(0x020004B6) == 0 then
        self.emulator.memory.writeword(self.coordinates.xBoat, self.emulator
                                           .memory
                                           .readword(self.coordinates.xOver))
        self.emulator.memory.writeword(self.coordinates.yBoat, self.emulator
                                           .memory
                                           .readword(self.coordinates.yOver))
    end
end

setmetatable(tla, {__index = TLA})

return tla
