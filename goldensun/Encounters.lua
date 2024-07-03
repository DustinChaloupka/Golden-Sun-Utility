Encounters = {enabled = false}

function Encounters:check() if not Encounters.enabled then Encounters:lock() end end

function Encounters:lock()
    emulator:write_word(GameSettings.Encounters.StepCounter.address, 0)
end
