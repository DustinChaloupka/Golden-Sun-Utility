Info = {}

Info.sections = {
    tile_address = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 5},
        getText = function(self)
            if State.in_battle() then return "" end
            return string.format("Tile Address: 0x0%x", emulator:read_dword(
                                     GameSettings.Map.TileAddress))
        end
    },
    brn = {
        checkInput = function(self, keyInput)
            local new_value
            if keyInput["R"] then
                new_value = RandomNumber.next(self.value, math.random(1, 100))
            end

            if keyInput["B"] then
                new_value = RandomNumber.next(self.value, 1)
            end

            if keyInput["N"] then
                new_value = RandomNumber.previous(self.value)
            end

            if new_value ~= nil and self.value ~= new_value then
                self.value = new_value
                emulator:write_dword(GameSettings.RandomNumber.Battle, new_value)
            end
        end,
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 20},
        getText = function(self) return "BRN: " .. self.value end,
        value = nil,
        onFrameAdvance = function(self)
            self.value = emulator:read_dword(GameSettings.RandomNumber.Battle)
        end
    },
    grn = {
        checkInput = function(self, keyInput)
            local new_value
            if keyInput["R"] then
                new_value = RandomNumber.next(self.value, math.random(1, 100))
            end

            if keyInput["G"] then
                new_value = RandomNumber.next(self.value, 1)
            end

            if keyInput["H"] then
                new_value = RandomNumber.previous(self.value)
            end

            if new_value ~= nil and self.value ~= new_value then
                self.value = new_value
                emulator:write_dword(GameSettings.RandomNumber.General,
                                     new_value)
            end
        end,
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 35},
        getText = function(self) return "GRN: " .. self.value end,
        value = nil,
        onFrameAdvance = function(self)
            self.value = emulator:read_dword(GameSettings.RandomNumber.General)
        end
    },
    step_rate = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 50},
        getText = function(self)
            if State.in_battle() then return "" end

            local rate = emulator:read_dword(GameSettings.Movement.StepRate)
            if rate == 0 then return "" end

            -- Unsure how all of these were calculated
            if rate >= 0xFFFF0000 then rate = rate - 0xFFFFFFFF end
            return "Step Rate: " .. math.floor((0xFFFF - rate) / 0xFF0)
        end
    },
    step_count = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 65},
        getText = function(self)
            if State.in_battle() then return "" end
            return "Step Count: " ..
                       emulator:read_word(GameSettings.Movement.StepCount)
        end
    },
    movement_tick = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 80},
        getText = function(self)
            if State.in_battle() then return "" end
            local counter = emulator:read_word(GameSettings.Movement.Tick)
            return "Movement Tick: " .. (math.floor(counter / 0xFFF))
        end
    },
    player_agilities = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 200},
        getText = function(self)
            if not State.in_battle() then return "" end

            local turn_agility = {}
            for battle_slot = 0, 19 do
                local id = emulator:read_word(
                               GameSettings.Battle.RAM + battle_slot *
                                   GameSettings.Battle.Slot.Offset)

                if id <= 7 then
                    turn_agility[id] = emulator:read_word(GameSettings.Battle
                                                              .RAM + battle_slot *
                                                              GameSettings.Battle
                                                                  .Slot.Offset +
                                                              GameSettings.Battle
                                                                  .Slot
                                                                  .AgilityOffset)
                end
            end

            local text = "Player Agilities:\n"
            for slot = 0, 3 do
                local id = emulator:read_word(
                               GameSettings.Battle.ActiveParty + slot * 0x2)

                local name = GameSettings.Characters[id]
                local current_agility = emulator:read_word(
                                            GameSettings.Character[name]
                                                .CurrentAgility)
                local max_agility = current_agility + current_agility *
                                        GameSettings.RandomModifiers.Agility

                local turn = turn_agility[id] or "N/A"

                text =
                    text .. name .. ": " .. turn .. " (" .. current_agility ..
                        "-" .. math.floor(max_agility) .. ")\n"
            end

            return text
        end
    }
}

function Info.drawSections()
    for _, section in pairs(Info.sections) do
        local x = section.coords[1]
        local y = section.coords[2]
        local text = section:getText()

        gui.drawText(x + 1, y + 1, text, Drawing.Text.SHADOW_COLOR)
        gui.drawText(x, y, text)

        if section.buttons ~= nil then
            Drawing.drawButtons(section.buttons)
        end
    end
end

function Info.onFrameAdvance()
    for _, section in pairs(Info.sections) do
        if section.onFrameAdvance ~= nil then section:onFrameAdvance() end
    end
end

function Info.checkKeyInputs(keyInput)
    for _, section in pairs(Info.sections) do
        if section.checkInput ~= nil then section:checkInput(keyInput) end
    end
end
