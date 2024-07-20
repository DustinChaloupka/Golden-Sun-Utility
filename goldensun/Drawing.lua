Drawing = {}

Drawing.Background = {FILL_COLOR = 0xFF086c8c}

Drawing.Text = {SHADOW_COLOR = 0xFF000000}

function Drawing:drawBackground()
    gui.drawRectangle(1,
                      Constants.Screen.HEIGHT - Constants.Screen.DOWN_GAP + 1,
                      Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP - 1,
                      Constants.Screen.DOWN_GAP - 1,
                      Drawing.Background.FILL_COLOR,
                      Drawing.Background.FILL_COLOR)

    gui.drawRectangle(Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 1,
                      1, Constants.Screen.RIGHT_GAP - 1,
                      Constants.Screen.HEIGHT - Constants.Screen.DOWN_GAP - 1,
                      Drawing.Background.FILL_COLOR,
                      Drawing.Background.FILL_COLOR)
end

function Drawing.drawButtons(buttons)
    for _, button in pairs(buttons) do
        local x = button.box[1]
        local y = button.box[2]
        local width = button.box[3]
        local height = button.box[4]
        if button.type == Constants.ButtonTypes.IMAGE then
            gui.drawImage(button.image.path, x, y)
        elseif button.type == Constants.ButtonTypes.CHECKBOX then
            gui.drawRectangle(x, y, width, height, button.border_color,
                              button.fill_color)
        elseif button.type == Constants.ButtonTypes.BORDERED then
            gui.drawRectangle(x, y, width, height, button.border_color)
        end
        gui.drawText(x + 1, y + height + 1, button.text,
                     Drawing.Text.SHADOW_COLOR)
        gui.drawText(x, y + height, button.text)
    end
end
