local encounters = {}

local Encounters = {
    analysis = {is_enabled = false, ui = {x = 10, y = 10, interval = 55}}
}

function Encounters:disable() self.lock:write(0) end

function Encounters:maybe_disable() if self.is_disabled then self:disable() end end

function Encounters:draw(is_overworld)
    if not self.analysis.is_enabled then
        self.step_count:draw()
        self.step_rate:draw(is_overworld)
    end
end

function Encounters:draw_analysis(front_line_level, grn)
    if self.analysis.is_enabled then
        for i = 0, 3, 1 do
            local rn = require("goldensun.memory.game.randomnumber").new({
                value = grn.value
            })
            rn:next(i)
            self.step_rate:draw_analysis(rn, i, self.analysis.ui.x + i *
                                             self.analysis.ui.interval,
                                         self.analysis.ui.y)
            rn = nil
        end
    end
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
