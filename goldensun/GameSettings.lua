GameSettings = {}

GameSettings.RandomModifiers = {Agility = 0.0625}

GameSettings.DebugMode = {address = 0x03001238}

GameSettings.Encounters = {
    Data = {
        Address = 0x080EDACC,
        Offset = 0x1C,
        LevelOffset = 0x2,
        GroupIDsOffset = 0x4,
        GroupRatiosOffset = 0x14
    },
    OverworldData = {
        Address = 0x080EEDBC,
        Offset = 0x8,
        TerrainTypeOffset = 0x2,
        StoryFlagIndexOffset = 0x4,
        BattleEncountersIndexOffset = 0x6
    },
    OverworldShipData = {
        Address = 0x080EEF34,
        Offset = 0x8,
        TerrainTypeOffset = 0x2,
        StoryFlagIndexOffset = 0x4,
        BattleEncountersIndexOffset = 0x6
    },
    Groups = {
        Address = 0x0812CE7C,
        Offset = 0x18,
        MinOffset = 0xA,
        MaxOffset = 0xF
    }
}

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

GameSettings.Party = {Order = 0x02000458}

GameSettings.Map = {
    Number = 0x02000428,
    Door = 0x0200042A,
    Retreat = 0x020004A0,
    TileAddress = 0x020301A4,

    TileXOffset = 0x4,
    TileYOffset = 0x200,
    TileOverworldYOffset = 0x80,

    Zone = 0x0203018C,

    Type = 0x0203018A,
    TerrainType = 0x0802F004,

    NormalX = 0x020322F6,
    NormalY = 0x020322FE,
    OverworldX = 0x020321C2,
    OverworldY = 0x020321CA,
    NormalShipX = 0x02032376,
    NormalShipY = 0x0203237E,
    OverworldShipX = 0x02032242,
    OverworldShipY = 0x0203224A,

    BattleBackgroundFunction = 0x080CA514
}

GameSettings.Layer = {Offset = {0x138, 0x170, 0x1a8}}

GameSettings.State = {address = 0x02000060}

GameSettings.RandomNumber = {Battle = 0x020054C8, General = 0x030011BC}
GameSettings.Movement = {
    Tick = 0x020301A0,
    Type = 0x02000452,
    StepRate = 0x02030194,
    StepCount = 0x0200049A,

    Normal = 0x0,
    Overworld = 0x1,
    ClimbingWall = 0x2,
    ClimbingRope = 0x3,
    WalkingRope = 0x4,
    Sand = 0x5,
    ShipNormal = 0x6,
    ShipOverworld = 0x7,
    ShipHover = 0x8,
    SandOverworld = 0x9,
    Hover = 0xA,
    SlipperyGround = 0xB
}

GameSettings.Battle = {
    FrontParty = 0x020300A4,

    Turn = {Address = 0x02030338, SlotOffset = 0x10, AgilityOffset = 0x04},

    Enemy = {
        Address = 0x020308C8,
        Offset = 0x14C,
        MaxHPOffset = 0x34,
        CurrentHPOffset = 0x38,
        AgilityOffset = 0x1C,
        LevelOffset = 0xF
    },

    FleeAttempts = 0x02030092,
    Type = 0x0200048B
}

GameSettings.EnemyNames = {
    [1] = "Venus Djinni",
    [2] = "Venus Djinni",
    [3] = "Venus Djinni",
    [4] = "Venus Djinni",
    [5] = "Venus Djinni",
    [6] = "Venus Djinni",
    [7] = "Venus Djinni",
    [8] = "Venus Djinni",
    [9] = "Venus Djinni",
    [10] = "Venus Djinni",
    [11] = "Venus Djinni",
    [12] = "Venus Djinni",
    [13] = "Venus Djinni",
    [14] = "Venus Djinni",
    [15] = "Mercury Djinni",
    [16] = "Mercury Djinni",
    [17] = "Mercury Djinni",
    [18] = "Mercury Djinni",
    [19] = "Mercury Djinni",
    [20] = "Mercury Djinni",
    [21] = "Mercury Djinni",
    [22] = "Mercury Djinni",
    [23] = "Mercury Djinni",
    [24] = "Mercury Djinni",
    [25] = "Mercury Djinni",
    [26] = "Mercury Djinni",
    [27] = "Mercury Djinni",
    [28] = "Mercury Djinni",
    [29] = "Mercury Djinni",
    [30] = "Mars Djinni",
    [31] = "Mars Djinni",
    [32] = "Mars Djinni",
    [33] = "Mars Djinni",
    [34] = "Mars Djinni",
    [35] = "Mars Djinni",
    [36] = "Mars Djinni",
    [37] = "Mars Djinni",
    [38] = "Mars Djinni",
    [39] = "Mars Djinni",
    [40] = "Mars Djinni",
    [41] = "Mars Djinni",
    [42] = "Mars Djinni",
    [43] = "Mars Djinni",
    [44] = "Jupiter Djinni",
    [45] = "Jupiter Djinni",
    [46] = "Jupiter Djinni",
    [47] = "Jupiter Djinni",
    [48] = "Jupiter Djinni",
    [49] = "Jupiter Djinni",
    [50] = "Jupiter Djinni",
    [51] = "Jupiter Djinni",
    [52] = "Jupiter Djinni",
    [53] = "Jupiter Djinni",
    [54] = "Jupiter Djinni",
    [55] = "Jupiter Djinni",
    [56] = "Jupiter Djinni",
    [57] = "Jupiter Djinni",
    [58] = "Jupiter Djinni",
    [59] = "?",
    [60] = "Ruffian",
    [61] = "Ruffian 2",
    [62] = "Ruffian 3",
    [63] = "Punch Ant",
    [64] = "Flash Ant",
    [65] = "Numb Ant",
    [66] = "Chestbeater",
    [67] = "Wild Gorilla",
    [68] = "Crazy Gorilla",
    [69] = "King Scorpion",
    [70] = "Devil Scorpion",
    [71] = "Sand Scorpion",
    [72] = "Briggs",
    [73] = "Sea Fighter",
    [74] = "Champa 2",
    [75] = "Champa 3",
    [76] = "Cuttle",
    [77] = "Calamar",
    [78] = "Man o' War",
    [79] = "Aqua Jelly",
    [80] = "Aqua Hydra",
    [81] = "Hydra",
    [82] = "Pyrodra",
    [83] = "Serpent",
    [84] = "Serpent",
    [85] = "Serpent",
    [86] = "Serpent",
    [87] = "Serpent",
    [88] = "Serpent 6",
    [89] = "Serpent 7",
    [90] = "Avimander",
    [91] = "Macetail",
    [92] = "Bombander",
    [93] = "Poseidon",
    [94] = "Poseidon",
    [95] = "Poseidon 3",
    [96] = "Moapa",
    [97] = "Moapa",
    [98] = "Moapa",
    [99] = "Knight",
    [100] = "Knight",
    [101] = "Knight 3",
    [102] = "Agatio",
    [103] = "Agatio",
    [104] = "Agatio",
    [105] = "Karst",
    [106] = "Karst",
    [107] = "Karst",
    [108] = "?",
    [109] = "Wild Wolf",
    [110] = "Dire Wolf",
    [111] = "White Wolf",
    [112] = "Angle Worm",
    [113] = "Fire Worm",
    [114] = "Chimera Worm",
    [115] = "Mini-Goblin",
    [116] = "Alec Goblin",
    [117] = "Baboon Goblin",
    [118] = "Momonga",
    [119] = "Squirrelfang",
    [120] = "Momangler",
    [121] = "Kobold",
    [122] = "Wargold",
    [123] = "Kobold King",
    [124] = "Mad Plant",
    [125] = "Mad Plant",
    [126] = "Mad Plant",
    [127] = "Mad Plant",
    [128] = "Mad Plant",
    [129] = "Emu",
    [130] = "Talon Runner",
    [131] = "Winged Runner",
    [132] = "Mummy",
    [133] = "Foul Mummy",
    [134] = "Grave Wight",
    [135] = "Wyvern Chick",
    [136] = "Pteranodon",
    [137] = "Winged Lizard",
    [138] = "Wolfkin Cub",
    [139] = "Wolfkin",
    [140] = "Skinwalker",
    [141] = "Dino",
    [142] = "Dinox",
    [143] = "Dinosaurus",
    [144] = "Assassin",
    [145] = "Slayer",
    [146] = "Dark Murder",
    [147] = "Doomsayer",
    [148] = "Lich",
    [149] = "Bane Wight",
    [150] = "Pixie",
    [151] = "Faery",
    [152] = "Weird Nypmh",
    [153] = "Wood Walker",
    [154] = "Elder Wood",
    [155] = "Estre Wood",
    [156] = "Star Magician",
    [157] = "Dark Wizard",
    [158] = "Evil Shaman",
    [159] = "Urchin Beast",
    [160] = "Needle Egg",
    [161] = "Sea Hedgehog",
    [162] = "Conch Shell",
    [163] = "Spiral Shell",
    [164] = "Poison Shell",
    [165] = "Merman",
    [166] = "Gillman",
    [167] = "Gillman Lord",
    [168] = "Sea Dragon",
    [169] = "Turtle Dragon",
    [170] = "Ocean Dragon",
    [171] = "Seabird",
    [172] = "Seafowl",
    [173] = "Great Seagull",
    [174] = "Roc",
    [175] = "Raptor",
    [176] = "Fell Raptor",
    [177] = "Wyvern",
    [178] = "Sky Dragon",
    [179] = "Winged Dragon",
    [180] = "Phoenix",
    [181] = "Fire Bird",
    [182] = "Wonder Bird",
    [183] = "Blue Dragon",
    [184] = "Cruel Dragon",
    [185] = "Dragon",
    [186] = "Flame Dragon",
    [187] = "Flame Dragon",
    [188] = "Fire Dragon",
    [189] = "Minotaurus",
    [190] = "Minos Warrior",
    [191] = "Minos Knight",
    [192] = "Gressil",
    [193] = "Little Death",
    [194] = "Mini-Death",
    [195] = "Red Demon",
    [196] = "Lesser Demon",
    [197] = "Mad Demon",
    [198] = "Aka Manah",
    [199] = "Druj",
    [200] = "Aeshma",
    [201] = "Valukar",
    [202] = "Valukar",
    [203] = "Valukar",
    [204] = "Living Armor",
    [205] = "Puppet Warrior",
    [206] = "Estre Baron",
    [207] = "Ghost Army",
    [208] = "Soul Army",
    [209] = "Spirit Army",
    [210] = "Dullahan",
    [211] = "Dullahan",
    [212] = "Dullahan",
    [213] = "Sentinel",
    [214] = "Sentinel",
    [215] = "Sentinel",
    [216] = "Vermin",
    [217] = "Vermin",
    [218] = "Mad Vermin",
    [219] = "Bat",
    [220] = "Bat",
    [221] = "Rabid Bat",
    [222] = "Giant Bat",
    [223] = "Wild Mushroom",
    [224] = "Wild Mushroom",
    [225] = "Death Cap",
    [226] = "Slime",
    [227] = "Slime",
    [228] = "Ooze",
    [229] = "Slime Beast",
    [230] = "Ghost",
    [231] = "Ghost Mage",
    [232] = "Horned Ghost",
    [233] = "Lich",
    [234] = "Zombie",
    [235] = "Undead",
    [236] = "Wight",
    [237] = "Bandit",
    [238] = "Thief",
    [239] = "Brigand",
    [240] = "Skeleton",
    [241] = "Bone Fighter",
    [242] = "Skull Warrior",
    [243] = "Will Head",
    [244] = "Death Head",
    [245] = "Willowisp",
    [246] = "Rat",
    [247] = "Armored Rat",
    [248] = "Plated Rat",
    [249] = "Rat Soldier",
    [250] = "Rat Fighter",
    [251] = "Rat Warrior",
    [252] = "Drone Bee",
    [253] = "Fighter Bee",
    [254] = "Warrior Bee",
    [255] = "Troll",
    [256] = "Cave Troll",
    [257] = "Brutal Troll",
    [258] = "Spider",
    [259] = "Tarantula",
    [260] = "Recluse",
    [261] = "Gnome",
    [262] = "Gnome Mage",
    [263] = "Gnome Wizard",
    [264] = "Ghoul",
    [265] = "Fiendish Ghoul",
    [266] = "Cannibal Ghoul",
    [267] = "Mauler",
    [268] = "Ravager",
    [269] = "Grisly",
    [270] = "Harpy",
    [271] = "Virago",
    [272] = "Harridan",
    [273] = "Siren",
    [274] = "Succubus",
    [275] = "Nightmare",
    [276] = "Mole",
    [277] = "Mad Mole",
    [278] = "Mole Mage",
    [279] = "Dirge",
    [280] = "Foul Dirge",
    [281] = "Vile Dirge",
    [282] = "Ape",
    [283] = "Killer Ape",
    [284] = "Dirty Ape",
    [285] = "Grub",
    [286] = "Worm",
    [287] = "Acid Maggot",
    [288] = "Orc",
    [289] = "Orc Captain",
    [290] = "Orc Lord",
    [291] = "Salamander",
    [292] = "Earth Lizard",
    [293] = "Thunder Lizard",
    [294] = "Manticore",
    [295] = "Magicore",
    [296] = "Manticore King",
    [297] = "Kobold",
    [298] = "Goblin",
    [299] = "Hobgoblin",
    [300] = "Gargoyle",
    [301] = "Clay Gargoyle",
    [302] = "Ice Gargoyle",
    [303] = "Gryphon",
    [304] = "Wild Gryphon",
    [305] = "Wise Gryphon",
    [306] = "Golem",
    [307] = "Earth Golem",
    [308] = "Grand Golem",
    [309] = "Dread Hound",
    [310] = "Cerberus",
    [311] = "Fenrir",
    [312] = "Stone Soldier",
    [313] = "Boulder Beast",
    [314] = "Raging Rock",
    [315] = "Chimera",
    [316] = "Chimera Mage",
    [317] = "Grand Chimera",
    [318] = "Amaze",
    [319] = "Amaze",
    [320] = "Creeper",
    [321] = "Spirit",
    [322] = "Lizard Man",
    [323] = "Lizard Fighter",
    [324] = "Lizard King",
    [325] = "Ant Lion",
    [326] = "Roach",
    [327] = "Doodle Bug",
    [328] = "Toadonpa",
    [329] = "Poison Toad",
    [330] = "Devil Frog",
    [331] = "Living Statue",
    [332] = "Hydros Statue",
    [333] = "Azart",
    [334] = "Azart",
    [335] = "Satrage",
    [336] = "Satrage",
    [337] = "Navampa",
    [338] = "Navampa",
    [339] = "Tret",
    [340] = "Kraken",
    [341] = "Tornado Lizard",
    [342] = "Storm Lizard",
    [343] = "Tempest Lizard",
    [344] = "Mystery Man",
    [345] = "Saturos",
    [346] = "Saturos",
    [347] = "Mystery Woman",
    [348] = "Menardi",
    [349] = "Fusion Dragon",
    [350] = "Deadbeard",
    [351] = "Mimic",
    [352] = "Mimic",
    [353] = "Mimic",
    [354] = "Mimic",
    [355] = "Mimic",
    [356] = "Mimic",
    [357] = "Mimic",
    [358] = "Mimic",
    [359] = "Mimic",
    [360] = "Zombie",
    [361] = "Doom Dragon",
    [362] = "Doom Dragon",
    [363] = "Doom Dragon",
    [364] = "Doom Dragon",
    [365] = "Doom Dragon",
    [366] = "Doom Dragon",
    [367] = "Doom Dragon",
    [368] = "Doom Dragon",
    [369] = "Doom Dragon",
    [370] = "Refresh Ball",
    [371] = "Thunder Ball",
    [372] = "Anger Ball",
    [373] = "Guardian Ball",
    [374] = "Azart",
    [375] = "Satrage",
    [376] = "Navampa",
    [377] = "Bandit",
    [378] = "Thief"
}

GameSettings.Enemy = { -- Need to double check all these
    Address = 0x080B9E7C,
    Offset = 0x4C,
    LevelOffset = 0xF,
    HPOffset = 0x10,
    AttackOffset = 0x14,
    DefenseOffset = 0x16,
    AgilityOffset = 0x18,
    LuckOffset = 0x1A,
    TurnOffset = 0x1B,
    ItemsOffset = 0x1E,
    ItemQuantityOffset = 0x26,
    AbilitiesOffset = 0x2E,
    ExpOffset = 0x48
}

function GameSettings.initialize()
    for id, name in pairs(GameSettings.Characters) do
        local base = GameSettings.PlayerCharacterData.BaseAddress +
                         GameSettings.PlayerCharacterData.CharacterOffset * id
        GameSettings.Character[name] = {
            CurrentAgility = base +
                GameSettings.PlayerCharacterData.AgilityOffset,
            CurrentHP = base + GameSettings.PlayerCharacterData.CurrentHPOffset,
            CurrentPP = base + GameSettings.PlayerCharacterData.CurrentPPOffset,
            Level = base + GameSettings.PlayerCharacterData.LevelOffset
        }
    end

    for id, name in pairs(GameSettings.EnemyNames) do
        local base = GameSettings.Enemy.Address + id * GameSettings.Enemy.Offset

        local items = {}
        for i = 0, 3 do
            local item = emulator:read_word(base +
                                                GameSettings.Enemy.ItemsOffset +
                                                i)
            local quantity = emulator:read_byte(base +
                                                    GameSettings.Enemy
                                                        .ItemQuantityOffset + i)
            items[i] = {[item] = quantity}
        end

        local abilities = {}
        for i = 0, 7 do
            -- Get name somehow?
            abilities[i] = emulator:read_word(base +
                                                  GameSettings.Enemy
                                                      .AbilitiesOffset + i)
        end

        GameSettings.Enemy[id] = {
            Name = name,
            Level = emulator:read_byte(base + GameSettings.Enemy.LevelOffset),
            HP = emulator:read_word(base + GameSettings.Enemy.HPOffset),
            Attack = emulator:read_word(base + GameSettings.Enemy.AttackOffset),
            Defense = emulator:read_word(base + GameSettings.Enemy.DefenseOffset),
            Agility = emulator:read_word(base + GameSettings.Enemy.AgilityOffset),
            Luck = emulator:read_byte(base + GameSettings.Enemy.LuckOffset),
            Turns = emulator:read_byte(base + GameSettings.Enemy.TurnOffset),
            Items = items,
            Abilities = abilities,
            Exp = emulator:read_word(base + GameSettings.Enemy.ExpOffset)
        }
    end

    for i = 0, 659 do
        local base = GameSettings.Encounters.Groups.Address +
                         GameSettings.Encounters.Groups.Offset * i

        local enemies = {}
        for j = 0, 4 do
            enemies[j] = {
                ID = emulator:read_word(base + j * 0x2),
                Min = emulator:read_byte(base +
                                             GameSettings.Encounters.Groups
                                                 .MinOffset + j),
                Max = emulator:read_byte(base +
                                             GameSettings.Encounters.Groups
                                                 .MaxOffset + j)
            }
        end

        GameSettings.Encounters.Groups[i] = {Enemies = enemies}
    end

    for i = 0, 109 do
        local base = GameSettings.Encounters.Data.Address +
                         GameSettings.Encounters.Data.Offset * i
        local groups = {}
        for j = 1, 8 do
            local group_id = emulator:read_word(base +
                                                    GameSettings.Encounters.Data
                                                        .GroupIDsOffset +
                                                    (j - 1) * 0x2)
            local ratio = emulator:read_byte(base +
                                                 GameSettings.Encounters.Data
                                                     .GroupRatiosOffset +
                                                 (j - 1))
            groups[j] = {ID = group_id, Ratio = ratio}
        end

        GameSettings.Encounters.Data[i] = {
            Rate = emulator:read_word(base),
            Level = emulator:read_word(base +
                                           GameSettings.Encounters.Data
                                               .LevelOffset),
            Groups = groups
        }
    end

    for i = 0, 45 do
        local base = GameSettings.Encounters.OverworldData.Address +
                         GameSettings.Encounters.OverworldData.Offset * i

        GameSettings.Encounters.OverworldData[i] = {
            AreaType = emulator:read_word(base),
            TerrainType = emulator:read_word(base +
                                                 GameSettings.Encounters
                                                     .OverworldData
                                                     .TerrainTypeOffset),
            StoryFlagIndex = emulator:read_word(base +
                                                    GameSettings.Encounters
                                                        .OverworldData
                                                        .StoryFlagIndexOffset),
            BattleEncountersIndex = emulator:read_word(base +
                                                           GameSettings.Encounters
                                                               .OverworldData
                                                               .BattleEncountersIndexOffset)
        }
    end

    for i = 0, 2 do
        local base = GameSettings.Encounters.OverworldShipData.Address +
                         GameSettings.Encounters.OverworldShipData.Offset * i

        GameSettings.Encounters.OverworldShipData[i] = {
            AreaType = emulator:read_word(base),
            TerrainType = emulator:read_word(base +
                                                 GameSettings.Encounters
                                                     .OverworldShipData
                                                     .TerrainTypeOffset),
            StoryFlagIndex = emulator:read_word(base +
                                                    GameSettings.Encounters
                                                        .OverworldShipData
                                                        .StoryFlagIndexOffset),
            BattleEncountersIndex = emulator:read_word(base +
                                                           GameSettings.Encounters
                                                               .OverworldShipData
                                                               .BattleEncountersIndexOffset)
        }
    end
end
