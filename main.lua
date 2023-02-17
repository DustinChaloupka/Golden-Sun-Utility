local game
emulator = nil

local addresses = require("goldensun.addresses")

if vba then
    print("Loading VBA...")
    emulator = require("emulation.virtualboyadvanced")
elseif client then
    print("Loading BizHawk...")
    emulator = require("emulation.bizhawk")
end

local tbs = require("goldensun.tbs")
local tla = require("goldensun.tla")

local currentRom = memory.readdword(addresses.rom)
if currentRom == tbs.rom then
    print("Loading TBS...")
    game = tbs
    tla = nil
elseif currentRom == tla.rom then
    print("Loading TLA...")
    game = tla
    tbs = nil
end

while true do
    emulator:load_joypad(0)

    if not addresses.is_battle() then
        game:lock_zoom()
        game:teleport_boat()
        game:fast_travel()
        game:teleport_to_cursor()
    end

    emulator:frameadvance()
end
