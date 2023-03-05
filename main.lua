emulator = nil
drawing = nil

if vba then
    print("Loading VBA...")
    emulator = require("emulation.emulator.visualboyadvanced")
elseif client then
    print("Loading BizHawk...")
    emulator = require("emulation.emulator.bizhawk")
end

drawing = emulator.gui

local tbs = require("goldensun.game.tbs")
local tla = require("goldensun.game.tla")

game = nil
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
    drawing:reset()
    emulator:load_joypad(0)

    if not game:is_in_battle() then
        if not game:is_in_menu() then game:encounter_checks() end
        game:lock_zoom()
        game:fast_travel()
        game:teleport_to_cursor()
        game:specific_checks()
    end

    drawing:update()
    emulator:frameadvance()
end
