local party = {}

local Party = {}

function Party:player_ids() return self.order:get_ids() end

function Party:get_players()
    local player_ids = self:player_ids()
    local players = {}
    for i, id in ipairs(player_ids) do
        local player = self:new_player(id)
        players[i] = player
    end

    return players
end

function Party:get_front_total_level()
    local total_level = 0
    local players = self:get_players()
    for i = 1, 4 do
        local player = players[i]
        if not players[i] then break end

        total_level = total_level + player:get_level()
    end

    return total_level
end

function Party:draw_battle()
    local players = self:get_players()
    for i = 4, 1, -1 do
        -- hacky way to only show the player agility from turn data when selecting turn
        local finished_selecting = i == 4 and players[i]:get_turn_agility(i) > 0
        if not players[i] or finished_selecting then break end
        players[i]:draw_battle(i)
    end
end

function party.new(o)
    local self = o or {}
    setmetatable(self, {__index = Party})
    self.__index = self
    return self
end

return party
