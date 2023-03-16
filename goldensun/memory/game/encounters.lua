local encounters = {}

local Chunk = require("goldensun.memory.chunk")
local Encounters = Chunk.new {
    analysis = {
        is_enabled = false,
        ui = {
            x = {pos = 10, interval = 55},
            y = {pos = 10, interval = 10, row_interval = 75},
            -- Max number of enemies in an encounter group?
            last_row_interval = 6
        }
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
        -- This is kind of a hack to allow drawing the steprate still
        -- without knowing the encounters on the world map
        local encounters = {{}, {}, {}, {}, {}, {}, {}, {}}
        self.step_count:draw_analysis()

        if zone > 0 then
            encounters = self:lookup(grn, zone, front_line_level)
        end

        for i, enemy_group in ipairs(encounters) do
            local rn = require("goldensun.memory.game.randomnumber").new {
                value = grn.value
            }

            local n = i - 1
            local column_number = math.mod(n, 4)
            local row_interval = 0
            if i >= 5 then
                row_interval = self.analysis.ui.y.row_interval
            end

            rn:next(n)
            self.step_rate:draw_analysis(rn, n, self.analysis.ui.x.pos +
                                             column_number *
                                             self.analysis.ui.x.interval,
                                         self.analysis.ui.y.pos + row_interval)

            rn = nil

            if enemy_group.group_id then
                local enemy_interval = 0
                for _, enemy in ipairs(enemy_group:get_enemies()) do
                    local name = enemy:get_name()
                    for _ = 1, enemy:get_count() do
                        enemy_interval = enemy_interval + 1
                        drawing:set_text(name, self.analysis.ui.x.pos +
                                             column_number *
                                             self.analysis.ui.x.interval,
                                         self.analysis.ui.y.pos +
                                             self.analysis.ui.y.interval *
                                             enemy_interval + row_interval)
                    end
                end

                drawing:set_text(enemy_group:get_rn_advances_to_flee() .. " AC",
                                 self.analysis.ui.x.pos + column_number *
                                     self.analysis.ui.x.interval,
                                 self.analysis.ui.y.pos +
                                     self.analysis.ui.y.interval *
                                     self.analysis.ui.last_row_interval +
                                     row_interval)
            end
        end
    end
end

-- Is this accurate?
function Encounters:get_current_rate_distribution(zone)
    local distribution = 0
    for i = 0, 7 do
        -- what do these offset values mean?
        local rate = self:read_offset(28 * zone + 20 + i)
        distribution = distribution + rate
    end

    return distribution
end

function Encounters:get_group_id(rn, zone, distribution)
    rn:next(1)
    local group_rng = rn:distribution(distribution)
    for i = 0, 7 do
        -- where do these offset values mean?
        local rate = self:read_offset(28 * zone + 20 + i)
        group_rng = group_rng - rate
        if group_rng < 0 then
            return self:read_offset_with_size(28 * zone + 4 + 2 * i, 16)
        end
    end
end

function Encounters:lookup(grn, zone, front_line_level)
    local all_encounters = {}
    for i = 1, 8 do
        local rn = require("goldensun.memory.game.randomnumber").new {
            value = grn.value
        }
        if self.step_rate:read() == "" then rn:next(4) end

        rn:next(i - 1)

        local rate_distribution = self:get_current_rate_distribution(zone)
        local group_id = self:get_group_id(rn, zone, rate_distribution)
        local enemy_group =
            require("goldensun.memory.game.tla.enemy.group").new {
                group_id = group_id
            }

        enemy_group:set_enemy_counts(rn)
        enemy_group:shuffle(rn)
        enemy_group:set_rn_advances_to_flee(rn, front_line_level)

        all_encounters[i] = enemy_group
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
