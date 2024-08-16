Camera = {}

Camera.Coordinates = {Address = 0x03001300, X = 0x0, Y = 0x0}

function Camera.update()
    Camera.Coordinates.Address =
        emulator:read_dword(GameSettings.Camera.Address)

    Camera.update_current_coordinates()
    if Movement.FastTravel and emulator:button_pressed("L") then
        Camera.speed_up()
    end
end

function Camera.update_current_coordinates()
    local x_addr = Camera.Coordinates.Address + GameSettings.Camera.XOffset
    Camera.Coordinates.X = emulator:read_dword(x_addr)

    local y_addr = Camera.Coordinates.Address + GameSettings.Camera.YOffset
    Camera.Coordinates.Y = emulator:read_dword(y_addr)
end

function Camera.speed_up()
    Camera.Coordinates.X = Camera.Coordinates.X + Movement.Speed.X
    Camera.Coordinates.Y = Camera.Coordinates.Y + Movement.Speed.Y

    emulator:write_dword(Camera.Coordinates.Address +
                             GameSettings.Camera.XOffset, Camera.Coordinates.X)
    emulator:write_dword(Camera.Coordinates.Address +
                             GameSettings.Camera.YOffset, Camera.Coordinates.Y)
end
