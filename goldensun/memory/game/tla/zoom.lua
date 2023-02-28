local zoom = {}

local Zoom = require("goldensun.memory.game.zoom").new {
    address = 0x03001169,
    size = 8,
    locked = 2
}

setmetatable(zoom, {__index = Zoom})

return zoom
