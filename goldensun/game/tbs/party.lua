local party = {}

local Party = require("goldensun.game.party").new {
    order = require("goldensun.memory.game.tbs.party.order")
}

function Party:new_player(id)
    return require("goldensun.game.tbs.player").new({id = id})
end

setmetatable(party, {__index = Party})

return party
