local onscreen = gui

local OnScreen = {}

function OnScreen:draw_step_count(step_count)
    self.text(0, 20, "Encounter: " .. step_count)
end

setmetatable(onscreen, {__index = OnScreen})

return onscreen
