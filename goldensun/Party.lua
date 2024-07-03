Party = {pp_lock_enabled = false}

function Party:check() if Party.pp_lock_enabled then Party:lock_pp() end end

function Party:lock_pp() emulator:write_word(0x02000520 + 4 * 0x14C + 0x3A, 5) end
