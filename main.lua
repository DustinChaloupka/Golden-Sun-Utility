local emulator = nil

if vba then
    print("Loading VBA...")
    emulator = require("emulation.virtualboyadvanced")
elseif client then
    print("Loading BizHawk...")
    emulator = require("emulation.bizhawk")
end

local tbs = require("goldensun.game.tbs")
local tla = require("goldensun.game.tla")
tbs.emulator = emulator
tla.emulator = emulator

local game
if tbs.is_current_rom(tbs) then
    print("Loading TBS...")
    game = tbs
    tla = nil
elseif tla.is_current_rom(tla) then
    print("Loading TLA...")
    game = tla
    tbs = nil
end

while true do
    game.emulator:load_joypad(0)

    if not game:is_in_battle() then
        game:lock_zoom()
        game:fast_travel()
        game:teleport_to_cursor()
        game:specific_checks()
    end

    game.emulator:frameadvance()
end
