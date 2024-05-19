print('loading config.lua')
Config = {}

-- DAMAGE SYSTEM
Config.Framework = 'qb' -- Set this to your framework. 'qb' or 'esx'
Config.b2060 = true -- Set this to true if you are using server version 2060 or above, otherwise set it to false
Config.b2545 = true -- Set this to tru if you are using server version 2545 or above, otherwise set it to false
Config.startDamageTimer = 5000 -- Time in ms before the player damages gets applied when loading the chracters
Config.UseRadialProgressBar = true -- Use the radial progress bar instead of the default one
Config.UseOxNotif = false -- Set this to false if you want to use the default framework notificatins
Config.UseOxInventory = false -- Set this to true if you use ox_inventory
Config.UsedInventory = '' -- qs or ox or nothing(default)

Config.webHook = 'https://discord.com/api/webhooks/1240510162758799382/EcNiDTBObF7-rp8vNZd6Jv3YWAl35ikhgyGo1O8_9zHGsqiNgMw2KyGi30R1VMMnDkA2'
Config.webHookName = 'OSP Development - Ambulance' -- Name of the WebHook bot
Config.webHookLogo = 'https://cdn.discordapp.com/attachments/1102704629025886360/1227748671211180062/image.png?ex=6629890d&is=6617140d&hm=60043a8694fb72acc6cd4b1a7f21194d6dfc5df1ce2c79b34545ab358a3bf8c6&' -- Logo of the WebHook bot

Config.UseTarget = true -- Set to false if you don't want to use targetting at all and instead use drawtext
Config.UseOxTarget = false -- Set to false if you don't want to use ox_target
Config.TargetName = 'qb-target' -- The name of the target resource (only needed if you use qb-target or qtarget)
Config.Dispatch = 'default' -- Usable dispatch inputs: 'default', 'ps', 'other'



Config.OpenKey = 'o' -- The default key to open the damage menu
Config.SkellyKey = 'k' -- The default key to open the skelly overview
Config.LockMedicalMenu = false -- Set to true if you want to lock the medical menu to only be opened by EMS

Config.ServerDelay = 100 -- How many ms the server is behind by. Recommended to keep above 100ms. Should say in your server console by how far behind your server is.
Config.Debug = false -- Enable or disable debug mode to investigate issues with the script

Config.CustomDeathScreen = false -- Enable of disable a customised death timer screen, keep at false if you don't know what you are doing
Config.PopUpSkelly = true

Config.AmbulanceJobs = {
    'ambulance',
    'firefighter',
}

Config.InteractionDict = 'anim@heists@narcotics@funding@gang_idle'
Config.InteractionAnim = 'gang_chatting_idle01'


Config.MinimalDoctors = 1 -- How many players with the ambulance job to prevent the hospital check-in system from being used
Config.DocCooldown = 1 -- Cooldown between doctor calls allowed, in minutes
Config.AIHealTimer = 10 -- How long it will take to be healed after checking in, in seconds
Config.WipeInventoryOnRespawn = false -- Enable or disable removing all the players items when they respawn at the hospital
Config.Helicopter = "c3medhawk" -- Helicopter model that players with the ambulance job can use
Config.BillCost = 500 -- Price that players are charged for using the hospital check-in system
Config.LastStandTime = 240 -- How long before the player is percived as medically dead (in seconds)
Config.RespawnTime = 120 -- How long before the player can respawn (in seconds)
Config.PropDespawnTimer = 360*1000 -- How long before the ecg prop despawns after being placed in ms
Config.SavePlayerDataTimer = 30*1000 -- How often the player data should be saved in ms (the lower the more accurate the data is saved but the more performance impact) (The data is sent to the server so that the player data is saved when the player quits)
Config.AntiCombatLogLoop = 200 -- How often the anti combat log loop should run in ms (lower is better but has a higher performance impact)
Config.DeadBlipDelay = 360 -- How long the dead blip should be visible on the map in ms, with each tick of this reducing the transpaerncy of the blip 250 - 0
Config.AutomaticAmbulanceAlert = false -- Enable or disable the automatic ambulance alert when a player is downed
Config.inLastStandHealth = 150 -- The health the player should have when they are in last stand
Config.DeathHealth = 200 -- The health the player should have when they are dead

Config.MutePlayerOnLastStand = false
Config.MutePlayerOnDeath = true


-- Regen stuff
Config.BleedLossMultiplier = 1.0
Config.BleedingUpdate = 40000 -- How often should the bleeding update in ms?
Config.BloodRegen = 0.0025 -- The amount of blood that regen every 10 seconds in liter (6 liters is max). (When in stable condition)
Config.HealthRegen = 1 -- The amount of health that regen every 10 seconds in healthpoints (200 is max). (When in good condition)
Config.HealthRegenUpdate = 10000

Config.MinimumBleedAmountBeforeHealthDegen = 0.005 -- The minimum amount of blood that must be activly lost before health starts to degenerate
Config.HealthBleedingDegen = 1 -- The amount of health that degens every bleedingupdate, in healthpoints. (When bleeding)
Config.HealthDegenUpdate = 3000 -- How often the health should degenerate when bleeding in ms

Config.KillPlayerInCriticalCondition = true -- Enable or disable the kill player when in critical condition (lower bpm than 30 and next to no bloodpressure)

-- The different types of equipment and their time to apply in ms
Config.QuickCheckVitalsTime = 3000 -- How long it should take to check pulse etc in ms
Config.TourniquetTime = 3000 -- Time to apply/remove tourniquet in ms
Config.TourniquetPain = 3 -- How much pain the tourniquet should cause

Config.DressingTime = 5000
Config.ElasticTime = 8000
Config.QuickClotTime = 4000
Config.PackingTime = 4000
Config.SewingTime = 10000
Config.BodybagTime = 10000
Config.ReviveKitTime = 5000

Config.Epinephrine = 3000
Config.EpinephrineDuration = 30000 -- How long the epinephrine should last in ms

Config.Morphine = 3000
Config.MorphineDuration = 30000 -- How long the morphine should last in ms

Config.BloodSetupTime = 3000 
Config.BloodInjectingTime250 = 120 -- in seconds 
Config.BloodInjectingTime500 = 200 -- in seconds

Config.SalinePack250Content = 75 -- How much blood the saline pack should give in ml
Config.SalinePack500Content = 150 -- How much blood the saline pack should give in ml


-- SIDE EFFECTS
Config.SideEffectsTime = 60000 -- The interval for how often the side effects should be triggered in ms

Config.ArmInjuryChance = 10 -- Chance, in percent, that an arm injury side-effect gets applied
Config.ArmInjuryTimer = 10 -- How much time, in seconds. (This disables firing weapons and stearing a vehicles left/right)

Config.HeadInjuryChance = 50 -- Chance, in percent, that a head injury side-effect gets applied

Config.CameraShakeIntensity = 0.1 -- How intense the camera shake should be when injured
Config.LegInjuryChance = { -- The chance, in percent, that leg injury side-effects get applied
    Running = 30,
    Walking = 10
}

Config.UseMovementRate = true -- Might contradict with other gym scripts? Set to false if so
Config.MovementRate = { -- Set the player movement rate based on the leg health
    0.95,
    0.85,
    0.80,
}

Config.BleedTime = 5000 -- The interval for how often the bleed effect (only visual) should be triggered in ms

-- SCREEN EFFECTS
Config.PainThreshold = 10 -- The pain threshold for when the screen should start to flash

Config.BlackoutEffect = true
Config.PainEffect = true
Config.BleedEffect = true

-- Wheelchair and Crutch
Config.MaxWheelChairTime = 60 -- The maximum time a player can be set in a wheelchair in minutes
Config.MaxCrutchTime = 60 -- The maximum time a player can be set in a wheelchair in minutes


-- Ambulances with stretcher support
Config.Ambulances = {
    ["ambulance"] = {
        offsetinstart = vector3(0.0, -5.0, 0.0),
        offsetinstop = vector3(0.0, 0.25, 0.0),
        offsetoutstart = vector3(0.0, -2.75, 0.0),
        offsetoutstop = vector3(0.0, -7.0, 0.0),
        rotation = vector3(0.0, 0.0, 90.0),
        
        stretcheroffset = vector3(0.0,-0.80,-0.2),
        stretcherrotation = vector3(90.0, -90.0, -195.0),
        playeroffset = vector3(0.0,-2.5,1.6),
        playerrotation = vector3(0.0, 0.0, 177.0),
    },
    ["f550ambows"] = {
        offsetinstart = vector3(0.0, -5.0, 0.0),
        offsetinstop = vector3(0.0, 0.5, 0.0),
        offsetoutstart = vector3(0.0, -2.75, 0.0),
        offsetoutstop = vector3(0.0, -6.0, 0.0),
        rotation = vector3(0.0, 0.0, 90.0),

        stretcheroffset = vector3(0.0,-0.80,-0.2),
        stretcherrotation = vector3(90.0, -90.0, -195.0),
        playeroffset = vector3(0.0,-2.5,1.6),
        playerrotation = vector3(0.0, 0.0, 177.0),
    },
    ["polmav"] = {
        offsetinstart = vector3(-1.5, 1.1, -0.72),
        offsetinstop = vector3(1.5, 1.1, -0.72),
        offsetoutstart = vector3(0.0, 1.1, -0.72),
        offsetoutstop = vector3(-2.5, 1.1, -0.72),
        rotation = vector3(0.0, 0.0, 177.0),

        stretcheroffset = vector3(0.0,-0.80,-0.2),
        stretcherrotation = vector3(90.0, -95.0, -193.0),
        playeroffset = vector3(0.05,1.1,0.97),
        playerrotation = vector3(0.0, 0.0, 90.0),
    },
    ["c3medhawk"] = {
        offsetinstart = vector3(-1.5, -0.7, 0.63),
        offsetinstop = vector3(1.5, 1.1, -0.63),
        offsetoutstart = vector3(0.0, 1.7, 0.63),
        offsetoutstop = vector3(-2.5, 1.1, -0.72),
        rotation = vector3(0.0, 0.0, 177.0),

        stretcheroffset = vector3(0.0,-0.80,-0.2),
        stretcherrotation = vector3(90.0, -95.0, -193.0),
        playeroffset = vector3(0.05,1.1,0.97),
        playerrotation = vector3(0.0, 0.0, 90.0),
    },
}

Config.AuthorizedVehicles = { -- Vehicles players can use based on their ambulance job grade level
	-- Grade 0
	[0] = {
	},
	-- Grade 1
	[1] = {
		["f550ambows"] = "Ambulance",
	},
	-- Grade 2
	[2] = {
		["f550ambows"] = "Ambulance",
	},
	-- Grade 3
	[3] = {
		["f550ambows"] = "Ambulance",
	},
	-- Grade 4
	[4] = {
		["f550ambows"] = "Ambulance",
        ["durangopru"] = "Chief's Durango",
	}
}

Config.VehicleExtras = { -- Enable/disable the vehicle extras when spawning them with the job vehicle spawner
    ["f550ambows"] = { -- Model name
        ["1"] = true, -- on/off
        ["2"] = true,
        ["3"] = true,
        ["4"] = true,
        ["5"] = true,
        ["6"] = true,
        ["7"] = true,
        ["8"] = true,
        ["9"] = true,
        ["10"] = true,
        ["11"] = true,
        ["12"] = true,
    },
    ["durangopru"] = {
        ["1"] = true,
        ["2"] = false,
        ["3"] = false,
        ["4"] = true,
        ["5"] = true,
        ["6"] = false,
        ["7"] = false,
        ["8"] = false,
        ["9"] = false,
        ["10"] = true,
        ["11"] = false,
        ["12"] = false,
        ["13"] = false,
    }
}


Config.InventoryItems = {
    ['epinephrine'] = 'epinephrine',  -- Change the latter iteration name to your inventory item names, if you for some reason have changed them. (NOT RECOMMENDED) 
    ['morphine'] = 'morphine',
    ['tourniquet'] = 'tourniquet',
    ['field_dressing'] = 'field_dressing',
    ['elastic_bandage'] = 'elastic_bandage',
    ['quick_clot'] = 'quick_clot',
    ['packing_bandage'] = 'packing_bandage',
    ['sewing_kit'] = 'sewing_kit',
    ['blood250ml'] = 'blood250ml',
    ['blood500ml'] = 'blood500ml',
    ['saline250ml'] = 'saline250ml',
    ['saline500ml'] = 'saline500ml',
    ['revivekit'] = 'revivekit',
    ['bodybag'] = 'bodybag',
}


-- Items that can be purchased by the ambulance personel
Config.ItemShop = { -- The stock resets every script restart but is synced to all players
    {
        label = 'Radio',
        name = "radio",
        price = 1,
        type = "item",
    },
    {
        label = 'Flashlight',
        name = "weapon_flashlight",
        price = 1,
        type = "item",
    },
    {
        label = 'Pager',
        name = "pager",
        price = 1,
        type = "item",
    },
    {
        label = 'ECG',
        name = "ecg",
        price = 1,
        type = "item",
        amount = 3,
    },
    {
        label = 'Stretcher',
        name = "stretcher",
        price = 1,
        type = "item",
        amount = 5,
    },
    {
        label = 'Wheelchair',
        name = "wheelchair",
        price = 1,
        type = "item",
        amount = 5,
    },
    {
        label = 'Crutch',
        name = "crutch",
        price = 1,
        type = "item",
        amount = 5,
    },
    {
        label = 'IFAK',
        name = "ifak",
        price = 1,
        type = "item",
        amount = 25,
    },
    {
        label = 'Tourniquet',
        name = "tourniquet",
        price = 1,
        type = "item",
        amount = 30,
    },
    {
        label = 'Field Dressing',
        name = "field_dressing",
        price = 1,
        type = "item",
        amount = 50,
    },
    {
        label = 'Elastic Bandage',
        name = "elastic_bandage",
        price = 1,
        type = "item",
        amount = 50,
    },
    {
        label = 'Quick Clot',
        name = "quick_clot",
        price = 1,
        type = "item",
        amount = 50,
    },
    {
        label = 'Packing Bandage',
        name = "packing_bandage",
        price = 1,
        type = "item",
        amount = 50,
    },
    {
        label = 'Sewing Kit',
        name = "sewing_kit",
        price = 1,
        type = "item",
        amount = 10,
    },
    {
        label = 'Epinephrine',
        name = "epinephrine",
        price = 1,
        type = "item",
        amount = 15,
    },
    {
        label = 'Morphine',
        name = "morphine",
        price = 1,
        type = "item",
        amount = 15,
    },
    {
        label = 'Blood Pack 250ml',
        name = "blood250ml",
        price = 1,
        type = "item",
        amount = 5,
    },
    {
        label = 'Blood Pack 500ml',
        name = "blood500ml",
        price = 1,
        type = "item",
        amount = 3,
    },
    {
        label = 'Saline 250ml',
        name = "saline250ml",
        price = 1,
        type = "item",
        amount = 25,
    },
    {
        label = 'Saline 500ml',
        name = "saline500ml",
        price = 1,
        type = "item",
        amount = 25,
    },
    {
        label = 'Revive Kit',
        name = "revivekit",
        price = 1,
        type = "item",
        amount = 3,
    },
}

Config.UseGarageSystem = true 

Config.Locations = {
    ["checking"] = {
	    vector3(310.26, -582.47, 43.27),
    },
    ["boss"] = {
        --vector3(-1031.41, -1418.68, 4.97),
    },
    ["duty"] = {
        vector3(-1031.41, -1418.68, 4.97),
    },
    ["vehicle"] = {
        vector4(-1028.7, -1359.85, 4.48, 74.63),    --bay 5
        vector4(-1027.17, -1354.12, 4.48, 75.01),   --bay 6
        vector4(-1025.66, -1348.39, 4.48, 75.64),   --bay 7
    },
    ["helicopter"] = {
        vector4(-1036.16, -1441.18, 9.29, 347.06),  --right helipad
    },
    ["shop"] = {
        --vector3(-1041.12, -1421.56, 4.97),
    },
    ["cloakroom"] = {
        --vector3(-1041.12, -1421.56, 4.97),
    },
    ["roof"] = {
        vector4(338.5, -583.85, 74.16, 245.5),
    },
    ["main"] = {
        vector3(332.3166, -595.6741, 43.2841),
    },
    ["stash"] = {
        --vector3(-1035.23, -1424.9, 4.97),
    },
    ["beds"] = {
        {coords = vector4(327.64, -583.56, 44.12, 150.34), taken = false, model = 1631638868},
        {coords = vector4(330.66, -584.93, 44.12, 158.84), taken = false, model = 1631638868},
        {coords = vector4(328.53, -588.74, 44.12, 336.67), taken = false, model = 2117668672},
        --{coords = vector4(328.44, -588.78, 44.12, 330.68), taken = false, model = 2117668672},
        {coords = vector4(325.57, -587.85, 44.12, 334.64), taken = false, model = 2117668672},
        {coords = vector4(322.59, -586.9,  44.12, 337.67), taken = false, model = -1091386327},
        {coords = vector4(319.84, -585.64, 44.12, 336.48), taken = false, model = -1091386327},
        {coords = vector4(316.89, -584.65, 44.12, 337.46), taken = false, model = -1091386327},
	    {coords = vector4(318.46, -580.52, 44.12, 154.74), taken = false, model = 2117668672},
        {coords = vector4(321.22, -581.56, 44.12, 164.45), taken = false, model = 2117668672},
    },
    ["jailbeds"] = {
        {coords = vector4(1761.96, 2597.74, 45.66, 270.14), taken = false, model = 2117668672},
        {coords = vector4(1761.96, 2591.51, 45.66, 269.8), taken = false, model = 2117668672},
        {coords = vector4(1771.8, 2598.02, 45.66, 89.05), taken = false, model = 2117668672},
        {coords = vector4(1771.85, 2591.85, 45.66, 91.51), taken = false, model = 2117668672},
    },
    ["stations"] = {
        {label = 'Hospital', coords = vector4(304.27, -600.33, 43.28, 272.249)}
    }
}

-- ECG CONFIGURATION
Config.Prop = 'prop_ld_bomb'
Config.RenderDistance = 50 -- The rendering distance of an ECG, recommended to keep above 50 to avoid sync issues. 
Config.Alpha = 100 -- The prop transparency (51-300)
Config.AutoDeleteTime = 500 -- The time in seconds before the ECG is automatically deleted after being placed

-- Recommended to have all different keys (only needed if you _dont_ use target)
Config.PickupButton = 38
Config.AttachButton = 58
Config.DeleteButton = 52
Config.OptionsButton = 58
Config.InjectButton = 244
Config.CprButton = 182


-- INCOMINNG INFORMATION SCREENS CONFIGURATION (ER SCREENS)
Config.ScreenProp = 'xm_prop_x17_tv_ceiling_01' -- The prop used for the screen

Config.IncomingRenderDistance = 70 -- The rendering distance of an incoming screen, recommended to keep above 30 to avoid sync issues.

Config.IncomingScreenPos = { -- The position of the incoming screen
    vector4(332.6308, -581.5911, 46.0, 251.2287),
    vector4(300.8384, -582.8441, 46.0, 91.7694)
}
Config.IncomingScreenSoundPos = vector3(306.2124, -584.6828, 43.2741)
Config.IncomingScreenSoundRange = 50

-- STATIONARY ECG CONFIGURATION (ICU SCREENS)
Config.StationaryECGProp = 'v_med_cor_ceilingmonitor' -- The prop used for the stationary ECG

Config.StationaryECG = { -- IF YOU WANT MORE THAN 6 ECGS YOU NEED TO CREATE MORE GFX FILES.
    {
        coords = vector4(327.9489, -582.8219, 45.8, 344.3082),
        bedcoords = vector3(327.64, -583.56, 44.12),
        name = 'ICU 1'
    },
    {
        coords = vector4(330.9489, -583.8219, 45.8, 344.3082),
        bedcoords = vector3(330.66, -584.93, 44.12),
        name = 'ICU 2'
    },
    {
        coords = vector4(328.0185, -589.3665, 45.8, 162.2001),
        bedcoords = vector3(328.53, -588.74, 44.12),
        name = 'ICU 3'
    },
    {
        coords = vector4(325.2185, -588.3665, 45.8, 162.2001),
        bedcoords = vector3(325.57, -587.85, 44.12),
        name = 'ICU 4'
    },
    {
        coords = vector4(322.3185, -587.3665, 45.8, 162.2001),
        bedcoords = vector3(322.59, -586.9,  44.12),
        name = 'ICU 5'
    },
    {
        coords = vector4(319.4185, -586.3665, 45.8, 162.2001),
        bedcoords = vector3(319.84, -585.64, 44.12),
        name = 'ICU 6'
    },
    -- Some people have experienced issues with having a lot of loaded gfx files.
    {
        coords = vector4(316.6185, -585.3665, 45.8, 162.2001),
        bedcoords = vector3(316.89, -584.65, 44.12),
        name = 'ICU 7'
    },
    {
        coords = vector4(318.8489, -579.8219, 45.8, 344.3082),
        bedcoords = vector3(318.46, -580.52, 44.12),
        name = 'ICU 8'
    },
    {
        coords = vector4(321.7489, -580.8219, 45.8, 344.3082),
        bedcoords = vector3(321.22, -581.56, 44.12),
        name = 'ICU 9'
    },
}



Config.WeaponClasses = { -- Define gta weapon class numbers
    ['SMALL_CALIBER'] = 1,
    ['MEDIUM_CALIBER'] = 2,
    ['HIGH_CALIBER'] = 3,
    ['SHOTGUN'] = 4,
    ['CUTTING'] = 5,
    ['LIGHT_IMPACT'] = 6,
    ['HEAVY_IMPACT'] = 7,
    ['EXPLOSIVE'] = 8,
    ['FIRE'] = 9,
    ['SUFFOCATING'] = 10,
    ['OTHER'] = 11,
    ['WILDLIFE'] = 12,
    ['NOTHING'] = 13,
}

Config.Bones = { -- Correspond bone hash numbers to their label
    [0]     = 'NONE',
    [31085] = 'HEAD',
    [31086] = 'HEAD',
    [39317] = 'NECK',
    [57597] = 'SPINE',
    [23553] = 'SPINE',
    [24816] = 'SPINE',
    [24817] = 'SPINE',
    [24818] = 'SPINE',
    [10706] = 'UPPER_BODY',
    [64729] = 'UPPER_BODY',
    [11816] = 'LOWER_BODY',
    [45509] = 'LARM',
    [61163] = 'LARM',
    [18905] = 'LHAND',
    [4089] = 'LFINGER',
    [4090] = 'LFINGER',
    [4137] = 'LFINGER',
    [4138] = 'LFINGER',
    [4153] = 'LFINGER',
    [4154] = 'LFINGER',
    [4169] = 'LFINGER',
    [4170] = 'LFINGER',
    [4185] = 'LFINGER',
    [4186] = 'LFINGER',
    [26610] = 'LFINGER',
    [26611] = 'LFINGER',
    [26612] = 'LFINGER',
    [26613] = 'LFINGER',
    [26614] = 'LFINGER',
    [58271] = 'LLEG',
    [63931] = 'LLEG',
    [2108] = 'LFOOT',
    [14201] = 'LFOOT',
    [40269] = 'RARM',
    [28252] = 'RARM',
    [57005] = 'RHAND',
    [58866] = 'RFINGER',
    [58867] = 'RFINGER',
    [58868] = 'RFINGER',
    [58869] = 'RFINGER',
    [58870] = 'RFINGER',
    [64016] = 'RFINGER',
    [64017] = 'RFINGER',
    [64064] = 'RFINGER',
    [64065] = 'RFINGER',
    [64080] = 'RFINGER',
    [64081] = 'RFINGER',
    [64096] = 'RFINGER',
    [64097] = 'RFINGER',
    [64112] = 'RFINGER',
    [64113] = 'RFINGER',
    [36864] = 'RLEG',
    [51826] = 'RLEG',
    [20781] = 'RFOOT',
    [52301] = 'RFOOT',
}

Config.BoneIndexes = { -- Correspond bone labels to their hash number
    ['NONE'] = 0,
    ['HEAD'] = 31086,
    ['NECK'] = 39317,
    ['SPINE'] = 24818,
    ['UPPER_BODY'] = 64729,
    ['LOWER_BODY'] = 11816,
    ['LARM'] = 61163,
    ['LHAND'] = 18905,
    ['LFINGER'] = 26614,
    ['LLEG'] = 63931,
    ['LFOOT'] = 14201,
    ['RARM'] = 28252,
    ['RHAND'] = 57005,
    ['RFINGER'] = 64113,
    ['RLEG'] = 51826,
    ['RFOOT'] = 52301,
}

Config.Weapons = { -- Correspond weapon names to their class number
    [`WEAPON_STUNGUN`] = Config.WeaponClasses['NONE'],
    [`WEAPON_STUNGUN_MP`] = Config.WeaponClasses['NONE'],
    --[[ Small Caliber ]]--
    [`WEAPON_PISTOL`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_COMBATPISTOL`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_APPISTOL`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_COMBATPDW`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_MACHINEPISTOL`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_MICROSMG`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_MINISMG`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_PISTOL_MK2`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_SNSPISTOL`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_SNSPISTOL_MK2`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_VINTAGEPISTOL`] = Config.WeaponClasses['SMALL_CALIBER'],

    --[[ Medium Caliber ]]--
    [`WEAPON_ADVANCEDRIFLE`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_ASSAULTSMG`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_BULLPUPRIFLE`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_BULLPUPRIFLE_MK2`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_CARBINERIFLE`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_CARBINERIFLE_MK2`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_COMPACTRIFLE`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_DOUBLEACTION`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_GUSENBERG`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_HEAVYPISTOL`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_MARKSMANPISTOL`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_PISTOL50`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_REVOLVER`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_REVOLVER_MK2`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_SMG`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_SMG_MK2`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_SPECIALCARBINE`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    [`WEAPON_SPECIALCARBINE_MK2`] = Config.WeaponClasses['MEDIUM_CALIBER'],

    --[[ High Caliber ]]--
    [`WEAPON_ASSAULTRIFLE`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_ASSAULTRIFLE_MK2`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_COMBATMG`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_COMBATMG_MK2`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_HEAVYSNIPER`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_HEAVYSNIPER_MK2`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_MARKSMANRIFLE`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_MARKSMANRIFLE_MK2`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_MG`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_MINIGUN`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_MUSKET`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_RAILGUN`] = Config.WeaponClasses['HIGH_CALIBER'],
    [`WEAPON_HEAVYRIFLE`] = Config.WeaponClasses['HIGH_CALIBER'],

    --[[ Shotguns ]]--
    [`WEAPON_ASSAULTSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],
    [`WEAPON_BULLUPSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],
    [`WEAPON_DBSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],
    [`WEAPON_HEAVYSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],
    [`WEAPON_PUMPSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],
    [`WEAPON_PUMPSHOTGUN_MK2`] = Config.WeaponClasses['SHOTGUN'],
    [`WEAPON_SAWNOFFSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],
    [`WEAPON_SWEEPERSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],

    --[[ Animals ]]--
    [`WEAPON_ANIMAL`] = Config.WeaponClasses['WILDLIFE'],
    [`WEAPON_COUGAR`] = Config.WeaponClasses['WILDLIFE'],
    [`WEAPON_BARBED_WIRE`] = Config.WeaponClasses['WILDLIFE'],

    --[[ Cutting Weapons ]]--
    [`WEAPON_BATTLEAXE`] = Config.WeaponClasses['CUTTING'],
    [`WEAPON_BOTTLE`] = Config.WeaponClasses['CUTTING'],
    [`WEAPON_DAGGER`] = Config.WeaponClasses['CUTTING'],
    [`WEAPON_HATCHET`] = Config.WeaponClasses['CUTTING'],
    [`WEAPON_KNIFE`] = Config.WeaponClasses['CUTTING'],
    [`WEAPON_MACHETE`] = Config.WeaponClasses['CUTTING'],
    [`WEAPON_SWITCHBLADE`] = Config.WeaponClasses['CUTTING'],

    --[[ Light Impact ]]--
    [`WEAPON_KNUCKLE`] = Config.WeaponClasses['LIGHT_IMPACT'],
    [`WEAPON_UNARMED`] = Config.WeaponClasses['LIGHT_IMPACT'],

    --[[ Heavy Impact ]]--
    [`WEAPON_BAT`] = Config.WeaponClasses['HEAVY_IMPACT'],
    [`WEAPON_CROWBAR`] = Config.WeaponClasses['HEAVY_IMPACT'],
    [`WEAPON_FIREEXTINGUISHER`] = Config.WeaponClasses['HEAVY_IMPACT'],
    [`WEAPON_FIRWORK`] = Config.WeaponClasses['HEAVY_IMPACT'],
    [`WEAPON_GOLFLCUB`] = Config.WeaponClasses['HEAVY_IMPACT'],
    [`WEAPON_HAMMER`] = Config.WeaponClasses['HEAVY_IMPACT'],
    [`WEAPON_PETROLCAN`] = Config.WeaponClasses['HEAVY_IMPACT'],
    [`WEAPON_POOLCUE`] = Config.WeaponClasses['HEAVY_IMPACT'],
    [`WEAPON_WRENCH`] = Config.WeaponClasses['HEAVY_IMPACT'],
    [`WEAPON_RAMMED_BY_CAR`] = Config.WeaponClasses['HEAVY_IMPACT'],
    [`WEAPON_RUN_OVER_BY_CAR`] = Config.WeaponClasses['HEAVY_IMPACT'],

    --[[ Explosives ]]--
    [`WEAPON_EXPLOSION`] = Config.WeaponClasses['EXPLOSIVE'],
    [`WEAPON_GRENADE`] = Config.WeaponClasses['EXPLOSIVE'],
    [`WEAPON_COMPACTLAUNCHER`] = Config.WeaponClasses['EXPLOSIVE'],
    [`WEAPON_HOMINGLAUNCHER`] = Config.WeaponClasses['EXPLOSIVE'],
    [`WEAPON_PIPEBOMB`] = Config.WeaponClasses['EXPLOSIVE'],
    [`WEAPON_PROXMINE`] = Config.WeaponClasses['EXPLOSIVE'],
    [`WEAPON_RPG`] = Config.WeaponClasses['EXPLOSIVE'],
    [`WEAPON_STICKYBOMB`] = Config.WeaponClasses['EXPLOSIVE'],
    [`WEAPON_HELI_CRASH`] = Config.WeaponClasses['EXPLOSIVE'],
    [`WEAPON_EMPLAUNCHER`] = Config.WeaponClasses['EXPLOSIVE'],

    --[[ Other ]]--
    [`WEAPON_FALL`] = Config.WeaponClasses['OTHER'],
    [`WEAPON_HIT_BY_WATER_CANNON`] = Config.WeaponClasses['OTHER'], 

    --[[ Fire ]]--
    [`WEAPON_ELECTRIC_FENCE`] = Config.WeaponClasses['FIRE'],
    [`WEAPON_FIRE`] = Config.WeaponClasses['FIRE'],
    [`WEAPON_MOLOTOV`] = Config.WeaponClasses['FIRE'],
    [`WEAPON_FLARE`] = Config.WeaponClasses['FIRE'],
    [`WEAPON_FLAREGUN`] = Config.WeaponClasses['FIRE'],

    --[[ Suffocate ]]--
    [`WEAPON_DROWNING`] = Config.WeaponClasses['SUFFOCATING'],
    [`WEAPON_DROWNING_IN_VEHICLE`] = Config.WeaponClasses['SUFFOCATING'],
    [`WEAPON_EXHAUSTION`] = Config.WeaponClasses['SUFFOCATING'],
    [`WEAPON_BZGAS`] = Config.WeaponClasses['SUFFOCATING'],
    [`WEAPON_SMOKEGRENADE`] = Config.WeaponClasses['SUFFOCATING'],
}


Config.DamageRigorousness = 10 -- Amount of hp on a hit before damages gets applied

Config.Wounds = { -- These are major/critical injuries
    ["abrasion"] = {
        name = "abrasion",
        causes = { 
            [Config.WeaponClasses['OTHER']] = true,
            [Config.WeaponClasses['WILDLIFE']] = true,
        },
        bleeding = 0,
        pain = 0.5,
        reopeningTime = 60, -- base time in seconds before wound can reopen and then multiples by the bandage modifier
    },

    ["avulsion"] = {
        name = "avulsion",
        causes = { 
            [Config.WeaponClasses['EXPLOSIVE']] = true,
            [Config.WeaponClasses['WILDLIFE']] = true,
            [Config.WeaponClasses['CUTTING']] = true,
        },
        bleeding = 0.05,
        pain = 1.0,
        reopeningTime = 60, -- base time in seconds before wound can reopen and then multiples by the bandage modifier
    },

    ["contusion"] = {
        name = "contusion",
        causes = { 
            [Config.WeaponClasses['OTHER']] = true,
            [Config.WeaponClasses['LIGHT_IMPACT']] = true,
        },
        bleeding = 0,
        pain = 1.0,
        reopeningTime = 60, -- base time in seconds before wound can reopen and then multiples by the bandage modifier
    },

    ["crush"] = {
        name = "crush",
        causes = { 
            [Config.WeaponClasses['HEAVY_IMPACT']] = true,
        },
        bleeding = 0.08,
        pain = 2.0,
        causeLimping = 1, -- Will only cause limping if the legs are damaged
        causeFracture = 1,
        reopeningTime = 60, -- base time in seconds before wound can reopen and then multiples by the bandage modifier
        causeStaggering = 50, -- 100 = 100% chance
    },

    ["cut"] = {
        name = "cut",
        causes = { 
            [Config.WeaponClasses['OTHER']] = true,
            [Config.WeaponClasses['EXPLOSIVE']] = true,
            [Config.WeaponClasses['CUTTING']] = true,
        },
        bleeding = 0.05,
        pain = 0.5,
        reopeningTime = 60, -- base time in seconds before wound can reopen and then multiples by the bandage modifier
    },

    ["laceration"] = {
        name = "laceration",
        causes = { 
            [Config.WeaponClasses['HEAVY_IMPACT']] = true,
            [Config.WeaponClasses['LIGHT_IMPACT']] = true,
        },
        bleeding = 0.05,
        pain = 2.0,
        reopeningTime = 160, -- base time in seconds before wound can reopen and then multiples by the bandage modifier
    },

    ["lowvelocitywound"] = {
        name = "lowvelocitywound",
        causes = { 
            [Config.WeaponClasses['SMALL_CALIBER']] = true,
        },
        bleeding = 0.1,
        pain = 3.0,
        causeLimping = 1, -- Will only cause limping if the legs are damaged
        reopeningTime = 60, -- base time in seconds before wound can reopen and then multiples by the bandage modifier
        causeStaggering = 20, -- 100 = 100% chance
    },

    ["mediumvelocitywound"] = {
        name = "mediumvelocitywound",
        causes = { 
            [Config.WeaponClasses['MEDIUM_CALIBER']] = true,
        },
        bleeding = 0.5,
        pain = 3.0,
        causeLimping = 1, -- Will only cause limping if the legs are damaged
        reopeningTime = 60, -- base time in seconds before wound can reopen and then multiples by the bandage modifier
        causeStaggering = 20, -- 100 = 100% chance
    },

    ["highvelocitywound"] = {
        name = "highvelocitywound",
        causes = { 
            [Config.WeaponClasses['HIGH_CALIBER']] = true,
        },
        bleeding = 0.7,
        pain = 3.0,
        causeLimping = 1,
        reopeningTime = 60, -- base time in seconds before wound can reopen and then multiples by the bandage modifier
        causeStaggering = 20, -- 100 = 100% chance
    },

    ["velocitywound"] = {
        name = "velocitywound",
        causes = { 
            [Config.WeaponClasses['EXPLOSIVE']] = true,
            [Config.WeaponClasses['SHOTGUN']] = true,
        },
        bleeding = 0.3,
        pain = 3.0,
        causeLimping = 1, -- Will only cause limping if the legs are damaged
        reopeningTime = 60, -- base time in seconds before wound can reopen and then multiples by the bandage modifier
        causeStaggering = 20, -- 100 = 100% chance
    },

    ["puncturewound"] = {
        name = "puncturewound",
        causes = { 
            [Config.WeaponClasses['CUTTING']] = true,
            [Config.WeaponClasses['EXPLOSIVE']] = true,
        },
        bleeding = 0.3,
        pain = 1.0,
        causeLimping = 1, -- Will only cause limping if the legs are damaged
        reopeningTime = 60, -- base time in seconds before wound can reopen and then multiples by the bandage modifier
        causeStaggering = 50, -- 100 = 100% chance
    },

    ["burn"] = {
        name = "burn",
        causes = { 
            [Config.WeaponClasses['FIRE']] = true,
        },
        bleeding = 0,
        pain = 2.0,
        bodyTemp = 0.9,
        reopeningTime = 60, -- base time in seconds before wound can reopen and then multiples by the bandage modifier
    },
}

Config.MinorWounds = { -- These are minor wounds that might happen during soft collisions, falling over etc, the script will randomly pick one of the following wounds and apply them to the players body part
    ["abrasion"] = {
        name = "abrasion",
        bleeding = 0,
        pain = 1.0,
        reopeningTime = 60, -- base time in seconds before wound can reopen and then multiples by the bandage modifier
    },

    ["contusion"] = {
        name = "contusion",
        bleeding = 0,
        pain = 1.0,
        reopeningTime = 60, -- base time in seconds before wound can reopen and then multiples by the bandage modifier
    },

    -- ["laceration"] = {
    --     name = "laceration",
    --     bleeding = 0.2,
    --     pain = 2.2,
    --     reopeningTime = 160, -- base time in seconds before wound can reopen and then multiples by the bandage modifier
    -- },
}


Config.BandageModifier = {
    ["Dressing"] = {effectivenessModifiers = {["abrasion"] = 0.7, ["avulsion"] = 0.8, ["contusion"] = 1.0, ["crush"] = 0.9, ["cut"] = 0.9, ["laceration"] = 0.1, ["velocitywound"] = 0.5, ["lowvelocitywound"] = 0.5, ["mediumvelocitywound"] = 0.5, ["highvelocitywound"] = 0.5, ["puncturewound"] = 0.7, ["burn"] = 0.7 }},
    ["Elastic"] = {effectivenessModifiers = {["abrasion"] = 0.7, ["avulsion"] = 0.6, ["contusion"] = 1.0, ["crush"] = 0.7, ["cut"] = 0.7, ["laceration"] = 0.7, ["velocitywound"] = 0.6, ["lowvelocitywound"] = 0.5, ["mediumvelocitywound"] = 0.5, ["highvelocitywound"] = 0.5, ["puncturewound"] = 0.6, ["burn"] = 0.9 }},
    ["QuickClot"] = {effectivenessModifiers = {["abrasion"] = 0.85, ["avulsion"] = 0.8, ["contusion"] = 1.0, ["crush"] = 0.6, ["cut"] = 0.6, ["laceration"] = 0.8, ["velocitywound"] = 0.8, ["lowvelocitywound"] = 0.5, ["mediumvelocitywound"] = 0.5, ["highvelocitywound"] = 0.5, ["puncturewound"] = 0.7, ["burn"] = 0.4 }},
    ["Packing"] = {effectivenessModifiers = {["abrasion"] = 0.7, ["avulsion"] = 0.6, ["contusion"] = 1.0, ["crush"] = 0.7, ["cut"] = 0.7, ["laceration"] = 0.7, ["velocitywound"] = 0.6, ["lowvelocitywound"] = 0.5, ["mediumvelocitywound"] = 0.5, ["highvelocitywound"] = 0.5, ["puncturewound"] = 0.7, ["burn"] = 0.4 }},
}
