Party = {pp_lock_enabled = false}

function Party:check() if Party.pp_lock_enabled then Party:lock_pp() end end

function Party:lock_pp()
    emulator:write_word(GameSettings.Character.Felix.CurrentPP, 5)
end
