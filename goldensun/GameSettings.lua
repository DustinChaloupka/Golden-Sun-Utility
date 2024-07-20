GameSettings = {}

GameSettings.RandomModifiers = {Agility = 0.0625}

GameSettings.DebugMode = {address = 0x03001238}

GameSettings.Encounters = {StepCounter = {address = 0x02000498}}

GameSettings.Characters = {
    [0] = "Isaac",
    [1] = "Garet",
    [2] = "Ivan",
    [3] = "Mia",
    [4] = "Felix",
    [5] = "Jenna",
    [6] = "Sheba",
    [7] = "Piers"
}

GameSettings.PlayerCharacterData = {
    BaseAddress = 0x02000520,
    CharacterOffset = 0x14C,

    AgilityOffset = 0x40,
    CurrentHPOffset = 0x38,
    CurrentPPOffset = 0x3A,
    LevelOffset = 0xF
}

GameSettings.Character = {}
for id, name in pairs(GameSettings.Characters) do
    local base = GameSettings.PlayerCharacterData.BaseAddress +
                     GameSettings.PlayerCharacterData.CharacterOffset * id
    GameSettings.Character[name] = {
        CurrentAgility = base + GameSettings.PlayerCharacterData.AgilityOffset,
        CurrentPP = base + GameSettings.PlayerCharacterData.CurrentPPOffset
    }
end

GameSettings.Map = {
    Number = 0x02000420, -- 0x02000428 in doc says "current" map and door number
    TileAddress = 0x020301A4,
    LayerAddress = 0x03000020,

    TileXOffset = 0x4,
    TileYOffset = 0x200,
    TileOverworldYOffset = 0x80
}

GameSettings.Layer = {Offset = {0x138, 0x170, 0x1a8}}

GameSettings.State = {address = 0x02000060}

GameSettings.RandomNumber = {Battle = 0x020054C8, General = 0x030011BC}
GameSettings.Movement = {
    Tick = 0x020301A0,
    StepRate = 0x02030194,
    StepCount = 0x0200049A
}

GameSettings.Battle = {
    ActiveParty = 0x020300A4,

    RAM = 0x02030338,

    Slot = {Offset = 0x10, AgilityOffset = 0x04}
}

function GameSettings.initialize() end
