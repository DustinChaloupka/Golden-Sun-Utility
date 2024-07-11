Inputs = {}

local previousMouseInput = {}
function Inputs:checkForInput()
    local mouseInput = input.getmouse()
    if mouseInput["Left"] and not previousMouseInput["Left"] then
        local emu_mouse_x = mouseInput["X"]
        local emu_mouse_y = mouseInput["Y"]
        local client_mouse = client.transformPoint(emu_mouse_x, emu_mouse_y)
        Inputs:checkMouseInput(client_mouse["x"], client_mouse["y"])
    end
    previousMouseInput = mouseInput
end

function Inputs:checkMouseInput(mouse_x, mouse_y)
    Inputs:checkButtonsClicked(mouse_x, mouse_y, Toggles.buttons)

    if Map.Overlay.enabled then
        Inputs:checkButtonsClicked(mouse_x, mouse_y, Map.buttons)
    end
end

function isInArea(mouse_x, mouse_y, x, y, width, height)
    return (mouse_x >= x and mouse_x <= x + width) and
               (mouse_y >= y and mouse_y <= y + height)
end

function Inputs:checkButtonsClicked(mouse_x, mouse_y, buttons)
    for _, button in pairs(buttons) do
        if isInArea(mouse_x, mouse_y, button.box[1], button.box[2],
                    button.box[3], button.box[4]) then button:onClick() end
    end
end
