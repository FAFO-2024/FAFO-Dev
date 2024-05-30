-- Zones for Menues
Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'false' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.BossMenus = {
    ['police'] = {
        vector3(461.45, -986.2, 30.73),
    },
    ['ambulance'] = {
        vector3(335.46, -594.52, 43.28),
    },
    ['realestate'] = {
        vector3(-716.11, 261.21, 84.14),
    },
    ['taxi'] = {
        vector3(907.24, -150.19, 74.17),
    },
    ['cardealer'] = {
        vector3(-27.47, -1107.13, 27.27),
    },
    ['mechanic'] = {
        vector3(471.55, -1309.26, 29.23),
    },
    ['mechanic4'] = {
        vector3(951.25, -968.39, 39.51),
    },
    ['mechanic7'] = {
        vector3(124.82, -3014.22, 7.04),
    },
    ['gunshop'] = {
        vector3(254.86, -49.41, 69.94),
    },
    ['gunshop2'] = {
        vector3(20.32, -1104.12, 29.8),
    },
    ['gunshop3'] = {
        vector3(-1302.91, -392.17, 36.7),
    },
    ['gunshop4'] = {
        vector3(-665.06, -932.98, 21.83),
    },
    ['gunshop5'] = {
        vector3(844.28, -1035.89, 28.19),
    },
    ['unicorn'] = {
        vector3(97.92, -1298.01, 35.58),
    },
    ['catcafe'] = {
        vector3(-596.92, -1053.37, 22.34),
    },
    ['news'] = {
        vector3(-1053.68, -230.54, 44.02),
    },
    ['cardealer'] = {
        vector3(-27.91, -1104.91, 26.42),
    },
    ['bahama'] = {
        vector3(-1370.43, -626.81, 30.36),
    },
    ['casino'] = {
        vector3(960.44, 70.56, 112.55),
    },
    ['mechanic2'] = {
        vector3(550.81, -176.03, 54.49),
    },
    ['mechanic5'] = {
        vector3(-1427.79, -458.23, 35.91),
    },
    ['mechanic3'] = {
        vector3(-206.64, -1342.07, 34.89),
    },
    ['mechanic6'] = {
        vector3(726.81, -1066.85, 28.31),
    },
    ['doj'] = {
        vector3(238.35, -1102.32, 29.29),
    },
    ['burger'] = {
        vector3(-1832.14, -1177.66, 13.3),
    },
    ['lojistik'] = {
        vector3(931.3, -1462.45, 30.4),
    },
    ['lojistik2'] = {
        vector3(931.3, -1462.45, 30.4),
    },
    ['yellow'] = {
        vector3(1981.44, 3051.2, 47.21),
    },
}

Config.BossMenuZones = {
    ['police'] = {
        { coords = vector3(447.23, -974.3, 31.47), length = 1.35, width = 1.45, heading = 351.0, minZ = 30.00, maxZ = 31.73 },    },
    ['ambulance'] = {
        { coords = vector3(335.46, -594.52, 43.28), length = 1.2, width = 0.6, heading = 341.0, minZ = 43.13, maxZ = 43.73 },
    },
    ['realestate'] = {
        { coords = vector3(-716.11, 261.21, 84.14), length = 0.6, width = 1.0, heading = 25.0, minZ = 83.943, maxZ = 84.74 },
    },
    ['taxi'] = {
        { coords = vector3(907.24, -150.19, 74.17), length = 1.0, width = 3.4, heading = 327.0, minZ = 73.17, maxZ = 74.57 },
    },
    ['cardealer'] = {
        { coords = vector3(-27.47, -1107.13, 27.27), length = 2.4, width = 1.05, heading = 340.0, minZ = 27.07, maxZ = 27.67 },
    },
    ['mechanic'] = {
        { coords = vector3(-339.53, -156.44, 44.59), length = 1.15, width = 2.6, heading = 353.0, minZ = 43.59, maxZ = 44.99 },
    },
}

Config.GangMenus = {
    ['lostmc'] = {
        vector3(0, 0, 0),
    },
    ['ballas'] = {
        vector3(0, 0, 0),
    },
    ['vagos'] = {
        vector3(0, 0, 0),
    },
    ['cartel'] = {
        vector3(0, 0, 0),
    },
    ['families'] = {
        vector3(0, 0, 0),
    },

    ['cete1'] = {
        vector3(-121.86, -1572.93, 34.18),
    },
    ['cete2'] = {
        vector3(-67.97, -1527.72, 34.24),
    },
    ['cete3'] = {
        vector3(84.29, -1966.72, 20.94),
    },
    ['cete4'] = {
        vector3(363.98, -2066.05, 21.74),
    },
    ['cete5'] = {
        vector3(562.59, -1749.46, 29.28),
    },
    ['cete6'] = {
        vector3(452.24, -1577.92, 32.79),
    },
    ['cete7'] = {
        vector3(-127.99, -1471.91, 33.7),
    },
    ['cete8'] = {
        vector3(471.71, -1738.84, 28.97),
    },
    ['cete9'] = {
        vector3(232.91, -1750.75, 29.04),
    },
    ['cete10'] = {
        vector3(0, 0, 0),
    },
}

Config.GangMenuZones = {
    --[[
    ['gangname'] = {
        { coords = vector3(0.0, 0.0, 0.0), length = 0.0, width = 0.0, heading = 0.0, minZ = 0.0, maxZ = 0.0 },
    },
    ]]
}
