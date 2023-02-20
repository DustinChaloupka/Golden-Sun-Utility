local overworldmap = {}

local OverworldMap = {
    cursor_location = require("goldensun.memory.tla.cursorlocation")
}

function OverworldMap:get_cursor_location(game)
    return self.cursor_location:get_location(game)
end

setmetatable(overworldmap, {__index = OverworldMap})

return overworldmap
