local game = nil
local emulator = nil

package.path = package.path .. ";.\\?\\init.lua"

if vba then
    print("Loading VBA...")
    emulator = require "virtualboyadvanced"
elseif client then
    print("Loading BizHawk...")
    emulator = require "bizhawk"
end

local memory = emulator.memory()
currentRom = memory.readdword(0x080000A0)
local tbsRom = 0x646C6F47
local tlaRom = 0x444C4F47

local currentRom = memory.readdword(0x080000A0)
if currentRom == tbsRom then
    print("Loading TBS...")
    game = require "tbs"
elseif currentRom == tlaRom then
    print("Loading TLA...")
    game = require "tla"
end

local townSpeed = 3
local overWorldSpeed = 3
local overRunSpeed = 4
local boatSpeed = 3
local hoverBoatSpeed = 5
local encountersIfHoldingL = false

function move(xAddr, yAddr, speed)
    local x = memory.readword(xAddr)
    local y = memory.readword(yAddr)
    if emulator.keyPressed("down") then y = y + speed end
    if emulator.keyPressed("up") then y = y - speed end
    if emulator.keyPressed("left") then x = x - speed end
    if emulator.keyPressed("right") then x = x + speed end
    memory.writeword(xAddr, x)
    memory.writeword(yAddr, y)
    camSpeed = speed
end

while true do
    emulator.loadJoypad(0)

    local memMap = {}
    if currentRom == memory.readdword(0x080000A0) then
        memMap = game.loadMem()
    end
    local battleState = bit.band(bit.rshift(memory.readbyte(0x02000060), 3), 1)

    if battleState == 0 then

        local xCamera = memory.readdword(memMap.camAddr) + 0x2
        local yCamera = memory.readdword(memMap.camAddr) + 0xA
        local mapState = bit.band(memory.readbyte(memMap.mapFlag), 1)
        local movementType = memory.readbyte(memMap.moveTypeAddr)
        local mapNumber = memory.readword(memMap.mapAddr)

        if mapNumber == 2 then memory.writebyte(memMap.zoomLock, 2) end
        if currentRom == tlaRom then
            if (mapNumber == 0xc5 or mapNumber == 0xC6 or mapNumber == 0x10C) and
                memory.readword(0x020004B6) ~= 1 then
                memory.writeword(0x020004B6, 1)
                memory.writeword(0x02030158, 0x3E7)
            end
            if movementType == 8 then
                local playerPP = 0x02000520 + 0x3A + 0x14C *
                                     memory.readbyte(0x02000458)
                if memory.readword(playerPP) < 1 then
                    memory.writeword(playerPP, 1)
                end
            end
            -- Hold L and press B when in a menu to teleport the boat to you
            if emulator.keyPressed("L") and emulator.keyPressed("B") and
                mapNumber == 2 and
                bit.band(bit.rshift(memory.readbyte(0x02000060), 6), 1) == 1 and
                memory.readword(0x020004B6) == 0 then
                memory.writeword(memMap.xBoat, memory.readword(memMap.xOver))
                memory.writeword(memMap.yBoat, memory.readword(memMap.yOver))
            end
        end

        -- Hold L to go fast
        if emulator.keyPressed("L") then
            if mapNumber == 2 then
                if movementType == 7 then
                    move(memMap.xBoat, memMap.yBoat, boatSpeed)
                elseif movementType == 8 then
                    move(memMap.xBoat, memMap.yBoat, hoverBoatSpeed)
                elseif emulator.keyPressed("B") then
                    move(memMap.xOver, memMap.yOver, overRunSpeed)
                else
                    move(memMap.xOver, memMap.yOver, overWorldSpeed)
                end
                move(xCamera, yCamera, camSpeed - 1)
            else
                if movementType == 6 then
                    move(memMap.xTownBoat, memMap.yTownBoat, townSpeed)
                else
                    move(memMap.xTown, memMap.yTown, townSpeed)
                end
            end
            if encountersIfHoldingL == false then
                memory.writeword(memMap.encounters, 0)
            end
        end

        -- Press A on world map to teleport to cursor
        if mapState == 0 then switch = false end
        if mapState == 1 and switch == false and emulator.keyPressed("A") ==
            true then
            if currentRom == tbsRom then
                x = bit.lshift(xCursor, 8) / 15 + 0x1000
                y = bit.lshift(yCursor, 8) / 10
            elseif currentRom == tlaRom and memory.readbyte(0x0202A642) == 0 then
                x = bit.lshift(xCursor + 269, 14) / 853
                y = bit.lshift(yCursor + 112, 14) / 640
            end
            if movementType == 7 or movementType == 8 then
                memory.writeword(memMap.xBoat, x)
                memory.writeword(memMap.yBoat, y)
            else
                memory.writeword(memMap.xOver, x)
                memory.writeword(memMap.yOver, y)
            end
            memory.writeword(xCamera, x)
            memory.writeword(yCamera, y)
            switch = true
        end

        xCursor = memory.readword(memMap.xMapCursor)
        yCursor = memory.readword(memMap.yMapCursor)

    end
    emulator.frameadvance()
end
