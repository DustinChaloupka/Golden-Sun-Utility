Info = {}

Info.sections = {
    tile_address = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 5},
        getText = function(self)
            return string.format("Tile Address: 0x0%x", emulator:read_dword(
                                     GameSettings.Map.TileAddress))
        end
    },
    brn = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 20},
        getText = function(self)
            return "BRN: " ..
                       emulator:read_dword(GameSettings.RandomNumber.Battle)
        end
    },
    grn = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 35},
        getText = function(self)
            return "GRN: " ..
                       emulator:read_dword(GameSettings.RandomNumber.General)
        end
    },
    step_rate = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 50},
        getText = function(self)
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
            return "Step Count: " ..
                       emulator:read_word(GameSettings.Movement.StepCount)
        end
    },
    movement_tick = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 80},
        getText = function(self)
            local counter = emulator:read_word(GameSettings.Movement.Tick)
            return "Movement Tick: " .. (math.floor(counter / 0xFFF))
        end
    }
}

function Info.drawSections()
    for _, section in pairs(Info.sections) do
        local x = section.coords[1]
        local y = section.coords[2]
        local text = section.getText()

        gui.drawText(x + 1, y + 1, text, Drawing.Text.SHADOW_COLOR)
        gui.drawText(x, y, text)
    end
end
