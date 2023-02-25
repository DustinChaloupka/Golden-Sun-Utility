local encounters = {}

local Encounters = {}

function Encounters:create_control(dialog, form)
    self.control = dialog.textbox(form)
end

function Encounters:update_step_count(dialog, form, step_count)
    if not self.control then self:create_control(dialog, form) end

    dialog.settext(self.control, "Encounter: " .. step_count)
end

setmetatable(encounters, {__index = Encounters})

return encounters

