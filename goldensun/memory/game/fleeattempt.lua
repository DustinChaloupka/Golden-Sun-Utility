local flee_attempt = {}

local Chunk = require("goldensun.memory.chunk")
local FleeAttempt = Chunk.new({
    ui = {x = {pos = 80, interval = 50}, y = {pos = 30, interval = 0}}
})

function FleeAttempt:get_failed_attempts() return self:read() end

function FleeAttempt:get_rn_advances_to_flee(rn, front_average_level,
                                             enemy_average_level, is_battle)
    local attempt_addition = 0
    if is_battle then attempt_addition = 2000 * self:get_failed_attempts() end
    local level_difference = front_average_level - enemy_average_level
    local attempt = 5000 + attempt_addition + (level_difference * 500)

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

    local total_rn_advances = self:get_rn_advances_to_flee(rn,
                                                           front_average_level,
                                                           enemy_average_level,
                                                           true)

    drawing:set_text("ACs to Run: " .. total_rn_advances, self.ui.x.pos,
                     self.ui.y.pos)
end

function flee_attempt.new(o)
    local self = o or {}
    setmetatable(self, {__index = FleeAttempt})
    self.__index = self
    return self
end

return flee_attempt
