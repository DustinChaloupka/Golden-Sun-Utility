local dialog = forms

local settings = require("config.settings")
local Dialog = {width = settings.dialog.width, height = settings.dialog.height}
Dialog.form = dialog.newform(Dialog.width, Dialog.height, "Golden Sun Lua")
forms.setproperty(Dialog.form, "Left", client.xpos() + client.screenwidth() + 20)
forms.setproperty(Dialog.form, "Top", client.ypos())
Dialog.picture_box = dialog.pictureBox(Dialog.form, 0, 0, Dialog.width,
                                       Dialog.height)
forms.setDefaultTextBackground(Dialog.picture_box, "transparent")
forms.setDefaultBackgroundColor(Dialog.picture_box, "black")
forms.setDefaultForegroundColor(Dialog.picture_box, "black")

-- This is based off the values used for the GBA resolution
-- of 240x160, but assuming the dialog box is a square
function Dialog:scaled_position(x, y)
    return x / 240 * self.width, y / 240 * self.height
end

function Dialog:update() self.refresh(self.picture_box) end
function Dialog:reset()
    self.drawRectangle(self.picture_box, 0, 0, Dialog.width, Dialog.height)
end
function Dialog:get_hex_color(color, transparency)
    local t = 0xFF000000
    local c = 0xFFFFFF
    if color then c = color end
    if transparency then t = transparency end
    return c + t
end
function Dialog:set_text(text, x, y, forecolor, transparency)
    local scaled_x, scaled_y = self:scaled_position(x, y)
    self.drawText(self.picture_box, scaled_x, scaled_y, text,
                  self:get_hex_color(forecolor, transparency), nil,
                  settings.dialog.font.size)
end

setmetatable(dialog, {__index = Dialog})

return dialog
