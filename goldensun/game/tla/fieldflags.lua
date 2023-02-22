local fieldflags = {}

local FieldFlags = {exit = require("goldensun.memory.tla.field.exit")}

function FieldFlags:trigger_exit(game) self.exit:trigger(game) end

setmetatable(fieldflags, {__index = FieldFlags})

return fieldflags
