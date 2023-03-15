local encounters = {}

local Chunk = require("goldensun.memory.chunk")
local Encounters = Chunk.new {
    analysis = {
        is_enabled = false,
        ui = {x = {pos = 10, interval = 55}, y = {pos = 10, interval = 10}}
    }
}

function Encounters:disable() self.lock:write(0) end

function Encounters:maybe_disable() if self.is_disabled then self:disable() end end

function Encounters:draw(is_overworld)
    if not self.analysis.is_enabled then
        self.step_count:draw()
        self.step_rate:draw(is_overworld)
    end
end

function Encounters:draw_analysis(grn, zone, front_line_level)
    if self.analysis.is_enabled then
        local encounters = self:lookup(grn, zone, front_line_level)
        for i = 0, 3 do
            local rn = require("goldensun.memory.game.randomnumber").new {
                value = grn.value
            }
            rn:next(i)
            self.step_rate:draw_analysis(rn, i, self.analysis.ui.x.pos + i *
                                             self.analysis.ui.x.interval,
                                         self.analysis.ui.y.pos)

            rn = nil

            for j, enemy in ipairs(encounters[i + 1]) do
                drawing:set_text(enemy, self.analysis.ui.x.pos + i *
                                     self.analysis.ui.x.interval, self.analysis
                                     .ui.y.pos + self.analysis.ui.y.interval * j)
            end
        end
    end
end

function Encounters:lookup(grn, zone, front_line_level)
    local all_encounters = {}
    for i = 1, 10 do
        local rn = require("goldensun.memory.game.randomnumber").new {
            value = grn.value
        }
        if self.step_rate:read() == "" then rn:next(4) end

        rn:next(i - 1)

        -- what is this?
        local rateSum = 0
        for j = 0, 7 do
            -- where do these offset numbers come from?
            local rate = self:read_offset(28 * zone + 20 + j)
            rateSum = rateSum + rate
        end

        -- what are these doing?
        rn:next(1)
        local rnMultiplier = rn:distribution(rateSum)
        local group = 0
        for j = 0, 7 do
            local rate = self:read_offset(28 * zone + 20 + j)
            rnMultiplier = rnMultiplier - rate
            if rnMultiplier < 0 then
                group = self:read_offset_with_size(28 * zone + 4 + 2 * j, 16)
                break
            end
        end

        -- Calculates the enemy quantities
        local enemy_group =
            require("goldensun.memory.game.tla.enemy.group").new {
                group_id = group
            }

        local enemies = enemy_group:get_enemies()
        for _, enemy in pairs(enemies) do enemy:set_count(rn) end

        -- Swaps them 10 times
        for _ = 1, 10 do
            rn:next(1)
            local a = rn:distribution(5) + 1
            rn:next(1)
            local b = rn:distribution(5) + 1
            local temp = enemies[a]
            enemies[a] = enemies[b]
            enemies[b] = temp
        end

        local enemy_order = {}
        local total_enemy_level = 0
        local total_enemy_count = 0
        for _, enemy in pairs(enemies) do
            for j = 1, enemy:get_count() do
                total_enemy_count = total_enemy_count + 1
                local name = enemy:get_name()
                enemy_order[total_enemy_count] = name
                if #name < 14 or j == 1 then
                    total_enemy_level = total_enemy_level + enemy:get_level()
                end
            end
        end

        -- Calculates Attack Cancels to flee
        -- local fleeRate = 5000 + math.floor(500 * PCLV / 4) -
        --                     math.floor(500 * totalEnemyLvl / enemyCount)
        -- attackCancels = "N/A"
        -- if fleeRate > 0 then
        --    for i = 0, 99 do
        --        if grn(10000) < fleeRate then
        --            attackCancels = i
        --            break
        --        end
        --    end
        -- end
        -- return nextEncounter, attackCancels
        all_encounters[i] = enemy_order
    end

    return all_encounters
end

function Encounters:set_analysis_enabled(is_enabled)
    self.analysis.is_enabled = is_enabled
end

function Encounters:set_disabled(is_disabled)
    print("Encounters " ..
              string.format(is_disabled and "disabled" or "enabled"))
    self.is_disabled = is_disabled
end

function encounters.new(o)
    local self = o or {}
    setmetatable(self, {__index = Encounters})
    self.__index = self
    return self
end

return encounters
