local onscreen = gui

local OnScreen = {}

function OnScreen:update() end
function OnScreen:reset() end
function OnScreen:set_text(text, x, y) self.text(x, y, text) end

setmetatable(onscreen, {__index = OnScreen})

return onscreen
