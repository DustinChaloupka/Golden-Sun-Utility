local overworldmap = {}

local OverworldMap = require("goldensun.game.overworldmap").new {
    cursor_location = require("goldensun.memory.game.tla.cursorlocation"),
    map_flag = require("goldensun.memory.game.tla.mapflag")
}

setmetatable(overworldmap, {__index = OverworldMap})

return overworldmap
