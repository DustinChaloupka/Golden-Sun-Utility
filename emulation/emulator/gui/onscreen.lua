local onscreen = gui

local OnScreen = {}

function OnScreen:update() end
function OnScreen:reset() end
function OnScreen:get_hex_color(color, transparency)
    local t = 0xFF
    local c = 0xFFFFFF
    if color then c = color end
    if transparency then t = transparency end
    return emulator:lshift(c, 8) + t
end
function OnScreen:set_text(text, x, y, forecolor, transparency)
    self.text(x, y, text, self:get_hex_color(forecolor, transparency))
end

setmetatable(onscreen, {__index = OnScreen})

return onscreen
