local party = {}

local Party = {order = require("goldensun.memory.tla.party.order")}

function Party:player_ids(game) return self.order:get_ids(game) end

setmetatable(party, {__index = Party})

return party
