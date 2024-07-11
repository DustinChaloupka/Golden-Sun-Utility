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

require("goldensun.Constants")
require("goldensun.Drawing")

client.SetClientExtraPadding(0, 0, Constants.Screen.RIGHT_GAP,
                             Constants.Screen.DOWN_GAP)
gui.use_surface("client")
Constants.Screen.HEIGHT = client.screenheight()
Constants.Screen.WIDTH = client.screenwidth()

require("goldensun.GameSettings")
require("goldensun.Encounters")
require("goldensun.Party")
require("goldensun.Map")
require("goldensun.Toggles")
require("goldensun.Inputs")

GameSettings:initialize()

while true do
    drawing:reset()

    gui.clearGraphics("emu")
    Drawing:drawBackground()

    emulator:load_joypad(0)
    emulator:load_input()

    game:random_number_checks()
    game:check_analysis_trigger()
    game:timer_checks()
    if not game:is_in_battle() then
        if not game:is_in_menu() then
            game:encounter_checks()
            game:movement_checks()
        end

        game:map_checks()
        game:lock_zoom()
        game:fast_travel()
        game:teleport_to_cursor()
        game:specific_checks()
    else
        game:battle_checks()
    end

    Toggles:draw()
    Map:draw()
    Inputs:checkForInput()
    Party:check()
    Encounters:check()

    drawing:update()
    emulator:frameadvance()
end
