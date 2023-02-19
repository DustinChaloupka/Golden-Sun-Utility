local ship = {}

local Ship = {boarding = require("goldensun.memory.tla.boarding")}

function Ship:board(game) self.boarding:board(game) end
function Ship:is_aboard(game) return self.boarding:is_aboard(game) end

setmetatable(ship, {__index = Ship})

return ship
