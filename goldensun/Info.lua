Info = {}

Info.sections = {
    tile_address = {
        coords = {Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5, 5},
        getInfo = function(self)
            return string.format("Tile Address: 0x%x", emulator:read_dword(
                                     GameSettings.Map.TileAddress))
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
