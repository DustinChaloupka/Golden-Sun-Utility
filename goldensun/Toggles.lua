Toggles = {}

Toggles.buttons = {
    debug = {
        text = "Debug",
        type = Constants.ButtonTypes.IMAGE,
        image = {path = Constants.ButtonImages.NO},
        box = {
            5, Constants.Screen.HEIGHT - Constants.Screen.DOWN_GAP + 5, 29, 29
        },
        onClick = function(self)
            local new_value =
                (emulator:read_byte(GameSettings.DebugMode.address) + 1) % 2
            if new_value == 0 then
                self.image.path = Constants.ButtonImages.NO
            else
                self.image.path = Constants.ButtonImages.YES
            end

            emulator:write_byte(GameSettings.DebugMode.address, new_value)

        end
    },
    encounters = {
        text = "Encounters",
        type = Constants.ButtonTypes.IMAGE,
        image = {path = Constants.ButtonImages.YES},
        box = {
            55, Constants.Screen.HEIGHT - Constants.Screen.DOWN_GAP + 5, 29, 29
        },
        onClick = function(self)
            Encounters.enabled = not Encounters.enabled
            if Encounters.enabled then
                self.image.path = Constants.ButtonImages.YES
            else
                self.image.path = Constants.ButtonImages.NO
            end
        end
    },
    pp_lock = {
        text = "PP Lock",
        type = Constants.ButtonTypes.IMAGE,
        image = {path = Constants.ButtonImages.NO},
        box = {
            145, Constants.Screen.HEIGHT - Constants.Screen.DOWN_GAP + 5, 29, 29
        },
        onClick = function(self)
            Party.pp_lock_enabled = not Party.pp_lock_enabled
            if Party.pp_lock_enabled then
                self.image.path = Constants.ButtonImages.YES
            else
                self.image.path = Constants.ButtonImages.NO
            end
        end
    },
    map_overlay = {
        text = "Map Overlay",
        type = Constants.ButtonTypes.IMAGE,
        image = {path = Constants.ButtonImages.NO},
        box = {
            215, Constants.Screen.HEIGHT - Constants.Screen.DOWN_GAP + 5, 29, 29
        },
        onClick = function(self)
            Map.Overlay.enabled = not Map.Overlay.enabled
            if Map.Overlay.enabled then
                self.image.path = Constants.ButtonImages.YES
            else
                self.image.path = Constants.ButtonImages.NO
            end
        end
    }
}

function Toggles:draw()
    for _, button in pairs(Toggles.buttons) do
        local x = button.box[1]
        local y = button.box[2]
        local width = button.box[3]
        local height = button.box[4]
        if Constants.ButtonTypes.IMAGE then
            gui.drawImage(button.image.path, x, y)
        elseif Constants.ButtonTypes.CHECKBOX then
            gui.drawRectangle(x, y, width, height, button.border_color,
                              button.fill_color)
        end
        gui.drawText(x + 1, y + height + 1, button.text,
                     Drawing.Text.SHADOW_COLOR)
        gui.drawText(x, y + height, button.text)
    end
end
