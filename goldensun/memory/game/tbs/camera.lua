local camera = {}

local Camera = require("goldensun.memory.game.camera").new {
    address = 0x03002000,
    size = 32,

    location = require("goldensun.memory.game.tbs.camera.location")
}

setmetatable(camera, {__index = Camera})

return camera
