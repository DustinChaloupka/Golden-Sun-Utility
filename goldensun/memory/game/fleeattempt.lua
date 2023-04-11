local flee_attempt = {}

local Chunk = require("goldensun.memory.chunk")
local FleeAttempt = Chunk.new({
    -- Why 1000?
    flee_ev_max = 1000,

    ui = {x = {pos = 80, interval = 65}, y = {pos = 30, interval = 10}}
})

function FleeAttempt:get_failed_attempts() return self:read() end

function FleeAttempt:get_flee_attempt(front_average_level, enemy_average_level,
                                      is_battle)
    local attempt_addition = 0
    if is_battle then attempt_addition = 2000 * self:get_failed_attempts() end
    local level_difference = front_average_level - enemy_average_level
    return 5000 + attempt_addition + (level_difference * 500)
end

function FleeAttempt:get_rn_advances_to_flee(rn, attempt)
    local total_rn_advances = 0
    rn:next(1)
    while not self:is_flee_rn(rn, attempt) and total_rn_advances < 100 do
        rn:next(1)
        total_rn_advances = total_rn_advances + 1
    end

    return total_rn_advances
end

function FleeAttempt:is_flee_rn(rn, attempt)
    if attempt > 0 then
        local threshold = rn:distribution(10000)

        return threshold < attempt
    end
end

function FleeAttempt:draw_battle(grn, front_average_level, enemy_average_level)
    local rn = require("goldensun.memory.game.randomnumber").new {
        value = grn.value
    }

    local attempt = self:get_flee_attempt(front_average_level,
                                          enemy_average_level, true)
    local total_rn_advances = self:get_rn_advances_to_flee(rn, attempt)
    local flee_percent = self:get_chance_to_flee(rn, attempt, total_rn_advances)
    local ev = self:get_ev_to_flee(flee_percent)

    drawing:set_text("ACs to Run: " .. total_rn_advances, self.ui.x.pos,
                     self.ui.y.pos)
    drawing:set_text("Chance to Run: " .. flee_percent .. "%", self.ui.x.pos,
                     self.ui.y.pos + self.ui.y.interval)
    drawing:set_text("Run EV: " .. ev, self.ui.x.pos + self.ui.x.interval,
                     self.ui.y.pos)
end

function FleeAttempt:get_chance_to_flee(rn, attempt, total_rn_advances)
    local total_flees = self:is_flee_rn(rn, attempt) and 1 or 0
    local tries = total_rn_advances
    for _ = total_rn_advances, self.flee_ev_max do
        rn:next(1)

        if self:is_flee_rn(rn, attempt) then
            total_flees = total_flees + 1
        end
    end

    return total_flees / 10
end

function FleeAttempt:get_ev_to_flee(flee_percent)
    local flee_probability = flee_percent / 100
    local tries = 1
    local turn_probability = 1
    local ev = flee_probability * tries * turn_probability
    while flee_probability < 1 do
        turn_probability = (1 - flee_probability) * turn_probability
        flee_probability = math.min(flee_probability + 0.2, 1)
        tries = tries + 1
        ev = ev + flee_probability * tries * turn_probability
    end

    return math.ceil(ev * 100) / 100
end

function flee_attempt.new(o)
    local self = o or {}
    setmetatable(self, {__index = FleeAttempt})
    self.__index = self
    return self
end

return flee_attempt
