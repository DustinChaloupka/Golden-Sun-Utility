local tbs = {
    rom = 0x646C6F47,
    mapAddress = 0x02000400,
    addresses = {zoomLock = 0x03001CF5},
    movementAddresses = {
        xOver = 0x02030DAE,
        yOver = 0x02030DB6,
        xTown = 0x02030EC6,
        yTown = 0x02030ECE,
        xMapCursor = 0x02010006,
        yMapCursor = 0x0201000A,
        encounters = 0x02000478,
        moveTypeAddr = 0x02000432,
        camAddr = 0x03002000,
        mapFlag = 0x02030CB6,
        collision = {0x0800F3B0}
    }
}

local Game = require("goldensun.game")
local TBS = Game.new()

-- what is this actually doing?
local function cursor_shift(cursor) return bit.lshift(cursor, 8) end

function TBS:calculate_map_x(cursor) return cursor_shift(cursor) / 15 + 0x1000 end

function TBS:calculate_map_y(cursor) return cursor_shift(cursor) / 10 end

setmetatable(tbs, {__index = TBS})

return tbs
