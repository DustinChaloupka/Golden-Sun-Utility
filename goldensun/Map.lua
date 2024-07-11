Map = {}

Map.Overlay = {
    enabled = false,

    x = 112,
    y = 85,
    tile_width = 25,
    tile_height = 15,

    line_color = 0xFFFFFFFF
}

function Map.initialize() end
function Map.draw() if Map.Overlay.enabled then draw_overlay() end end

function get_current_tile_address()
    return emulator:read_dword(GameSettings.Map.TileAddress)
end

function draw_overlay()
    gui.use_surface("emu")
    for x = -4, 4 do
        for y = -5, 4 do
            tile_address = get_current_tile_address() + x *
                               GameSettings.Map.TileXOffset + y *
                               GameSettings.Map.TileYOffset
            tile = emulator:read_dword(tile_address)
            event = emulator:rshift(tile, 16) & 0xFF
            gui.drawRectangle(Map.Overlay.x + (x * Map.Overlay.tile_width),
                              Map.Overlay.y + (y * Map.Overlay.tile_height),
                              Map.Overlay.tile_width, Map.Overlay.tile_height,
                              Map.Overlay.line_color)
            gui.drawText(Map.Overlay.x + 3 + (x * Map.Overlay.tile_width),
                         Map.Overlay.y + (y * Map.Overlay.tile_height),
                         string.format("%x", event))
        end
    end
    gui.use_surface("client")
end
