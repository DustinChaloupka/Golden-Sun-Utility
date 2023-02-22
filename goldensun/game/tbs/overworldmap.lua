local overworldmap = {}

local OverworldMap = require("goldensun.game.overworldmap").new {
    cursor_location = require("goldensun.memory.game.tbs.cursorlocation"),
    map_flag = require("goldensun.memory.game.tbs.mapflag")
}

setmetatable(overworldmap, {__index = OverworldMap})

return overworldmap
