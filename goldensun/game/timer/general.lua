local general = {}

local General = require("goldensun.game.timer").new {
    name = "General",

    analysis = {is_enabled = false},

    color = 0xFFFFFF,

    ticks = 0,

    ui = {x = 0, y = 110}
}

function General:toggle_pause()
    self.is_paused = not self.is_paused

    if self.is_paused then
        self.color = 0xFFFF00
    else
        self.color = 0xFFFFFF
    end

    print("Timer " .. string.format(self.is_paused and "paused" or "unpaused"))
end

function General:draw()
    if not self.analysis.is_enabled and self.is_enabled then
        if not self.is_paused then self.ticks = self.ticks + 1 end

        drawing:set_text("Timer " .. math.floor(self.ticks / 60) .. "s",
                         self.ui.x, self.ui.y, self.color)
    end
end

setmetatable(general, {__index = General})

return general
