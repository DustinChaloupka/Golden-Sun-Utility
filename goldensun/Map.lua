Map = {}

Map.Coordinates = {}

Map.Movement = {}

Map.Tileset = {}

Map.Tile = {}

Map.Overlay = {
    enabled = false,

    text_size = 9,

    x = 112,
    y = 87,
    tile_width = 15,
    tile_height = 15,

    line_color = 0xFFFFFFFF,
    current_tile_color = 0xFF00FF00
}

Map.buttons = {
    layer1 = {
        text = "Layer 1",
        type = Constants.ButtonTypes.BORDERED,
        border_color = 0xFFFFFFFF,
        fill_color = nil,
        on_border_color = 0xFF000000,
        off_border_color = 0xFFFFFFFF,
        box = {
            Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5,
            Constants.Screen.HEIGHT - Constants.Screen.DOWN_GAP - 20, 55, 15
        },
        preDraw = function(self)
            if Map.Overlay.layer_offset == GameSettings.Layer.Offset[1] then
                self.border_color = self.on_border_color
            else
                self.border_color = self.off_border_color
            end
        end,
        onClick = function(self)
            if Map.Overlay.layer_offset == GameSettings.Layer.Offset[1] then
                Map.Overlay.layer_offset = nil
            else
                Map.Overlay.layer_offset = GameSettings.Layer.Offset[1]
            end
        end
    },
    layer2 = {
        text = "Layer 2",
        type = Constants.ButtonTypes.BORDERED,
        border_color = 0xFFFFFFFF,
        fill_color = nil,
        on_border_color = 0xFF000000,
        off_border_color = 0xFFFFFFFF,
        box = {
            Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5 + 60,
            Constants.Screen.HEIGHT - Constants.Screen.DOWN_GAP - 20, 55, 15
        },
        preDraw = function(self)
            if Map.Overlay.layer_offset == GameSettings.Layer.Offset[2] then
                self.border_color = self.on_border_color
            else
                self.border_color = self.off_border_color
            end
        end,
        onClick = function(self)
            if Map.Overlay.layer_offset == GameSettings.Layer.Offset[2] then
                Map.Overlay.layer_offset = nil
            else
                Map.Overlay.layer_offset = GameSettings.Layer.Offset[2]
            end
        end
    },
    layer3 = {
        text = "Layer 3",
        type = Constants.ButtonTypes.BORDERED,
        border_color = 0xFFFFFFFF,
        fill_color = nil,
        on_border_color = 0xFF000000,
        off_border_color = 0xFFFFFFFF,
        box = {
            Constants.Screen.WIDTH - Constants.Screen.RIGHT_GAP + 5 + 120,
            Constants.Screen.HEIGHT - Constants.Screen.DOWN_GAP - 20, 55, 15
        },
        preDraw = function(self)
            if Map.Overlay.layer_offset == GameSettings.Layer.Offset[3] then
                self.border_color = self.on_border_color
            else
                self.border_color = self.off_border_color
            end
        end,
        onClick = function(self)
            if Map.Overlay.layer_offset == GameSettings.Layer.Offset[3] then
                Map.Overlay.layer_offset = nil
            else
                Map.Overlay.layer_offset = GameSettings.Layer.Offset[3]
            end
        end
    }
}

function Map.initialize()
    event.on_bus_exec(
        function() Map.Tileset.Terrain = emu.getregister("R0") end,
        GameSettings.Map.BattleBackgroundFunction)
end

function Map.update()
    if State.in_battle() or State.in_transition() or State.in_menu() then
        return
    end

    Map.Tile.CurrentTileAddress = emulator:read_dword(GameSettings.Map
                                                          .TileAddress)

    Map.Movement.Type = emulator:read_byte(GameSettings.Movement.Type)
    Map.update_current_coordinates()
    if Map.Tile.CurrentTileAddress == Map.Tile.PreviousTileAddress then
        return
    end

    Map.Tile.PreviousTileAddress = Map.Tile.CurrentTileAddress
    Map.update_current_area()
end

function Map.draw()
    if Map.Overlay.enabled and not State.in_transition() and
        not State.in_battle() and not State.in_menu() and
        Map.Tile.CurrentTileAddress ~= 0x0 then
        draw_overlay()
        draw_options()
    end
end

function Map.update_current_coordinates()
    if Map.Movement.Type == GameSettings.Movement.Normal then
        Map.Coordinates.X = emulator:read_dword(GameSettings.Map.NormalX)
        Map.Coordinates.Y = emulator:read_dword(GameSettings.Map.NormalY)
    elseif Map.Movement.Type == GameSettings.Movement.Overworld then
        Map.Coordinates.X = emulator:read_dword(GameSettings.Map.OverworldX)
        Map.Coordinates.Y = emulator:read_dword(GameSettings.Map.OverworldY)
    elseif Map.Movement.Type == GameSettings.Movement.ShipNormal then
        Map.Coordinates.X = emulator:read_dword(GameSettings.Map.NormalShipX)
        Map.Coordinates.Y = emulator:read_dword(GameSettings.Map.NormalShipY)
    elseif Map.Movement.Type == GameSettings.Movement.ShipOverworld then
        Map.Coordinates.X = emulator:read_dword(GameSettings.Map.OverworldShipX)
        Map.Coordinates.Y = emulator:read_dword(GameSettings.Map.OverworldShipY)
    end
end

function Map.update_current_area()
    Map.Tileset.Area = emulator:read_byte(Map.Tile.CurrentTileAddress + 3)
end

function Map.get_encounter_index()
    local zone = 0
    if emulator:read_byte(GameSettings.Map.Type) == 2 then
        zone = emulator:read_byte(GameSettings.Map.Zone)
        if zone == 0 then
            zone = emulator:read_byte(GameSettings.Map.Zone + 1)
        end
    else
        zone = get_overworld_zone()
    end
    return zone
end

function draw_overlay()
    local tile_y_offset = GameSettings.Map.TileYOffset
    if State.on_overworld() then
        tile_y_offset = GameSettings.Map.TileOverworldYOffset
    end

    gui.use_surface("emu")
    for x = -7, 7 do
        for y = -5, 4 do
            layer_offset = 0
            if Map.Overlay.layer_offset ~= nil then
                layer_pointer = emulator:read_dword(GameSettings.Map
                                                        .LayerAddress)
                layer1_offset = emulator:read_dword(layer_pointer +
                                                        GameSettings.Layer
                                                            .Offset[1])
                set_layer_offset = emulator:read_dword(layer_pointer +
                                                           Map.Overlay
                                                               .layer_offset)
                layer_offset = set_layer_offset - layer1_offset
            end

            local tile_pointer = emulator:read_dword(GameSettings.Map
                                                         .TileAddress)
            local tile_address = tile_pointer + layer_offset + x *
                                     GameSettings.Map.TileXOffset + y *
                                     tile_y_offset
            local tile = emulator:read_dword(tile_address)
            local event = emulator:rshift(tile, 16) & 0xFF
            gui.drawRectangle(Map.Overlay.x + (x * Map.Overlay.tile_width),
                              Map.Overlay.y + (y * Map.Overlay.tile_height),
                              Map.Overlay.tile_width, Map.Overlay.tile_height,
                              Map.Overlay.line_color)
            gui.drawText(Map.Overlay.x + 1 + 1 + (x * Map.Overlay.tile_width),
                         Map.Overlay.y + 1 + 1 + (y * Map.Overlay.tile_height),
                         string.format("%x", event), Drawing.Text.SHADOW_COLOR,
                         nil, Map.Overlay.text_size)

            local current_tile_color
            if x == 0 and y == 0 then
                current_tile_color = Map.Overlay.current_tile_color
            end
            gui.drawText(Map.Overlay.x + 1 + (x * Map.Overlay.tile_width),
                         Map.Overlay.y + 1 + (y * Map.Overlay.tile_height),
                         string.format("%x", event), current_tile_color, nil,
                         Map.Overlay.text_size)
        end
    end
    gui.use_surface("client")
end

function draw_options()
    for _, button in pairs(Map.buttons) do
        if button.preDraw ~= nil then button:preDraw() end

        gui.drawRectangle(button.box[1], button.box[2], button.box[3],
                          button.box[4], button.border_color)
        gui.drawText(button.box[1] + 1, button.box[2] + 1, button.text,
                     Drawing.Text.SHADOW_COLOR)
        gui.drawText(button.box[1], button.box[2], button.text)
    end
end

function get_overworld_zone()
    local encounter_data
    if Map.Movement.Type == GameSettings.Movement.Overworld then
        encounter_data = GameSettings.Encounters.OverworldData
    elseif Map.Movement.Type == GameSettings.Movement.ShipOverworld then
        encounter_data = GameSettings.Encounters.OverworldShipData
    else
        return 0
    end

    for _, encounter in pairs(encounter_data) do
        if type(encounter) == "table" then
            local area_match = encounter.AreaType ==
                                   (emulator:band(Map.Tileset.Area, 0x3F) % 0x14)
            local terrain_match = Map.Movement.Type ==
                                      GameSettings.Movement.ShipOverworld or
                                      encounter.TerrainType ==
                                      Map.Tileset.Terrain

            if area_match and terrain_match then
                return encounter.BattleEncountersIndex
            end
        end
    end

    return 0
end
