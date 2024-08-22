emulator = require("emulation.emulator.bizhawk")

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
require("goldensun.Movement")
require("goldensun.Camera")
require("goldensun.Enemies")
require("goldensun.Flee")
require("goldensun.Map")
require("goldensun.Info")
require("goldensun.State")
require("goldensun.Toggles")
require("goldensun.Inputs")
require("goldensun.RandomNumber")
require("goldensun.Battle")

GameSettings.initialize()
Map.initialize()

while true do
    State.update()
    Info.update()
    Battle.update()
    RandomNumber.update()
    Map.update()
    Flee.update()
    Party.update()
    Movement.update()
    Camera.update()
    Encounters.update()
    Enemies.update()

    gui.clearGraphics("emu")
    Drawing:drawBackground()

    emulator:load_joypad(0)
    emulator:load_input()

    Toggles:draw()
    Map:draw()
    Movement.draw()
    Flee.draw()
    Encounters.draw()
    Info.drawSections()

    if State.in_battle() then Battle.draw() end
    Inputs:checkForInput()
    Encounters.check()

    emulator:frameadvance()
end
