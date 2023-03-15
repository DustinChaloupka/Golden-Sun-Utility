local order = {}

local Order = require("goldensun.memory.game.group.order").new {
    address = 0x0812CE7C,
    size = 16,

    id_offset = 2,
    id_size = 16
}

setmetatable(order, {__index = Order})

return order
