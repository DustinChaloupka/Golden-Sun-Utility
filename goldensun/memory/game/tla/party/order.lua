local order = {}

local Order = require("goldensun.memory.game.party.order").new {
    max_size = 8,

    address = 0x02000458,
    size = 8
}

setmetatable(order, {__index = Order})

return order
