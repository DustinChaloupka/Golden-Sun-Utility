local emulator = nil

if vba then
    print("Loading VBA...")
    emulator = require("emulation.virtualboyadvanced")
elseif client then
    print("Loading BizHawk...")
    emulator = require("emulation.bizhawk")
end

local game = require("goldensun.game")
local tbs = require("goldensun.tbs")
local tla = require("goldensun.tla")

local currentRom = emulator:current_rom(game.rom)
if currentRom == tbs.rom then
    print("Loading TBS...")
    game = tbs
    tla = nil
elseif currentRom == tla.rom then
    print("Loading TLA...")
    game = tla
    tbs = nil
end

game.emulator = emulator
while true do
    game.emulator:load_joypad(0)

    if not game:is_battle() then
        game:lock_zoom()
        game:ship_checks()
        game:teleport_ship()
        game:fast_travel()
        game:teleport_to_cursor()
    end

    game.emulator:frameadvance()
end
