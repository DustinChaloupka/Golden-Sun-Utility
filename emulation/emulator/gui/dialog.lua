local dialog = forms

local Dialog = {
    encounters = require("emulation.emulator.gui.dialog.encounters"),
    form = dialog.newform(300, 400, "Golden Sun Lua")
}
forms.setproperty(Dialog.form, "Left", client.xpos() + client.screenwidth() + 20)
forms.setproperty(Dialog.form, "Top", client.ypos())

function Dialog:draw_step_count(step_count)
    self.encounters:update_step_count(dialog, self.form, step_count)
end

setmetatable(dialog, {__index = Dialog})

return dialog
