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
    for _, button in pairs(buttons) do Drawing.drawButton(button) end
end

function Drawing.drawButton(button)
    if button.isVisible ~= nil and not button.isVisible() then return end

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
        gui.drawRectangle(x + 1, y + 1, width, height, Drawing.Text.SHADOW_COLOR)
        gui.drawRectangle(x, y, width, height, button.border_color)
    end
    gui.drawText(x + 3, y + 3, button.getText(), Drawing.Text.SHADOW_COLOR)
    gui.drawText(x + 2, y + 2, button.getText())
end

function Drawing.drawText(info)
    local x = info.coords[1]
    local y = info.coords[2]
    local text = info.getText()

    gui.drawText(x + 1, y + 1, text, Drawing.Text.SHADOW_COLOR)
    gui.drawText(x, y, text)
end
