local map = {}

local Map = require("goldensun.memory.game.map").new {
    address = 0x02000420,
    size = 16,

    world = 2,
    sea_of_time_a = 197,
    sea_of_time_b = 198,
    northern_reaches = 268,
    battle = 510
}

function Map:is_normal_ship()
    local value = self:read()
    return
        value == self.sea_of_time_a or value == self.sea_of_time_b or value ==
            self.northern_reaches
end

setmetatable(map, {__index = Map})

return map
