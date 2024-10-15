print('loading config.lua')
Config = {}

-- DAMAGE SYSTEM
Config.Framework = 'qb' -- Set this to your framework. 'qb' or 'esx'
Config.b2060 = true -- Set this to true if you are using server version 2060 or above, otherwise set it to false
Config.b2545 = true -- Set this to tru if you are using server version 2545 or above, otherwise set it to false
Config.startDamageTimer = 5000 -- Time in ms before the player damages gets applied when loading the chracters
Config.UseRadialProgressBar = false -- Use the radial progress bar instead of the default one
Config.UseOxNotif = true -- Set this to false if you want to use the default framework notificatins
Config.UsedInventory = '' -- qb, esx, ox, qs or empty(will use default inventory for that framework)

Config.webHook = ''
Config.webHookName = 'OSP Development - Ambulance' -- Name of the WebHook bot
Config.webHookLogo = 'https://cdn.discordapp.com/attachments/1102704629025886360/1227748671211180062/image.png?ex=6629890d&is=6617140d&hm=60043a8694fb72acc6cd4b1a7f21194d6dfc5df1ce2c79b34545ab358a3bf8c6&' -- Logo of the WebHook bot

Config.UseTarget = false -- Set to false if you don't want to use targetting at all and instead use drawtext
Config.UseOxTarget = false -- Set to false if you don't want to use ox_target
Config.TargetName = 'qb-target' -- The name of the target resource (only needed if you use qb-target or qtarget)
Config.Dispatch = 'default' -- Usable dispatch inputs: 'default', 'ps', 'other'
Config.UseXsound = false -- If set to false you'll use native audio, which is to be recommended to everyone who's got it working. 


Config.OpenKey = 'o' -- The default key to open the damage menu
Config.SkellyKey = 'k' -- The default key to open the skelly overview
Config.LockMedicalMenu = false -- Set to true if you want to lock the medical menu to only be opened by EMS

Config.ServerDelay = 100 -- How many ms the server is behind by. Recommended to keep above 100ms. Should say in your server console by how far behind your server is.
Config.Debug = false -- Enable or disable debug mode to investigate issues with the script

Config.CustomDeathScreen = false -- Enable of disable a customised death timer screen, keep at false if you don't know what you are doing
Config.PopUpSkelly = true

Config.AmbulanceJobs = {
    'ambulance',
    'ambulance2',
}

Config.InteractionDict = 'anim@heists@narcotics@funding@gang_idle'
Config.InteractionAnim = 'gang_chatting_idle01'

Config.JobBlips = true -- Whether or not ambulance personel can see eachother on the map.
Config.MinimalDoctors = 3 -- How many players with the ambulance job to prevent the hospital check-in system from being used
Config.DocCooldown = 1 -- Cooldown between doctor calls allowed, in minutes
Config.AIHealTimer = 10 -- How long it will take to be healed after checking in, in seconds
Config.WipeInventoryOnRespawn = true -- Enable or disable removing all the players items when they respawn at the hospital
Config.ExcludeItems = {'iphone', 'anotheritem'}
Config.Helicopter = "polmav" -- Helicopter model that players with the ambulance job can use
Config.BillCost = 2000 -- Price that players are charged for using the hospital check-in system
Config.LastStandTime = 120 -- How long before the player is percived as medically dead (in seconds)
Config.RespawnTime = 120 -- How long before the player can respawn (in seconds)
Config.PropDespawnTimer = 360*1000 -- How long before the ecg prop despawns after being placed in ms
Config.SavePlayerDataTimer = 60*1000 -- How often the player data should be saved in ms (the lower the more accurate the data is saved but the more performance impact) (The data is sent to the server so that the player data is saved when the player quits)
Config.AntiCombatLogLoop = 200 -- How often the anti combat log loop should run in ms (lower is better but has a higher performance impact)
Config.DeadBlipDelay = 360 -- How long the dead blip should be visible on the map in ms, with each tick of this reducing the transpaerncy of the blip 250 - 0
Config.AutomaticAmbulanceAlert = false -- Enable or disable the automatic ambulance alert when a player is downed
Config.inLastStandHealth = 150 -- The health the player should have when they are in last stand
Config.DeathHealth = 200 -- The health the player should have when they are dead
Config.XrayScreenTimeout = 10*1000 -- How long before the screen automatically shuts off after an xray

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
Config.ReviveKitTime = 5000

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


Config.Medication = {
    {
        itemName = 'tourniquet',
        type = 'tourniquet',
        anim = {
            name = 'gang_chatting_idle01',
            dict = 'anim@heists@narcotics@funding@gang_idle',
        },
        lang = lang.progress.applying_tourniquet,
        langUsed = lang.update1.applied_tourniquet,
        buttonLang = lang.buttons.apply_tourniquet,
        buttonLangRemove = lang.buttons.remove_tourniquet,
        time = 3000,
        pain = 3.0,
    },
    {
        itemName = 'field_dressing',
        type = 'bandage',
        effectivenessModifiers = {["abrasion"] = 0.7, ["avulsion"] = 0.8, ["contusion"] = 1.0, ["crush"] = 0.9, ["cut"] = 0.9, ["laceration"] = 0.1, ["velocitywound"] = 0.5, ["lowvelocitywound"] = 0.5, ["mediumvelocitywound"] = 0.5, ["highvelocitywound"] = 0.5, ["puncturewound"] = 0.7, ["burn"] = 0.7},
        anim = {
            name = 'gang_chatting_idle01',
            dict = 'anim@heists@narcotics@funding@gang_idle',
        },
        lang = lang.progress.applying_field_dressing,
        langUsed = lang.vitals.applied_field_dressing,
        buttonLang = lang.buttons.apply_field_dressing,
        time = 5000,
        removeItem = true,
    },
    {
        itemName = 'elastic_bandage',
        type = 'bandage',
        effectivenessModifiers = {["abrasion"] = 0.7, ["avulsion"] = 0.6, ["contusion"] = 1.0, ["crush"] = 0.7, ["cut"] = 0.7, ["laceration"] = 0.7, ["velocitywound"] = 0.6, ["lowvelocitywound"] = 0.5, ["mediumvelocitywound"] = 0.5, ["highvelocitywound"] = 0.5, ["puncturewound"] = 0.6, ["burn"] = 0.9 },
        anim = {
            name = 'gang_chatting_idle01',
            dict = 'anim@heists@narcotics@funding@gang_idle',
        },
        lang = lang.progress.applying_elastic_bandage,
        langUsed = lang.vitals.applied_elastic_bandage,
        buttonLang = lang.buttons.apply_elastic_bandage,
        time = 9000,
        removeItem = true,
    },
    {
        itemName = 'quick_clot',
        type = 'bandage',
        effectivenessModifiers = {["abrasion"] = 0.85, ["avulsion"] = 0.8, ["contusion"] = 1.0, ["crush"] = 0.6, ["cut"] = 0.6, ["laceration"] = 0.8, ["velocitywound"] = 0.8, ["lowvelocitywound"] = 0.5, ["mediumvelocitywound"] = 0.5, ["highvelocitywound"] = 0.5, ["puncturewound"] = 0.7, ["burn"] = 0.4 },
        anim = {
            name = 'gang_chatting_idle01',
            dict = 'anim@heists@narcotics@funding@gang_idle',
        },
        lang = lang.progress.applying_quick_clot,
        langUsed = lang.vitals.applied_quick_clot,
        buttonLang = lang.buttons.apply_quick_clot,
        time = 4000,
        removeItem = true,
    },
    {
        itemName = 'packing_bandage',
        type = 'bandage',
        effectivenessModifiers = {["abrasion"] = 0.7, ["avulsion"] = 0.6, ["contusion"] = 1.0, ["crush"] = 0.7, ["cut"] = 0.7, ["laceration"] = 0.7, ["velocitywound"] = 0.6, ["lowvelocitywound"] = 0.5, ["mediumvelocitywound"] = 0.5, ["highvelocitywound"] = 0.5, ["puncturewound"] = 0.7, ["burn"] = 0.4 },
        anim = {
            name = 'gang_chatting_idle01',
            dict = 'anim@heists@narcotics@funding@gang_idle',
        },
        lang = lang.progress.applying_packing_bandage,
        langUsed = lang.vitals.applied_packing_bandage,
        buttonLang = lang.buttons.apply_packing_bandage,
        time = 4000,
        removeItem = true,
    },
    {
        itemName = 'sewing_kit',
        type = 'sewing',
        anim = {
            name = 'gang_chatting_idle01',
            dict = 'anim@heists@narcotics@funding@gang_idle',
        },
        lang = lang.progress.sewing_injuries,
        langUsed = lang.progress.sewing_injuries,
        buttonLang = lang.buttons.sewing,
        time = 7000,
        removeItem = false,
    },
    {
        itemName = 'morphine',
        type = 'medication',
        anim = {
            name = 'gang_chatting_idle01',
            dict = 'anim@heists@narcotics@funding@gang_idle',
        },
        lang = lang.progress.injected_morphine,
        langUsed = lang.vitals.injected_morphine,
        buttonLang = lang.buttons.morphine,
        time = 3000,
        removeItem = true,
        painReduce = 6.0,
        maxDose = 3,
        hrDecrease = 30,
        hrIncrease = -10,
        onOverDose = function(self) 
            print('Player is overdosing!')
            -- Trigger the code you want to happen when a player overdoeses eg dies
        end,
    },
    {
        itemName = 'epinephrine',
        type = 'medication',
        anim = {
            name = 'gang_chatting_idle01',
            dict = 'anim@heists@narcotics@funding@gang_idle',
        },
        lang = lang.progress.injected_epinephrine,
        langUsed = lang.vitals.injected_epinephrine,
        buttonLang = lang.buttons.epinephrine,
        time = 3000,
        removeItem = true,
        painReduce = 4.0,
        maxDose = 5,
        hrDecrease = -10,
        hrIncrease = 20,
        onOverDose = function(self) 
            print('Player is overdosing')
            -- Trigger the code you want to happen when a player overdoeses eg dies
        end,
    },
    {
        itemName = 'blood250ml',
        type = 'infusion',
        anim = {
            name = 'gang_chatting_idle01',
            dict = 'anim@heists@narcotics@funding@gang_idle',
        },
        lang = lang.progress.injected_blood_pack,
        langUsed = lang.vitals.injected_blood_pack250ml,
        buttonLang = lang.buttons.blood_pack250ml,
        time = 8000,
        removeItem = true,
        volume = 250,
        injectingTime = 60*1000,
        onUse = function(self)

        end,
        onTick = function(self)
            if BodyDamage.BodyPartDamage.BloodLevel < 6 then
                local bloodbuff = (self.volume/1000)/self.injectingTime
                BodyDamage.BodyPartDamage.BloodLevel = BodyDamage.BodyPartDamage.BloodLevel + bloodbuff
            end
        end,
        onFinish = function(self)

        end,
    },
    {
        itemName = 'blood500ml',
        type = 'infusion',
        anim = {
            name = 'gang_chatting_idle01',
            dict = 'anim@heists@narcotics@funding@gang_idle',
        },
        lang = lang.progress.injected_blood_pack,
        langUsed = lang.vitals.injected_blood_pack500ml,
        buttonLang = lang.buttons.blood_pack500ml,
        time = 8000,
        removeItem = true,
        volume = 500,
        injectingTime = 120*1000,
        onUse = function(self)

        end,
        onTick = function(self)
            if BodyDamage.BodyPartDamage.BloodLevel < 6 then
                local bloodbuff = (self.volume/1000)/self.injectingTime
                BodyDamage.BodyPartDamage.BloodLevel = BodyDamage.BodyPartDamage.BloodLevel + bloodbuff
            end
        end,
        onFinish = function(self)

        end,
    },
    {
        itemName = 'saline250ml',
        type = 'infusion',
        anim = {
            name = 'gang_chatting_idle01',
            dict = 'anim@heists@narcotics@funding@gang_idle',
        },
        lang = lang.progress.injected_saline_pack,
        langUsed = lang.vitals.injected_saline_pack250ml,
        buttonLang = lang.buttons.saline_pack250ml,
        time = 8000,
        removeItem = true,
        volume = 250,
        injectingTime = 120*1000,
        onUse = function(self)

        end,
        onTick = function(self)
            if BodyDamage.BodyPartDamage.BloodLevel < 6 then
                local bloodbuff = (self.volume/1000)/self.injectingTime
                BodyDamage.BodyPartDamage.BloodLevel = BodyDamage.BodyPartDamage.BloodLevel + (bloodbuff/2)
            end
        end,
        onFinish = function(self)

        end,
    },
    {
        itemName = 'saline500ml',
        type = 'infusion',
        anim = {
            name = 'gang_chatting_idle01',
            dict = 'anim@heists@narcotics@funding@gang_idle',
        },
        lang = lang.progress.injected_saline_pack,
        langUsed = lang.vitals.injected_saline_pack500ml,
        buttonLang = lang.buttons.saline_pack500ml,
        time = 8000,
        removeItem = true,
        volume = 500,
        injectingTime = 120*1000,
        onUse = function(self)

        end,
        onTick = function(self)
            if BodyDamage.BodyPartDamage.BloodLevel < 6 then
                local bloodbuff = (self.volume/1000)/self.injectingTime
                BodyDamage.BodyPartDamage.BloodLevel = BodyDamage.BodyPartDamage.BloodLevel + (bloodbuff/2)
            end
        end,
        onFinish = function(self)

        end,
    },
    {
        itemName = 'propofol',
        type = 'infusion',
        anim = {
            name = 'gang_chatting_idle01',
            dict = 'anim@heists@narcotics@funding@gang_idle',
        },
        lang = lang.progress.injected_propofol,
        langUsed = lang.vitals.injected_propofol,
        buttonLang = lang.buttons.propofol,
        time = 1000,
        removeItem = true,
        volume = 20,
        injectingTime = 5*60*1000,
        onUse = function(self)
            DoScreenFadeOut(15000)
        end,
        onTick = function(self)
            SetPedToRagdoll(PlayerPedId(), 5000, 5000, 0, 0)
            if BodyDamage.BodyPartDamage.BloodLevel < 6 then
                BodyDamage.BodyPartDamage.BloodLevel = BodyDamage.BodyPartDamage.BloodLevel + 0.1
            end
            if BodyDamage.Pain > 0 then
                BodyDamage.Pain = BodyDamage.Pain - BodyDamage.Pain/5
            end
        end,
        onFinish = function(self)
            DoScreenFadeIn(15000)
        end,
    },


    -- Template to create a fully custom medication
    -- {
    --     itemName = 'customMedication',
    --     type = 'custom', -- A fully custom preset where you write all the code yourself. (almost)
    --     anim = {
    --         name = 'gang_chatting_idle01',
    --         dict = 'anim@heists@narcotics@funding@gang_idle',
    --     },
    --     lang = lang.progress.injected_propofol,
    --     langUsed = lang.vitals.injected_propofol,
    --     buttonLang = lang.buttons.propofol,
    --     time = 1000,
    --     removeItem = true,
    --     maxDose = 2,
    --     onOverDose = function() 
    --         print('Player is overdosing')
    --         -- Trigger the code you want to happen when a player overdoeses eg dies
    --     end,
    --     onUse = function()
    --         Citizen.CreateThread(function()
    --             DoScreenFadeOut(5000)
    --             Wait(5000)
    --             DoScreenFadeIn(5000)
    --             print('onuse')
    --         end)
    --     end,
    -- },


}



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
    ["ambulance2"] = {
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
}

Config.AuthorizedVehicles = { -- Vehicles players can use based on their ambulance job grade level
	-- Grade 0
	[0] = {
		["ambulance"] = "Ambulance",
	},
	-- Grade 1
	[1] = {
		["ambulance"] = "Ambulance",
	},
	-- Grade 2
	[2] = {
		["ambulance"] = "Ambulance",
	},
	-- Grade 3
	[3] = {
		["ambulance"] = "Ambulance",
	},
	-- Grade 4
	[4] = {
		["ambulance"] = "Ambulance",
	}
}

Config.VehicleExtras = { -- Enable/disable the vehicle extras when spawning them with the job vehicle spawner
    ["ambulance"] = { -- Model name
        ["1"] = false, -- on/off
        ["2"] = true, -- !OBS! The native checks for an inverted value, so if you want to have this extra enabled it should be false and the other way around. !OBS!
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
    ["ambulance2"] = {
        ["1"] = false,
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
    }
}

-- Items that can be purchased by the ambulance personel
Config.ItemShop = { -- The stock resets every script restart but is synced to all players
    {
        label = 'Radio',
        name = "radio",
        price = 100,
        type = "item",
    },
    {
        label = 'Flashlight',
        name = "weapon_flashlight",
        price = 100,
        type = "item",
    },
    {
        label = 'Fire Extinguisher',
        name = "weapon_fireextinguisher",
        price = 100,
        type = "item",
    },
    {
        label = 'Pager',
        name = "pager",
        price = 100,
        type = "item",
    },
    {
        label = 'ECG',
        name = "ecg",
        price = 1000,
        type = "item",
        amount = 3,
    },
    {
        label = 'Tourniquet',
        name = "tourniquet",
        price = 50,
        type = "item",
        amount = 30,
    },
    {
        label = 'Field Dressing',
        name = "field_dressing",
        price = 25,
        type = "item",
        amount = 50,
    },
    {
        label = 'Elastic Bandage',
        name = "elastic_bandage",
        price = 25,
        type = "item",
        amount = 50,
    },
    {
        label = 'Quick Clot',
        name = "quick_clot",
        price = 25,
        type = "item",
        amount = 50,
    },
    {
        label = 'Packing Bandage',
        name = "packing_bandage",
        price = 25,
        type = "item",
        amount = 50,
    },
    {
        label = 'Sewing Kit',
        name = "sewing_kit",
        price = 100,
        type = "item",
        amount = 10,
    },
    {
        label = 'Epinephrine',
        name = "epinephrine",
        price = 50,
        type = "item",
        amount = 15,
    },
    {
        label = 'Morphine',
        name = "morphine",
        price = 50,
        type = "item",
        amount = 15,
    },
    {
        label = 'Propofol',
        name = "propofol",
        price = 250,
        type = "item",
        amount = 10,
    },
    {
        label = 'Blood Pack 250ml',
        name = "blood250ml",
        price = 150,
        type = "item",
        amount = 5,
    },
    {
        label = 'Blood Pack 500ml',
        name = "blood500ml",
        price = 250,
        type = "item",
        amount = 3,
    },
    {
        label = 'Saline 250ml',
        name = "saline250ml",
        price = 75,
        type = "item",
        amount = 25,
    },
    {
        label = 'Saline 500ml',
        name = "saline500ml",
        price = 125,
        type = "item",
        amount = 25,
    },
    {
        label = 'Stretcher',
        name = "stretcher",
        price = 250,
        type = "item",
        amount = 5,
    },
    {
        label = 'Wheelchair',
        name = "wheelchair",
        price = 150,
        type = "item",
        amount = 5,
    },
    {
        label = 'Crutch',
        name = "crutch",
        price = 100,
        type = "item",
        amount = 5,
    },
    {
        label = 'IFAK',
        name = "ifak",
        price = 300,
        type = "item",
        amount = 25,
    },
    {
        label = 'Revive Kit',
        name = "revivekit",
        price = 1250,
        type = "item",
        amount = 3,
    },
    {
        label = 'Leg Splint',
        name = "legsplint",
        price = 300,
        type = "item",
        amount = 5,
    },
    {
        label = 'Leg Cast',
        name = "legcast",
        price = 300,
        type = "item",
        amount = 5,
    },
    {
        label = 'Arm Splint',
        name = "armplint",
        price = 300,
        type = "item",
        amount = 5,
    },
    {
        label = 'Arm Cast',
        name = "armcast",
        price = 300,
        type = "item",
        amount = 5,
    },
    {
        label = 'Neck Brace',
        name = "neckbrace",
        price = 300,
        type = "item",
        amount = 5,
    },
    {
        label = 'Neck Cast',
        name = "neckcast",
        price = 300,
        type = "item",
        amount = 5,
    },
}

Config.UseGarageSystem = true 

Config.Locations = {
    ["checking"] = {
	    vector3(312.2069, -593.4422, 43.0868),
    },
    ["duty"] = {
        vector3(310.3887, -597.3732, 43.2976),
    },
    ["vehicle"] = {
        vector4(294.7070, -607.2061, 43.0078, 68.8774),
        vector4(331.9502, -579.1585, 28.5665, 339.8551),
    },
    ["helicopter"] = {
        vector4(351.58, -587.45, 74.2, 160.5),
    },
    ["shop"] = {
        vector3(311.7910, -564.0659, 43.2841),
    },
    ["roof"] = {
        vector4(338.5, -583.85, 74.16, 245.5),
    },
    ["main"] = {
        vector3(332.3166, -595.6741, 43.2841),
    },
    ["stash"] = {
        vector3(308.5978, -562.2446, 43.5902),
    },
    ["beds"] = {
        -- Add the xray variables to make it an xray bed
        {coords = vector4(348.7, -579.4, 43.1971, 157.0), taken = false, xray = true, xrayMonitor = vector3(344.79, -578.14, 43.84), xrayMonitorRot = vector3(0.0,0.0,122.0), screenScale = 0.042},


        {coords = vector4(319.3530, -580.8159, 43.2039, 157.9544), taken = false, model = 1631638868},
        {coords = vector4(324.1608, -582.8101, 43.2040, 157.6627), taken = false, model = 1631638868},
        {coords = vector4(322.6, -586.9601, 43.2040, 340.9906), taken = false, model = 2117668672},
        {coords = vector4(317.6, -585.3027, 43.2040, 340.0982), taken = false, model = 2117668672},
        {coords = vector4(314.5, -584.0378, 43.2040, 340.4092), taken = false, model = 2117668672},
        {coords = vector4(311.0, -582.7598, 43.2040, 340.4864), taken = false, model = -1091386327},
        {coords = vector4(307.8, -581.4847, 43.2040, 340.6982), taken = false, model = -1091386327},
        {coords = vector4(309.1634, -577.5354, 43.2040, 157.5351), taken = false, model = -1091386327},
	    {coords = vector4(313.8121, -579.1085, 43.2040, 157.7460), taken = false, model = 2117668672},
        {coords = vector4(-247.04, 6317.95, 32.34, 134.64), taken = false, model = 2117668672},
        {coords = vector4(-255.98, 6315.67, 32.34, 313.91), taken = false, model = 2117668672},
    },
    ["jailbeds"] = {
        {coords = vector4(1761.96, 2597.74, 45.66, 270.14), taken = false, model = 2117668672},
        {coords = vector4(1761.96, 2591.51, 45.66, 269.8), taken = false, model = 2117668672},
        {coords = vector4(1771.8, 2598.02, 45.66, 89.05), taken = false, model = 2117668672},
        {coords = vector4(1771.85, 2591.85, 45.66, 91.51), taken = false, model = 2117668672},
    },
    ["stations"] = {
        {label = 'Hospital', coords = vector4(304.27, -600.33, 43.28, 272.249)},
    },

    -- Following actions only support integration for default esx
    ["boss"] = {
        -- vector3(334.7231, -594.4026, 43.2841),
    },
    ["cloakroom"] = {
        -- vector3(302.1178, -598.8913, 43.0763),
    },
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
    vector4(328.2508, -576.4911, 46.0, 34.4687),
    vector4(300.8384, -582.8441, 46.0, 32.9394)
}
Config.IncomingScreenSoundPos = {
    vector3(309.2776, -589.0244, 45.1519),
    vector3(329.5522, -579.1614, 44.6322),
    vector3(355.9286, -589.8729, 44.7986),
}
Config.IncomingScreenSoundRange = 50

-- STATIONARY ECG CONFIGURATION (ICU SCREENS)
Config.StationaryECGProp = 'v_med_cor_ceilingmonitor' -- The prop used for the stationary ECG

Config.StationaryECG = { -- IF YOU WANT MORE THAN 6 ECGS YOU NEED TO CREATE MORE GFX FILES.
    {
        coords = vector4(318.7118, -579.8219, 45.8, 344.3082),
        bedcoords = vector3(319.2666, -581.1186, 44.2040),
        name = 'ICU 1'
    },
    {
        coords = vector4(323.7489, -581.5202, 45.8, 337.8694),
        bedcoords = vector3(324.2232, -583.0401, 44.2040),
        name = 'ICU 2'
    },
    {
        coords = vector4(321.3699, -587.7664, 45.8, 163.4208),
        bedcoords = vector3(322.6256, -586.7698, 44.2130),
        name = 'ICU 3'
    },
    {
        coords = vector4(316.4125, -586.0515, 45.8, 163.2631),
        bedcoords = vector3(317.5998, -585.4157, 44.2040),
        name = 'ICU 4'
    },
    {
        coords = vector4(313.1407, -584.6058, 45.8, 162.2001),
        bedcoords = vector3(314.5409, -583.9615, 44.2040),
        name = 'ICU 5'
    },
    {
        coords = vector4(309.6808, -583.5556, 45.8, 162.3711),
        bedcoords = vector3(311.2327, -582.8145, 44.2040),
        name = 'ICU 6'
    },
    -- Some people have experienced issues with having a lot of loaded gfx files.
    -- {
    --     coords = vector4(308.3385, -582.8965, 45.8, 159.9160),
    --     bedcoords = vector3(307.7694, -581.3610, 44.2049),
    --     name = 'ICU 7'
    -- },
    -- {
    --     coords = vector4(310.4750, -576.9198, 45.8, 340.2058),
    --     bedcoords = vector3(309.2775, -577.7110, 44.2044),
    --     name = 'ICU 8'
    -- },
    -- {
    --     coords = vector4(315.0273, -578.4716, 45.8, 342.0016),
    --     bedcoords = vector3(313.8342, -579.3513, 44.2040),
    --     name = 'ICU 9'
    -- },
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


Config.Fractures = {
    {
        bone = 'NECK',
        chance = 50, -- Chance in % that a fracture is being applied when wounded
        causes = { 
            [Config.WeaponClasses['HEAVY_IMPACT']] = true,
            [Config.WeaponClasses['EXPLOSIVE']] = true,
            [Config.WeaponClasses['OTHER']] = true,
            [Config.WeaponClasses['SHOTGUN']] = true,
        },
        pain = 15.0
    }, 
    -- {
    --     bone = 'SPINE',
    --     chance = 100,
    --     causes = { 
    --         [Config.WeaponClasses['HEAVY_IMPACT']] = true,
    --         [Config.WeaponClasses['EXPLOSIVE']] = true,
    --         [Config.WeaponClasses['OTHER']] = true,
    --         [Config.WeaponClasses['SHOTGUN']] = true,
    --     },
    --     pain = 15.0
    -- },
    {
        bone = 'LARM',
        chance = 50,
        causes = { 
            [Config.WeaponClasses['HEAVY_IMPACT']] = true,
            [Config.WeaponClasses['EXPLOSIVE']] = true,
            [Config.WeaponClasses['OTHER']] = true,
            [Config.WeaponClasses['SHOTGUN']] = true,
        },
        pain = 15.0,
        lockSteering = true,
    },
    {
        bone = 'RARM',
        chance = 50,
        causes = { 
            [Config.WeaponClasses['HEAVY_IMPACT']] = true,
            [Config.WeaponClasses['EXPLOSIVE']] = true,
            [Config.WeaponClasses['OTHER']] = true,
            [Config.WeaponClasses['SHOTGUN']] = true,
        },
        pain = 15.0,
        lockSteering = true,
    },
    {
        bone = 'RLEG',
        chance = 50,
        causes = { 
            [Config.WeaponClasses['HEAVY_IMPACT']] = true,
            [Config.WeaponClasses['EXPLOSIVE']] = true,
            [Config.WeaponClasses['OTHER']] = true,
            [Config.WeaponClasses['SHOTGUN']] = true,
        },
        pain = 15.0,
        causeStaggering = true, 
    },
    {
        bone = 'LLEG',
        chance = 50,
        causes = { 
            [Config.WeaponClasses['HEAVY_IMPACT']] = true,
            [Config.WeaponClasses['EXPLOSIVE']] = true,
            [Config.WeaponClasses['OTHER']] = true,
            [Config.WeaponClasses['SHOTGUN']] = true,
        },
        pain = 15.0,
        causeStaggering = true,
    },
}


Config.UseCustomProps = false -- If enabled, the script will apply the pedvariations from the config below (The default config is intended to be used with Sinner Mod Shop medical props pack)
Config.Casts = {
    {
        type = 'splint',
        lang = lang.progress.applying_splint,
        langUsed = lang.ui.splint_applied,
        buttonLang = lang.buttons.apply_splint,
        anim = {
            name = 'gang_chatting_idle01',
            dict = 'anim@heists@narcotics@funding@gang_idle',
        },
        removeButtonLang = 'Remove Splint',
        time = 5000,
        timeInCast = 15*60*1000,
        casts = {
            {
                itemName = 'neckbrace',
                bone = 'NECK',
                pedVariationCategory = 8,
                pedVariationId = 209,
            },
            {
                itemName = 'legsplint',
                bone = 'RLEG',
                pedVariationCategory = 8,
                pedVariationId = 209,
            },
            {
                itemName = 'legsplint',
                bone = 'LLEG',
                pedVariationCategory = 8,
                pedVariationId = 209,
            },
            {
                itemName = 'armsplint',
                bone = 'RARM',
                pedVariationCategory = 8,
                pedVariationId = 209,
            },
            {
                itemName = 'armsplint',
                bone = 'LARM',
                pedVariationCategory = 8,
                pedVariationId = 209,
            },
        }
    },
    {
        type = 'cast',
        lang = lang.progress.applying_cast,
        langUsed = lang.ui.cast_applied,
        buttonLang = lang.buttons.apply_cast,
        anim = {
            name = 'gang_chatting_idle01',
            dict = 'anim@heists@narcotics@funding@gang_idle',
        },
        time = 5000,
        timeInCast = 15*60*1000,
        casts = {
            {
                itemName = 'neckcast',
                bone = 'NECK',
                pedVariationCategory = 8,
                pedVariationId = 209,
            },
            {
                itemName = 'legcast',
                bone = 'RLEG',
                pedVariationCategory = 8,
                pedVariationId = 209,
            },
            {
                itemName = 'legcast',
                bone = 'LLEG',
                pedVariationCategory = 8,
                pedVariationId = 209,
            },
            {
                itemName = 'armcast',
                bone = 'RARM',
                pedVariationCategory = 8,
                pedVariationId = 209,
            },
            {
                itemName = 'armcast',
                bone = 'LARM',
                pedVariationCategory = 8,
                pedVariationId = 209,
            },
        }
    },

}