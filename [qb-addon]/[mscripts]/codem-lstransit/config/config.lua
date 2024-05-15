Config                       = {}

Config.Framework             = 'qb'      -- esx, oldesx, qb, oldqb
Config.SQL                   = "oxmysql" -- oxmysql, ghmattimysql, mysql-async

Config.ExampleProfilePicture =
"https://cdn.discordapp.com/attachments/983471660684423240/1147567519712940044/example-pp.png"

Config.InteractionHandler    = 'drawtext' --  qb-target, drawtext,ox-target

Config.CurrencyUnit          = '$'        --    € $ £ ¥ ₺

Config.CodemTextUi           = false      -- true or false

Config.PassengersText = {
    drawtext = true,
    text = 'Press [~g~E~s~] to pick up passengers.',

    codemtextui = false,
    codemtext = 'Press to pick up passengers.',
    codemthema = 'thema-6',

    distance = 10.0,
    freezetime = 3500,
}

Config.AddLevelCommands    = 'addlevelbus'
Config.RemoveLevelCommands = 'removelevelbus'
Config.ResetJobPlayer      = 'resetjobbus'
Config.NoCarTypebool      = true        -- true = if you don't have a vehicle, you can't start the job || false = if you don't have a vehicle, you can start the jobFinishCoords
Config.NoCarTime = 1                    -- If you type 1, if the time in the busRouteSettings section is 30, 30 minutes || if you type 2, 15 minutes || if you type 3, 10 minutes || if you type 4, 5 minutes || if you type 5, 1 minute || briefly divides the time by the number you type.

-- ██████╗░██████╗░░█████╗░░██╗░░░░░░░██╗███╗░░░███╗░█████╗░██████╗░██╗░░██╗███████╗██████╗░
-- ██╔══██╗██╔══██╗██╔══██╗░██║░░██╗░░██║████╗░████║██╔══██╗██╔══██╗██║░██╔╝██╔════╝██╔══██╗
-- ██║░░██║██████╔╝███████║░╚██╗████╗██╔╝██╔████╔██║███████║██████╔╝█████═╝░█████╗░░██████╔╝
-- ██║░░██║██╔══██╗██╔══██║░░████╔═████║░██║╚██╔╝██║██╔══██║██╔══██╗██╔═██╗░██╔══╝░░██╔══██╗
-- ██████╔╝██║░░██║██║░░██║░░╚██╔╝░╚██╔╝░██║░╚═╝░██║██║░░██║██║░░██║██║░╚██╗███████╗██║░░██║
-- ╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝
Config.DrawMarkerSettings  = {
    ['finishCoordsDrawMarker'] = true,
    ['deleteVehicleDrawMarker'] = true
}
-- ██╗░░░██╗███████╗██╗░░██╗██╗░█████╗░██╗░░░░░███████╗██╗░░██╗███████╗██╗░░░██╗
-- ██║░░░██║██╔════╝██║░░██║██║██╔══██╗██║░░░░░██╔════╝██║░██╔╝██╔════╝╚██╗░██╔╝
-- ╚██╗░██╔╝█████╗░░███████║██║██║░░╚═╝██║░░░░░█████╗░░█████═╝░█████╗░░░╚████╔╝░
-- ░╚████╔╝░██╔══╝░░██╔══██║██║██║░░██╗██║░░░░░██╔══╝░░██╔═██╗░██╔══╝░░░░╚██╔╝░░
-- ░░╚██╔╝░░███████╗██║░░██║██║╚█████╔╝███████╗███████╗██║░╚██╗███████╗░░░██║░░░
-- ░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═╝░╚════╝░╚══════╝╚══════╝╚═╝░░╚═╝╚══════╝░░░╚═╝░░░

Config.Vehiclekey          = true
Config.VehicleSystem       = "qb-vehiclekeys" -- cd_garage / qs-vehiclekeys / wasabi-carlock / qb-vehiclekeys
Config.Removekeys          = true
Config.RemoveVehicleSystem = "qb-vehiclekeys"                                             -- cd_garage / qs-vehiclekeys / wasabi-carlock / qb-vehiclekeys

Config.GiveVehicleKey = function(plate, model, vehicle) -- you can change vehiclekeys export if you use another vehicle key system
    if Config.Vehiclekey then
        if Config.VehicleSystem == 'cd_garage' then
            TriggerEvent('cd_garage:AddKeys', exports['cd_garage']:GetPlate(vehicle))
        elseif Config.VehicleSystem == 'qs-vehiclekeys' then
            model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            exports['qs-vehiclekeys']:GiveKeys(plate, model, true)
        elseif Config.VehicleSystem == 'wasabi-carlock' then
            exports.wasabi_carlock:GiveKey(plate)
        elseif Config.VehicleSystem == 'qb-vehiclekeys' then
            TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
        end
    end
end
Config.RemoveVehiclekey = function(plate, model, vehicle)
    if Config.Removekeys then
        if Config.RemoveVehicleSystem == 'cd_garage' then
            TriggerServerEvent('cd_garage:RemovePersistentVehicles', exports['cd_garage']:GetPlate(vehicle))
        elseif Config.RemoveVehicleSystem == 'qs-vehiclekeys' then
            model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            exports['qs-vehiclekeys']:RemoveKeys(plate, model)
        elseif Config.RemoveVehicleSystem == 'wasabi-carlock' then
            exports.wasabi_carlock:RemoveKey(plate)
        elseif Config.RemoveVehicleSystem == 'qb-vehiclekeys' then
            TriggerServerEvent('qb-vehiclekeys:client:RemoveKeys', plate)
        end
    end
end


-- ███████╗██╗░░░██╗███████╗██╗░░░░░  ░██████╗██╗░░░██╗░██████╗████████╗███████╗███╗░░░███╗
-- ██╔════╝██║░░░██║██╔════╝██║░░░░░  ██╔════╝╚██╗░██╔╝██╔════╝╚══██╔══╝██╔════╝████╗░████║
-- █████╗░░██║░░░██║█████╗░░██║░░░░░  ╚█████╗░░╚████╔╝░╚█████╗░░░░██║░░░█████╗░░██╔████╔██║
-- ██╔══╝░░██║░░░██║██╔══╝░░██║░░░░░  ░╚═══██╗░░╚██╔╝░░░╚═══██╗░░░██║░░░██╔══╝░░██║╚██╔╝██║
-- ██║░░░░░╚██████╔╝███████╗███████╗  ██████╔╝░░░██║░░░██████╔╝░░░██║░░░███████╗██║░╚═╝░██║
-- ╚═╝░░░░░░╚═════╝░╚══════╝╚══════╝  ╚═════╝░░░░╚═╝░░░╚═════╝░░░░╚═╝░░░╚══════╝╚═╝░░░░░╚═╝

-- Config.UseLegacyFuel  = GetResourceState("LegacyFuel") ~= "missing" -- true enabled -- false disabled
Config.FuelSystem = "cdn-fuel"                                -- LegacyFuel / x-fuel

Config.SetVehicleFuel = function(vehicle, fuel_level) -- you can change LegacyFuel export if you use another fuel system
    if Config.FuelSystem == 'cdn-fuel' then
        return exports["cdn-fuel"]:SetFuel(vehicle, fuel_level)
    elseif Config.FuelSystem == 'x-fuel' then
        return exports["x-fuel"]:SetFuel(vehicle, fuel_level)
    else
        return SetVehicleFuelLevel(vehicle, fuel_level + 0.0)
    end
end


-- ██████╗░██╗░░░██╗░██████╗░░░░░██╗░█████╗░██████╗░
-- ██╔══██╗██║░░░██║██╔════╝░░░░░██║██╔══██╗██╔══██╗
-- ██████╦╝██║░░░██║╚█████╗░░░░░░██║██║░░██║██████╦╝
-- ██╔══██╗██║░░░██║░╚═══██╗██╗░░██║██║░░██║██╔══██╗
-- ██████╦╝╚██████╔╝██████╔╝╚█████╔╝╚█████╔╝██████╦╝
-- ╚═════╝░░╚═════╝░╚═════╝░░╚════╝░░╚════╝░╚═════╝░
Config.BusjobSettings = {

    ['coords'] = {
        ['intreactionCoords'] = vector3(438.26, -624.45, 28.71),
        ['ped'] = true,
        ['pedCoords'] = vector3(438.26, -624.45, 28.71),
        ['pedHeading'] = 85.55,
        ['pedHash'] = 0xF0EC56E2,
    },
    ['blip'] = {
        show = true,
        blipName = 'Bus Job',
        blipType = 631,
        blipColor = 2,
        blipScale = 0.55
    },

    ['job'] = 'all', -- if you want to use only one job, you can change it to the job name. example: 'police'

    ['busSpawnCoords'] = {
        vector4(457.75, -642.76, 28.47, 179.54),
        vector4(470.85, -584.54, 28.49, 179.54),
    },

    ['jobFinishCoords'] = vector3(457.75, -642.76, 28.47),

    ['jobDeliverTheVehicleCoords'] = vector3(470.85, -584.54, 28.49),
    ['categories'] = {
        { name = "main",        label = "LST MAIN" },
        { name = "routes",      label = "ROUTES" },
        { name = "leaderboard", label = "LEADERBOARD" },
        { name = "profile",     label = "PROFILE" }
    },
    ['dailyMission'] = {

        {
            name = 'transportpassenger',
            header = 'Transport 250 citizen',
            label = 'Transport at least 250 citizen through the Los Santos',
            count = 250,
            xp = 2500,
        },
        {
            name = 'completeoneroute',
            header = 'Complete One Route',
            label = 'Complete at least one route on thee LS Transit.',
            xp = 1000,
            count = 1,
        },
        {
            name = 'earninoneroute',
            header = 'Earn $2000 in routes',
            label = 'Earn at least $2000 in routes.',
            count = 2000,
            xp = 1500,
        },

    },

    ['busJobVehicle'] = {
        { vehiclename = 'rentalbus', label = 'Rental Bus', level = 1 },
        { vehiclename = 'tourbus',   label = 'Tour Bus',   level = 10 },
        { vehiclename = 'coach',     label = 'Coach',      level = 20 },
        { vehiclename = 'airbus',    label = 'Air Bus',    level = 30 },
        { vehiclename = 'bus',       label = 'Bus',        level = 40 },
    },
    ['busRouteSettings'] = {
        { name = 'lstransit',     label = 'LS Transit',      xp = 2500, abbreviation = 'MRR1', level = 1,  time = 12 },
        { name = 'lstransitlsa',  label = 'LS Transit LSA',  xp = 2500, abbreviation = 'LSA1', level = 10, time = 12 },
        { name = 'lstransitssa',  label = 'LS Transit SSA',  xp = 3000, abbreviation = 'SSA1', level = 15, time = 14 },
        { name = 'lstransitvin',  label = 'LS Transit VIN1', xp = 3000, abbreviation = 'VIN1', level = 25, time = 16 },
        { name = 'lstransitvbp',  label = 'LS Transit VBP',  xp = 3000, abbreviation = 'VBP1', level = 30, time = 24 },
        { name = 'lstransitexpp', label = 'LS Transit EXPP', xp = 3000, abbreviation = 'EXPP', level = 40, time = 30 },
        { name = 'lstransitexps', label = 'LS Transit EXPS', xp = 3000, abbreviation = 'EXPS', level = 50, time = 24 },

    },

    ['busStops'] = {
        ['lstransit'] = {
            {
                stopID = 1,
                coords = vector3(304.08, -766.26, 29.31),
                heading = 262.73,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 2,
                coords = vector3(1205.74, -684.87, 60.67),
                heading = 104.87,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 3,
                coords = vector3(1214.22, -417.51, 67.64),
                heading = 84.46,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 4,
                coords = vector3(893.91, -104.28, 78.75),
                heading = 147.98,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 5,
                coords = vector3(583.33, 73.57, 94.11),
                heading = 157.32,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 6,
                coords = vector3(438.83, 125.72, 100.04),
                heading = 160.25,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 7,
                coords = vector3(291.61, 179.33, 104.29),
                heading = 164.16,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 8,
                coords = vector3(75.94, -127.18, 55.86),
                heading = 248.75,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 9,
                coords = vector3(-109.38, -608.41, 36.28),
                heading = 248.75,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },

            {
                stopID = 10,
                coords = vector3(81.36, -802.4, 31.52),
                heading = 335.12,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 11,
                coords = vector3(413.02, -753.84, 29.29),
                heading = 88.13,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },

        },
        ['lstransitssa'] = {
            {
                stopID = 1,
                coords = vector3(493.44, -856.64, 25.1),
                heading = 276.29,
                npcCount = math.random(1, 5),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 2,
                coords = vector3(391.33, -995.32, 29.42),
                heading = 266.78,
                npcCount = math.random(1, 5),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}

            },
            {
                stopID = 3,
                coords = vector3(257.15, -1120.04, 29.36),
                heading = 179.25,
                npcCount = math.random(1, 5),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 4,
                coords = vector3(-0.69, -1123.19, 28.05),
                heading = 182.66,
                npcCount = math.random(1, 5),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 5,
                coords = vector3(-117.53, -1266.25, 29.3),
                heading = 267.8,
                npcCount = math.random(1, 5),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 6,
                coords = vector3(100.3, -1383.5, 29.29),
                heading = 335.57,
                npcCount = math.random(1, 5),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 7,
                coords = vector3(27.45, -1520.81, 29.29),
                heading = 226.43,
                npcCount = math.random(1, 5),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 8,
                coords = vector3(-4.49, -1647.25, 29.16),
                heading = 321.39,
                npcCount = math.random(1, 5),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 9,
                coords = vector3(18.84, -1878.34, 23.02),
                heading = 317.26,
                npcCount = math.random(1, 5),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 10,
                coords = vector3(159.93, -1798.04, 29.08),
                heading = 59.13,
                npcCount = math.random(1, 5),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 11,
                coords = vector3(502.74, -1619.99, 29.33),
                heading = 57.73,
                npcCount = math.random(1, 5),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 12,
                coords = vector3(508.89, -858.87, 25.14),
                heading = 75.97,
                npcCount = math.random(1, 5),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },


        },
        ['lstransitvbp'] = {
            {
                stopID = 1,
                coords = vector3(304.81, -764.42, 29.31),
                heading = 238.26,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 2,
                coords = vector3(275.72, -592.36, 43.26),
                heading = 72.53,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 3,
                coords = vector3(252.97, -213.48, 54.02),
                heading = 155.37,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 4,
                coords = vector3(35.3, -707.44, 44.22),
                heading = 245.72,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 5,
                coords = vector3(-148.61, -890.85, 29.32),
                heading = 163.36,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 6,
                coords = vector3(-462.06, -825.23, 30.54),
                heading = 184.56,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 7,
                coords = vector3(-724.35, -1073.64, 12.73),
                heading = 209.2,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 8,
                coords = vector3(-906.91, -867.23, 15.42),
                heading = 138.79,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 9,
                coords = vector3(-1182.0, -955.85, 3.74),
                heading = 211.7,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 10,
                coords = vector3(-1308.13, -1137.46, 6.04),
                heading = 272.93,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 11,
                coords = vector3(-1170.11, -1474.24, 4.38),
                heading = 305.97,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 12,
                coords = vector3(-1024.95, -1282.76, 6.23),
                heading = 42.9,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 13,
                coords = vector3(-689.11, -1255.4, 10.63),
                heading = 298.42,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 14,
                coords = vector3(-145.55, -2102.55, 25.6),
                heading = 20.8,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 15,
                coords = vector3(263.05, -2122.03, 16.27),
                heading = 321.93,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 16,
                coords = vector3(703.66, -2073.71, 29.28),
                heading = 348.48,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 17,
                coords = vector3(822.98, -1483.35, 27.77),
                heading = 119.5,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 18,
                coords = vector3(796.38, -959.2, 25.97),
                heading = 92.94,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 19,
                coords = vector3(435.19, -348.55, 47.4),
                heading = 238.02,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 20,
                coords = vector3(240.64, -592.96, 42.93),
                heading = 248.85,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 21,
                coords = vector3(216.21, -853.55, 30.34),
                heading = 348.26,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            }

        },
        ['lstransitvin'] = {
            {
                stopID = 1,
                coords = vector3(316.27, -646.12, 29.29),
                heading = 158.95,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 2,
                coords = vector3(-108.34, -606.92, 36.27),
                heading = 248.57,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 3,
                coords = vector3(-302.74, -617.99, 33.56),
                heading = 212.7,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 4,
                coords = vector3(-751.34, -604.09, 30.22),
                heading = 268.56,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 5,
                coords = vector3(-928.86, -460.86, 37.28),
                heading = 118.16,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 6,
                coords = vector3(-794.31, -131.11, 38.04),
                heading = 31.15,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 7,
                coords = vector3(-705.15, 225.58, 80.0),
                heading = 35.48,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 8,
                coords = vector3(-775.2, 295.59, 85.75),
                heading = 188.77,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 9,
                coords = vector3(-973.2, 276.67, 68.76),
                heading = 170.76,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 10,
                coords = vector3(-1033.2, 107.41, 52.41),
                heading = 295.45,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 11,
                coords = vector3(-919.61, -77.21, 38.17),
                heading = 303.75,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 12,
                coords = vector3(-682.59, -377.46, 34.27),
                heading = 350.46,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 13,
                coords = vector3(-245.88, -583.03, 34.36),
                heading = 255.3,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 14,
                coords = vector3(223.2, -856.03, 30.17),
                heading = 334.58,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 15,
                coords = vector3(332.45, -773.26, 29.27),
                heading = 71.22,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            }

        },
        ['lstransitlsa'] = {
            {
                stopID = 1,
                coords = vector3(305.39, -763.53, 29.31),
                heading = 254.24,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 2,
                coords = vector3(115.84, -782.47, 31.4),
                heading = 163.43,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 3,
                coords = vector3(-247.95, -713.55, 33.55),
                heading = 248.31,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 4,
                coords = vector3(-250.39, -885.66, 30.65),
                heading = 345.99,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 5,
                coords = vector3(-291.14, -1385.52, 31.31),
                heading = 267.91,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 6,
                coords = vector3(-1041.17, -2721.4, 13.76),
                heading = 334.41,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 7,
                coords = vector3(-774.57, -2488.63, 14.11),
                heading = 68.0,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 8,
                coords = vector3(-751.78, -2290.91, 13.04),
                heading = 133.94,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 9,
                coords = vector3(-565.69, -1233.62, 15.24),
                heading = 57.74,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 10,
                coords = vector3(-263.06, -1329.71, 31.31),
                heading = 84.0,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 11,
                coords = vector3(-214.15, -1010.67, 29.3),
                heading = 73.8,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 12,
                coords = vector3(69.85, -1002.51, 29.36),
                heading = 324.48,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 13,
                coords = vector3(332.62, -774.55, 29.27),
                heading = 74.29,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            }

        },
        ['lstransitexpp'] = {

            {
                stopID = 1,
                coords = vector3(305.13, -765.13, 29.31),
                heading = 252.74,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 2,
                coords = vector3(115.83, -782.39, 31.4),
                heading = 171.54,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 3,
                coords = vector3(-551.89, -646.15, 33.23),
                heading = 178.16,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 4,
                coords = vector3(-1113.46, -770.43, 19.06),
                heading = 222.92,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 5,
                coords = vector3(-1506.53, -679.12, 28.17),
                heading = 148.18,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 6,
                coords = vector3(-1666.14, -539.88, 35.19),
                heading = 149.2,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 7,
                coords = vector3(-2114.48, -350.19, 13.06),
                heading = 155.26,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 8,
                coords = vector3(-2975.38, 435.2, 15.2),
                heading = 87.64,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 9,
                coords = vector3(-2214.94, 4278.44, 47.52),
                heading = 61.72,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 10,
                coords = vector3(-783.72, 5541.14, 33.56),
                heading = 110.95,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 11,
                coords = vector3(-695.41, 5824.33, 17.03),
                heading = 64.55,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 12,
                coords = vector3(-358.62, 6163.37, 31.23),
                heading = 43.71,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 13,
                coords = vector3(-50.58, 6470.99, 31.39),
                heading = 52.02,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 14,
                coords = vector3(170.37, 6627.67, 31.73),
                heading = 218.6,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 15,
                coords = vector3(-122.59, 6270.08, 31.15),
                heading = 225.73,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 16,
                coords = vector3(-395.64, 5992.64, 31.77),
                heading = 218.56,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 17,
                coords = vector3(-928.57, 5432.67, 37.44),
                heading = 198.12,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 18,
                coords = vector3(-2235.32, 4311.68, 47.97),
                heading = 233.2,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 19,
                coords = vector3(-2864.31, 2198.02, 33.83),
                heading = 205.13,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 20,
                coords = vector3(-3125.03, 1127.54, 20.59),
                heading = 269.4,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 21,
                coords = vector3(-3041.17, 614.83, 7.48),
                heading = 292.25,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 22,
                coords = vector3(-2167.99, -363.9, 13.09),
                heading = 344.9,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 23,
                coords = vector3(-656.3, -605.3, 33.48),
                heading = 261.73,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 24,
                coords = vector3(-505.22, -670.41, 33.1),
                heading = 2.35,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 25,
                coords = vector3(238.43, -861.65, 29.78),
                heading = 344.56,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 26,
                coords = vector3(331.88, -775.88, 29.27),
                heading = 67.39,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            }

        },
        ['lstransitexps'] = {
            {
                stopID = 1,
                coords = vector3(304.62, -764.39, 29.31),
                heading = 247.36,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 2,
                coords = vector3(276.28, -590.82, 43.29),
                heading = 68.0,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 3,
                coords = vector3(259.9, -351.62, 44.63),
                heading = 159.77,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 4,
                coords = vector3(337.43, -119.84, 67.28),
                heading = 340.5,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 5,
                coords = vector3(917.91, -267.74, 68.34),
                heading = 322.46,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 6,
                coords = vector3(861.21, -84.63, 79.76),
                heading = 149.41,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 7,
                coords = vector3(998.58, 177.81, 80.99),
                heading = 58.46,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 8,
                coords = vector3(1557.07, 877.62, 77.47),
                heading = 71.66,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 9,
                coords = vector3(2301.25, 3092.44, 47.3),
                heading = 105.15,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 10,
                coords = vector3(1809.87, 3321.6, 42.04),
                heading = 127.95,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 11,
                coords = vector3(1849.48, 3653.93, 34.19),
                heading = 28.17,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 12,
                coords = vector3(1938.09, 3877.15, 32.23),
                heading = 203.13,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 13,
                coords = vector3(1704.21, 3742.01, 33.75),
                heading = 199.68,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 14,
                coords = vector3(1400.01, 3594.8, 34.92),
                heading = 203.16,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 15,
                coords = vector3(1787.96, 3333.13, 41.17),
                heading = 292.66,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 16,
                coords = vector3(2000.15, 2607.45, 54.19),
                heading = 226.26,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 17,
                coords = vector3(1491.65, 850.2, 76.94),
                heading = 234.5,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 18,
                coords = vector3(810.71, 208.56, 81.1),
                heading = 233.86,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 19,
                coords = vector3(423.2, -60.77, 73.3),
                heading = 240.29,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 20,
                coords = vector3(251.58, -569.08, 43.27),
                heading = 262.43,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 21,
                coords = vector3(224.78, -856.77, 30.13),
                heading = 345.26,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            },
            {
                stopID = 22,
                coords = vector3(333.0, -773.08, 29.27),
                heading = 68.68,
                npcCount = math.random(1, 2),
                npcPrice = math.random(10, 50),
                passengerPickedUp = false,
                npcList = {}
            }

        }
    }
}




-- ██╗░░░░░███████╗██╗░░░██╗███████╗██╗░░░░░░█████╗░███╗░░██╗██████╗░██╗░░██╗██████╗░
-- ██║░░░░░██╔════╝██║░░░██║██╔════╝██║░░░░░██╔══██╗████╗░██║██╔══██╗╚██╗██╔╝██╔══██╗
-- ██║░░░░░█████╗░░╚██╗░██╔╝█████╗░░██║░░░░░███████║██╔██╗██║██║░░██║░╚███╔╝░██████╔╝
-- ██║░░░░░██╔══╝░░░╚████╔╝░██╔══╝░░██║░░░░░██╔══██║██║╚████║██║░░██║░██╔██╗░██╔═══╝░
-- ███████╗███████╗░░╚██╔╝░░███████╗███████╗██║░░██║██║░╚███║██████╔╝██╔╝╚██╗██║░░░░░
-- ╚══════╝╚══════╝░░░╚═╝░░░╚══════╝╚══════╝╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░╚═╝░░╚═╝╚═╝░░░░░

Config.RequiredXP = {
    [1] = 1000,
    [2] = 1500,
    [3] = 2000,
    [4] = 2500,
    [5] = 3000,
    [6] = 3500,
    [7] = 4000,
    [8] = 4500,
    [9] = 5000,
    [10] = 5500,
    [11] = 6000,
    [12] = 6500,
    [13] = 7000,
    [14] = 7500,
    [15] = 8000,
    [16] = 8500,
    [17] = 9000,
    [18] = 9500,
    [19] = 10000,
    [20] = 10500,
    [21] = 11000,
    [22] = 11500,
    [23] = 12000,
    [24] = 12500,
    [25] = 13000,
    [26] = 13500,
    [27] = 14000,
    [28] = 14500,
    [29] = 15000,
    [30] = 15500,
    [31] = 16000,
    [32] = 16500,
    [33] = 17000,
    [34] = 17500,
    [35] = 18000,
    [36] = 18500,
    [37] = 19000,
    [38] = 19500,
    [39] = 20000,
    [40] = 20500,
    [41] = 21000,
    [42] = 21500,
    [43] = 22000,
    [44] = 22500,
    [45] = 23000,
    [46] = 23500,
    [47] = 24000,
    [48] = 24500,
    [49] = 25000,
    [50] = 25000000000,
    [51] = 250000000000000,
}


-- ███╗░░██╗░█████╗░████████╗██╗███████╗██╗░█████╗░░█████╗░████████╗██╗░█████╗░███╗░░██╗
-- ████╗░██║██╔══██╗╚══██╔══╝██║██╔════╝██║██╔══██╗██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║
-- ██╔██╗██║██║░░██║░░░██║░░░██║█████╗░░██║██║░░╚═╝███████║░░░██║░░░██║██║░░██║██╔██╗██║
-- ██║╚████║██║░░██║░░░██║░░░██║██╔══╝░░██║██║░░██╗██╔══██║░░░██║░░░██║██║░░██║██║╚████║
-- ██║░╚███║╚█████╔╝░░░██║░░░██║██║░░░░░██║╚█████╔╝██║░░██║░░░██║░░░██║╚█████╔╝██║░╚███║
-- ╚═╝░░╚══╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝
Config.NotificationText = {
    ['passengerin'] = {
        text = "%s passenger boarded the bus.",
        type = "success"
    },
    ['passengerout'] = {
        text = "%s passenger got off the bus.",
        type = "success"
    },
    ['deliveryBus'] = {
        text = "Deliver the vehicle to get your money.",
        type = "success"
    },
    ['timefinish'] = {
        text = "Time Finish..!",
        type = "error"
    },
    ['resetjob'] = {
        text = "Reset Job..!",
        type = "error"
    },
    ['nocar'] = {
        text = "You went without a car for more than the allowed time during the mission..!",
        type = "error"
    },
    ['notplayer'] = {
        text = "Player not found.",
        type = "error"
    },
    ['notfinishjob'] = {
        text = "You can't finish job.",
        type = "error"
    },
    ['notspawnvehicle'] = {
        text = " You can't spawn vehicle, because the parking lots are full",
        type = "error"
    },
    ['newlevel'] = {
        text = "Bus Job new Level : %s",
        type = "success"
    },
    ['completedailymission'] = {
        text = "You have completed your daily mission. You have earned %s xp",
        type = "success"
    },
    ['newxp'] = {
        text = "Bus Job add %s xp.",
        type = "success"
    },
    ['wrongjob'] = {
        text = "You can't do this job.",
        type = "error"
    },

    ['speedlimit'] = {
        text = "You have to stop to pick up passengers",
        type = "error"
    },
    ['lockvehicle'] = {
        text = "Your vehicle is unlocked and passengers cannot board the bus.",
        type = "error"
    }

}
Config.Notification = function(message, type, isServer, src) -- You can change here events for notifications
    if isServer then
        if Config.Framework == "esx" then
            TriggerClientEvent("esx:showNotification", src, message)
        else
            TriggerClientEvent('QBCore:Notify', src, message, type, 1500)
        end
    else
        if Config.Framework == "esx" then
            TriggerEvent("esx:showNotification", message)
        else
            TriggerEvent('QBCore:Notify', message, type, 3500)
        end
    end
end



Config.RandomNpc = {
    0x400AEC41,
    0xF0AC2626,
    0x4BA14CCA,
    0x6DBBFC8B,
    0x95EF18E3,
    0xCF623A2C,
    0xC306D6F5,
    0x445AC854,
    0xEFE5AFE6,
    0xAE86FDB4,
    0x7E4F763F,
    0xB6AA85CE,
    0x0B4A6862,
}
