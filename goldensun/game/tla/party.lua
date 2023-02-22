local party = {}

local Party = require("goldensun.game.party").new {
    order = require("goldensun.memory.game.tla.party.order")
}

setmetatable(party, {__index = Party})

return party
