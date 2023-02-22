local camera = {}

local Camera = require("goldensun.memory.game.camera").new {
    address = 0x03001300,
    size = 32,

    location = require("goldensun.memory.game.tla.camera.location")
}

setmetatable(camera, {__index = Camera})

return camera
