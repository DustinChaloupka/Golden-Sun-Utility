local battle = {}

local Battle = require("goldensun.game.timer").new {
    name = "Battle",

    analysis = {is_enabled = false},

    color = 0x00FF00,
    frame_counter = 0,

    last_fight = 0,

    ticks = 0,

    ui = {x = 0, y = 100}
}

function Battle:draw()
    if not self.analysis.is_enabled and self.is_enabled then
        if self.ticks > 0 then
            self.frame_counter = 360
            self.last_fight = self.ticks
            self.ticks = 0
        end

        if self.frame_counter > 0 then
            drawing:set_text(
                "Last battle " .. math.floor(self.last_fight / 6) / 10 .. "s (" ..
                    self.last_fight .. " frames)", self.ui.x, self.ui.y,
                self.color)

            self.frame_counter = self.frame_counter - 1
        end
    end
end

function Battle:draw_battle()
    if self.is_enabled then
        self.ticks = self.ticks + 1
        drawing:set_text("Battle timer " .. math.floor(self.ticks / 60) .. "s",
                         self.ui.x, self.ui.y)
    end
end

setmetatable(battle, {__index = Battle})

return battle
