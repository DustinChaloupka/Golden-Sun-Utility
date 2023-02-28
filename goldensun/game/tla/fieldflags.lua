local fieldflags = {}

local FieldFlags = {exit = require("goldensun.memory.game.tla.field.exit")}

function FieldFlags:trigger_exit() self.exit:trigger() end

setmetatable(fieldflags, {__index = FieldFlags})

return fieldflags
