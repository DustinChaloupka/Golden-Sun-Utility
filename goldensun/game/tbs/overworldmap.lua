local overworldmap = {}

local OverworldMap = require("goldensun.game.overworldmap").new {
    cursor_location = require("goldensun.memory.tbs.cursorlocation"),
    map_flag = require("goldensun.memory.tbs.mapflag")
}

setmetatable(overworldmap, {__index = OverworldMap})

return overworldmap
