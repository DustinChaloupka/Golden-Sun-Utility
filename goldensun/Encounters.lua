Encounters = {enabled = false}

function Encounters:check() if not Encounters.enabled then Encounters:lock() end end

function Encounters:lock() emulator:write_word(0x02000498, 0) end
