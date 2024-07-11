GameSettings = {}

GameSettings.DebugMode = {address = 0x03001238}

GameSettings.Encounters = {StepCounter = {address = 0x02000498}}

GameSettings.PlayerCharacterData = {
    BaseAddress = 0x02000520,
    CharacterOffset = 0x14C,

    AgilityOffset = 0x40,
    CurrentHPOffset = 0x38,
    CurrentPPOffset = 0x3A,
    LevelOffset = 0xF
}

GameSettings.Map = {
    Number = 0x02000420, -- 0x02000428 in doc says "current" map and door number
    TileAddress = 0x020301A4,
    LayerAddress = 0x3000020,

    TileXOffset = 0x4,
    TileYOffset = 0x200,
    TileOverworldYOffset = 0x80
}

GameSettings.Layer = {Offset = {0x138, 0x170, 0x1a8}}

GameSettings.State = {address = 0x02000060}

function GameSettings:initialize()
    local isaac_data = GameSettings.PlayerCharacterData.BaseAddress
    local garet_data = GameSettings.PlayerCharacterData.BaseAddress +
                           GameSettings.PlayerCharacterData.CharacterOffset
    local ivan_data = GameSettings.PlayerCharacterData.BaseAddress +
                          GameSettings.PlayerCharacterData.CharacterOffset * 2
    local mia_data = GameSettings.PlayerCharacterData.BaseAddress +
                         GameSettings.PlayerCharacterData.CharacterOffset * 3
    local felix_data = GameSettings.PlayerCharacterData.BaseAddress +
                           GameSettings.PlayerCharacterData.CharacterOffset * 4
    local jenna_data = GameSettings.PlayerCharacterData.BaseAddress +
                           GameSettings.PlayerCharacterData.CharacterOffset * 5
    local sheba_data = GameSettings.PlayerCharacterData.BaseAddress +
                           GameSettings.PlayerCharacterData.CharacterOffset * 6
    local piers_data = GameSettings.PlayerCharacterData.BaseAddress +
                           GameSettings.PlayerCharacterData.CharacterOffset * 7

    GameSettings.Character = {
        Isaac = {},
        Garet = {},
        Ivan = {},
        Mia = {},
        Felix = {
            CurrentPP = felix_data +
                GameSettings.PlayerCharacterData.CurrentPPOffset
        },
        Jenna = {},
        Sheba = {},
        Piers = {}
    }
end
