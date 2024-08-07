local encounters = {}

local Chunk = require("goldensun.memory.chunk")
local Encounters = Chunk.new {
    analysis = {
        is_enabled = false,
        ui = {
            x = {pos = 10, interval = 60},
            y = {pos = 10, interval = 10, row_interval = 75},
            -- Max number of enemies in an encounter group?
            last_row_interval = 6
        },
        psynergy_index = {
            "Base", "Move", "Lash", "Scoop", "Frost", "Pound", "Growth",
            "Cyclone", "Douse", "Sand", "Lift"
        },
        psynergy = {
            ["Base"] = 0,
            ["Move"] = 295,
            ["Lash"] = 144,
            ["Scoop"] = 80,
            ["Frost"] = 96,
            ["Pound"] = 248,
            ["Growth"] = 63,
            ["Cyclone"] = 480,
            ["Douse"] = 20,
            ["Sand"] = 256,
            ["Lift"] = 72
        },
        current_psynergy = "Base"
    },

    avoid = {is_enabled = false},

    recommended_level = {ui = {x = {pos = 0}, y = {pos = 150}}}
}

-- function Encounters:disable() self.lock:write(0) end

-- function Encounters:maybe_disable() if self.is_disabled then self:disable() end end

function Encounters:next_psynergy_analysis()
    if not self.analysis.is_enabled then return end
    for i, psynergy in ipairs(self.analysis.psynergy_index) do
        if psynergy == self.analysis.current_psynergy then
            local new_index = i + 1
            if new_index > 11 then new_index = 1 end
            self.analysis.current_psynergy =
                self.analysis.psynergy_index[new_index]
            return
        end
    end
end

function Encounters:previous_psynergy_analysis()
    if not self.analysis.is_enabled then return end
    for i, psynergy in ipairs(self.analysis.psynergy_index) do
        if psynergy == self.analysis.current_psynergy then
            local new_index = i - 1
            if new_index < 1 then new_index = 11 end
            self.analysis.current_psynergy =
                self.analysis.psynergy_index[new_index]
            return
        end
    end
end

function Encounters:draw(is_overworld, zone_id)
    if not self.analysis.is_enabled then
        -- self.step_count:draw()
        -- self.step_rate:draw(is_overworld)
        self:draw_recommended_level(zone_id)
    end
end

function Encounters:draw_battle(grn, front_average_level)
    -- self.battle_group:draw_battle()

    -- local average_enemy_level = self.battle_group:get_average_enemy_level()

    -- self.flee_attempt:draw_battle(grn, front_average_level, average_enemy_level)
end

function Encounters:draw_encounter_group_part(text, column_number, row_number,
                                              group_row_interval)
    drawing:set_text(text, self.analysis.ui.x.pos + column_number *
                         self.analysis.ui.x.interval,
                     self.analysis.ui.y.pos + self.analysis.ui.y.interval *
                         row_number + group_row_interval)
end

function Encounters:draw_analysis(brn, grn, zone, front_average_level)
    if self.analysis.is_enabled then
        local psynergy_advance = self:draw_psynergy_advance()
        local psynergy_grn = require("goldensun.memory.game.randomnumber").new {
            value = grn.value
        }
        psynergy_grn:next(psynergy_advance)

        -- This is kind of a hack to allow drawing the steprate still
        -- without knowing the encounters on the world map
        local encounters = {{}, {}, {}, {}, {}, {}, {}, {}}
        self.step_count:draw_analysis()

        if zone > 0 then
            encounters = self:lookup(psynergy_grn, zone, front_average_level)
        end

        for i, enemy_group in ipairs(encounters) do

            local n = i - 1
            local column_number = emulator:math_mod(n, 4)
            local row_interval = 0
            local row = 0
            if i >= 5 then
                row_interval = self.analysis.ui.y.row_interval
                row = 1
            end

            self.step_rate:draw_analysis(psynergy_grn, n, column_number, row)

            self:draw_encounter_group_part("+" .. n, column_number, 0,
                                           row_interval)

            if enemy_group.group_id then
                local enemy_interval = 0
                for _, enemy in ipairs(enemy_group:get_enemies()) do
                    local name = enemy:get_name()
                    for _ = 1, enemy:get_count() do
                        enemy_interval = enemy_interval + 1
                        self:draw_encounter_group_part(name, column_number,
                                                       enemy_interval,
                                                       row_interval)
                    end
                end

                if brn:is_attacks_first() then
                    self:draw_encounter_group_part("AF", column_number,
                                                   self.analysis.ui
                                                       .last_row_interval,
                                                   row_interval)
                elseif brn:is_caught_by_surprise() then
                    self:draw_encounter_group_part("CBS", column_number,
                                                   self.analysis.ui
                                                       .last_row_interval,
                                                   row_interval)
                else
                    self:draw_encounter_group_part(
                        enemy_group:get_rn_advances_to_flee() .. " AC",
                        column_number, self.analysis.ui.last_row_interval,
                        row_interval)
                end
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

function Encounters:lookup(grn, zone, front_average_level)
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
        enemy_group:set_rn_advances_to_flee(rn, self.flee_attempt,
                                            front_average_level)

        all_encounters[i] = enemy_group
    end

    return all_encounters
end

function Encounters:toggle_avoid_information()
    if self.analysis.is_enabled then return end
    self.avoid.is_enabled = not self.avoid.is_enabled
end

function Encounters:draw_recommended_level(zone_id)
    if self.avoid.is_enabled and not self.analysis.is_enabled then
        local recommended_level = self:read_offset_with_size(zone_id *
                                                                 self.zone_offset +
                                                                 self.recommended_level_offset,
                                                             self.recommended_level_size)
        drawing:set_text("Recommended level: " .. recommended_level,
                         self.recommended_level.ui.x.pos,
                         self.recommended_level.ui.y.pos)
    end
end

function Encounters:draw_psynergy_advance()
    drawing:set_text(self.analysis.current_psynergy, 0, 0)
    return self.analysis.psynergy[self.analysis.current_psynergy]
end

function Encounters:toggle_analysis_enabled()
    self.analysis.is_enabled = not self.analysis.is_enabled
end

-- function Encounters:toggle_disabled()
--     self.is_disabled = not self.is_disabled
--     print("Encounters " ..
--               string.format(self.is_disabled and "disabled" or "enabled"))
-- end

function encounters.new(o)
    local self = o or {}
    setmetatable(self, {__index = Encounters})
    self.__index = self
    return self
end

return encounters
