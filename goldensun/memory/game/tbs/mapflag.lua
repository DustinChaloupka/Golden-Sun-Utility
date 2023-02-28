local mapflag = {}

local MapFlag = require("goldensun.memory.game.mapflag").new {
    address = 0x02030CB6,
    size = 8,
    enabled = 1
}

setmetatable(mapflag, {__index = MapFlag})

return mapflag
