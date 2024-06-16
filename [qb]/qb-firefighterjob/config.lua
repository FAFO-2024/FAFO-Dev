Config = {}

Config.Locations = {
    ["duty"] = {
        [1] = vector3(-1031.53, -1418.67, 4.97), -- HQ
        --[[ [2] = vector3(198.9, -1639.21, 29.8), -- DAVIS
        [3] = vector3(1187.7, -1468.59, 34.86), -- FS7 ]]
    },
    ["vehicle"] = {
        --[[ [1] = vector4(-1034.3, -1384.33, 5.01, 74.6), -- Bay 1
        [2] = vector4(-1032.8, -1378.52, 5.01, 74.6), -- Bay 2
        [3] = vector4(-1031.4, -1372.79, 5.01, 74.6), -- Bay 3
        [4] = vector4(-1029.8, -1367.18, 5.01, 74.6), -- Bay 4 ]]
    },
    ["helicopter"] = {
        [1] = vector4(-1053.0, -1438.4, 10.31, 344.27), -- Left helipad
        --[[ [2] = vector4(183.34, -1661.44, 29.8, 239.46), -- DAVIS
        [3] = vector4(1198.45, -1548.8, 39.4, 12.04), -- FS7 ]]
    },
    ["armory"] = {
        --[1] = vector3(-1033.19, -1389.67, 4.97), -- HQ
        --[[ [2] = vector3(198.71, -1649.07, 29.8), -- DAVIS
        [3] = vector3(1193.86, -1476.25, 34.86), -- FS7 ]]
    },
    ["stash"] = {
        [1] = vector3(-1033.97, -1424.94, 4.97), -- HQ
        --[[ [2] = vector3(217.48, -1662.38, 29.8), -- DAVIS
        [3] = vector3(1216.91, -1474.23, 34.86), -- FS7 ]]
    },
    ["stations"] = {
        [1] = {label = "Fire Department HQ", coords = vector4(-1038.57, -1387.74, 4.97, 66.49)},
        --[[ [2] = {label = "Davis Fire Department", coords = vector4(199.96, -1634.66, 30.02, 319.89)},
        [3] = {label = "Fire Station 7", coords = vector4(1185.59, -1464.36, 35.07, 3.96)} ]]
    }
}

Config.AuthorizedVehicles = {
	-- Grade 0
	[0] = {
	},
	-- Grade 1
	[1] = {
		["quantum"] = "Quantum",
	},
	-- Grade 2
	[2] = {
		["quantum"] = "Quantum",
	},
	-- Grade 3
	[3] = {
		["quantum"] = "Quantum",
	},
	-- Grade 4
	[4] = {
		["quantum"] = "Quantum",
        ["fdsilverado"] = "Chief's Truck",
	},
}

Config.Helicopter = "as365"

Config.Items = {
    label = "Firefighter Armory",
    slots = 30,
    items = {
        [1] = {
            name = "radio",
            price = 0,
            amount = 10,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "bandage",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "firstaid",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "weapon_flashlight",
            price = 0,
            amount = 10,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "weapon_fireextinguisher",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "ifaks",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "weapon_hatchet",
            price = 0,
            amount = 10,
            info = {},
            type = "item",
            slot = 7,
        },
    }
}

Config.VehicleSettings = {
    ["fdsilverado"] = { -- Model name
        ["extras"] = {
            ["1"] = true, -- on/off
            ["2"] = false,
            ["3"] = false,
            ["4"] = true,
            ["5"] = true,
            ["6"] = true,
            ["7"] = true,
            ["8"] = false,
            ["9"] = false,
            ["10"] = false,
            ["11"] = false,
            ["12"] = false,
            ["13"] = false,
        }
    },
    ["durangopru"] = {
        ["extras"] = {
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
}
