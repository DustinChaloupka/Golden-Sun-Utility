local game
emulator = nil

local addresses = require("goldensun.addresses")
local settings = require("config.settings")

if vba then
    print("Loading VBA...")
    emulator = require("emulation.virtualboyadvanced")
elseif client then
    print("Loading BizHawk...")
    emulator = require("emulation.bizhawk")
end

currentRom = memory.readdword(addresses.rom)
local tbs = require("goldensun.tbs")
local tla = require("goldensun.tla")

local currentRom = memory.readdword(addresses.rom)
if currentRom == tbs.rom then
    print("Loading TBS...")
    game = tbs
elseif currentRom == tla.rom then
    print("Loading TLA...")
    game = tla
end

function move(xAddr, yAddr, speed)
    local x = memory.readword(xAddr)
    local y = memory.readword(yAddr)
    if emulator:key_pressed("down") then y = y + speed end
    if emulator:key_pressed("up") then y = y - speed end
    if emulator:key_pressed("left") then x = x - speed end
    if emulator:key_pressed("right") then x = x + speed end
    memory.writeword(xAddr, x)
    memory.writeword(yAddr, y)
    camSpeed = speed
end

while true do
    emulator:load_joypad(0)

    local movementAddresses = {}
    if currentRom == memory.readdword(addresses.rom) then
        movementAddresses = game.movementAddresses
    end

    if not addresses.is_battle() then

        local xCamera = memory.readdword(movementAddresses.camAddr) + 0x2
        local yCamera = memory.readdword(movementAddresses.camAddr) + 0xA
        local mapState = bit.band(memory.readbyte(movementAddresses.mapFlag), 1)
        local movementType = memory.readbyte(movementAddresses.moveTypeAddr)
        local mapNumber = memory.readword(game.mapAddress)

        game:maybe_lock_zoom(mapNumber)
        game:maybe_teleport_boat(mapNumber)

        -- Hold L to go fast
        if emulator:key_pressed("L") then
            if mapNumber == 2 then
                if movementType == 7 then
                    move(movementAddresses.xBoat, movementAddresses.yBoat,
                         settings.boatSpeed)
                elseif movementType == 8 then
                    move(movementAddresses.xBoat, movementAddresses.yBoat,
                         settings.hoverBoatSpeed)
                elseif emulator:key_pressed("B") then
                    move(movementAddresses.xOver, movementAddresses.yOver,
                         settings.overRunSpeed)
                else
                    move(movementAddresses.xOver, movementAddresses.yOver,
                         settings.overWorldSpeed)
                end
                move(xCamera, yCamera, camSpeed - 1)
            else
                if movementType == 6 then
                    move(movementAddresses.xTownBoat,
                         movementAddresses.yTownBoat, settings.townSpeed)
                else
                    move(movementAddresses.xTown, movementAddresses.yTown,
                         settings.townSpeed)
                end
            end
            if settings.encountersIfHoldingL == false then
                memory.writeword(movementAddresses.encounters, 0)
            end
        end

        -- Press A on world map to teleport to cursor
        if mapState == 0 then switch = false end
        if mapState == 1 and switch == false and emulator:key_pressed("A") ==
            true then
            if currentRom == tbs.rom then
                x = bit.lshift(xCursor, 8) / 15 + 0x1000
                y = bit.lshift(yCursor, 8) / 10
            elseif currentRom == tla.rom and memory.readbyte(0x0202A642) == 0 then
                x = bit.lshift(xCursor + 269, 14) / 853
                y = bit.lshift(yCursor + 112, 14) / 640
            end
            if movementType == 7 or movementType == 8 then
                memory.writeword(movementAddresses.xBoat, x)
                memory.writeword(movementAddresses.yBoat, y)
            else
                memory.writeword(movementAddresses.xOver, x)
                memory.writeword(movementAddresses.yOver, y)
            end
            memory.writeword(xCamera, x)
            memory.writeword(yCamera, y)
            switch = true
        end

        xCursor = memory.readword(movementAddresses.xMapCursor)
        yCursor = memory.readword(movementAddresses.yMapCursor)

    end
    emulator:frameadvance()
end
