local dialog = forms

local Dialog = {width = 300, height = 400}
Dialog.form = dialog.newform(Dialog.width, Dialog.height, "Golden Sun Lua")
forms.setproperty(Dialog.form, "Left", client.xpos() + client.screenwidth() + 20)
forms.setproperty(Dialog.form, "Top", client.ypos())
Dialog.picture_box = dialog.pictureBox(Dialog.form, 0, 0, Dialog.width,
                                       Dialog.height)
forms.setDefaultTextBackground(Dialog.picture_box, 0)

function Dialog:update() self.refresh(self.picture_box) end
function Dialog:reset() self.clear(self.picture_box, 0) end
function Dialog:set_text(text, x, y) self.drawText(self.picture_box, x, y, text) end

setmetatable(dialog, {__index = Dialog})

return dialog
