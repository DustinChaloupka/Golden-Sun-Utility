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
