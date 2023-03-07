local dialog = forms

local Dialog = {width = 300, height = 400}
Dialog.form = dialog.newform(Dialog.width, Dialog.height, "Golden Sun Lua")
forms.setproperty(Dialog.form, "Left", client.xpos() + client.screenwidth() + 20)
forms.setproperty(Dialog.form, "Top", client.ypos())
Dialog.picture_box = dialog.pictureBox(Dialog.form, 0, 0, Dialog.width,
                                       Dialog.height)
forms.setDefaultTextBackground(Dialog.picture_box, "transparent")
forms.setDefaultBackgroundColor(Dialog.picture_box, "black")
forms.setDefaultForegroundColor(Dialog.picture_box, "black")

function Dialog:update() self.refresh(self.picture_box) end
function Dialog:reset()
    self.drawRectangle(self.picture_box, 0, 0, Dialog.width, Dialog.height)
end
function Dialog:get_hex_color(color, transparency)
    local t = 0xFF000000
    if transparency then t = transparency end
    return color + t
end
function Dialog:set_text(text, x, y, forecolor, transparency)
    self.drawText(self.picture_box, x, y, text,
                  self:get_hex_color(forecolor, transparency))
end

setmetatable(dialog, {__index = Dialog})

return dialog
