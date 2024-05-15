Config.NormalShops = {
    ["247"] = { -- unique identifier for the shop (make sure these are unique)
        name = "24/7 Shop", -- label that will show on top of the ui of shop
        blip = { -- blip related info for the shops
			id = 59, colour = 69, scale = 0.5
		},
        items = { -- item name and price for the item that will be available at this shop
        {name = "water_bottle", price = 50},
        {name = "tosti", price = 75},
        {name = "lighter", price = 500},
        {name = "harness", price = 1000},
        {name = "phone", price = 500},
        {name = "powerbank", price = 5000},
        },
        locations = { -- locations for this particular shop
        -- coords = vector4
        -- ped = ped Model
        -- scenario = scenario for the ped
            {coords = vector4(-552.71, -583.27, 34.68, 181),ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
			{coords = vector4(1959.35, 3741.11, 32.34, 298),ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
	--[[ 		{coords = vector4(-3243.27, 1000.1, 12.83, 358.73),ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
			{coords = vector4(1728.28, 6416.03, 35.04, 242.45),ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
			{coords = vector4(1697.96, 4923.04, 42.06, 326.61),ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
			{coords = vector4(1959.6, 3740.93, 32.34, 296.84),ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
			{coords = vector4(549.16, 2670.35, 42.16, 92.53),ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
			{coords = vector4(2677.41, 3279.8, 55.24, 334.16),ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
			{coords = vector4(2556.19, 380.89, 108.62, 355.58),ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
			{coords = vector4(372.82, 327.3, 103.57, 255.46),ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
			{coords = vector4(161.21, 6642.32, 31.61, 223.57),ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
 ]]            
        }
    },
    ["gasoline"] = {
        name = "LTD Gasoline Station", -- label that will show on top of the ui of shop
        blip = { -- blip related info for the shops
			id = 59, colour = 28, scale = 0.45
		},
        items = { -- item name and price for the item that will be available at this shop
        {name = "lighter", price = 20},
        {name = "rolex", price = 900},
        {name = "laptop", price = 1500},
        {name = "phone", price = 500},
        {name = "powerbank", price = 5000},
        --{name = "kq_outfitbag", price = 1000},
--[[    {name = "marlboro", price = 650},
        {name = "menthols", price = 1000},
        {name = "marblights", price = 600}, ]]
        },
        locations = { -- locations for this particular shop
            {coords = vector4(-47.02, -1758.23, 29.42, 45.05), ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
            {coords = vector4(-706.06, -913.97, 19.22, 88.04), ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
            {coords = vector4(-1820.02, 794.03, 138.09, 135.45), ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
            {coords = vector4(1164.71, -322.94, 69.21, 101.72), ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
            {coords = vector4(1697.87, 4922.96, 42.06, 324.71), ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
        }
    },
   --[[  ["liquor"] = {
        name = "Liquor Store", -- label that will show on top of the ui of shop
        blip = { -- blip related info for the shops
			id = 93, colour = 23, scale = 0.8
		},
        items = { -- item name and price for the item that will be available at this shop
            {name = "phone", price = 100}
        },
        locations = { -- locations for this particular shop
            {coords = vector4(-1221.58, -908.15, 12.33, 35.49), ped = "a_f_y_business_04", scenario = "WORLD_HUMAN_STAND_MOBILE"},
            {coords = vector4(-1486.59, -377.68, 40.16, 139.51), ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
            {coords = vector4(-2966.39, 391.42, 15.04, 87.48), ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
            {coords = vector4(1165.17, 2710.88, 38.16, 179.43), ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
            {coords = vector4(1134.2, -982.91, 46.42, 277.24), ped = "mp_m_shopkeep_01", scenario = "WORLD_HUMAN_STAND_MOBILE"},
        }
    }, ]]
    ["hardware"] = {
        name = "Hardware Shop",
        blip = {
            id = 402, colour = 69, scale = 0.9
        },
        items = {
            --[[ {name = "lockpick", price = 100},
            {name = "screwdriverset", price = 1000},
            {name = "weapon_flashlight", price = 2500},
            {name = "radio", price = 8000},
            {name = "phone", price = 3000},
            {name = "cleaningkit", price = 20},
            {name = "plasticjerrycan", price = 20},
            {name = "trowel", price = 250},
            {name = "razorblade", price = 5},
            {name = "ammonia", price = 20},
            {name = "kq_outfitbag", price = 10000},
            {name = "shovel", price = 100},
            {name = "camera", price = 5000},
            {name = "detector", price = 10000},
            {name = "powerbank", price = 500},
            {name = "drill", price = 2000},
            {name = "carradio", price = 5000},
            {name = "tvremote", price = 5000},
            {name = "spray_remover", price = 5000}, ]]
        },
        locations = {
            {coords = vector4(-529.13, -582.74, 34.68, 175), ped = "a_m_m_prolhost_01", scenario = "PROP_HUMAN_STAND_IMPATIENT"},
        }
    },
    ["weapon"] = {
        name = "Weapon Shop",
        blip = {
            id = 110, colour = 0, scale = 0.6
        },
        License = true, -- only for qbcore, code is open in cl_normalshops.lua and sv_customise to make it work for other frameworks
        items = {
            {name = "weapon_knife", price = 3000, needsLicense = false}, -- will only be able to see the item if has license 
            {name = "weapon_pistol", price = 25000, needsLicense = true},
            {name = "pistol_ammo", price = 1000, needsLicense = true}, 
            {name = "weapon_musket", price = 115000, needsLicense = true},
            {name = "weapon_fn502", price = 75000, needsLicense = true},
        },
        locations = {
            {coords = vector4(-544.88, -583.82, 34.68, 282), ped = "s_m_y_ammucity_01", scenario = "WORLD_HUMAN_COP_IDLES"},
        }
    },
    --[[ ["mechanic"] = {
        name = "Mech Only Shop",
        job = {["was"] = 0, ["cosmetic"] = 0, ["jwc"] = 0}, -- if you want only a job to access this shop
        items = {
            {name = "repairkit", price = 1},
            {name = "harness", price = 1},
        },
        locations = {
            {coords = vector4(-1429.2401123047, -457.77429199219, 35.909698486328, 215.59172058105), ped = "mp_m_waremech_01", scenario = "WORLD_HUMAN_CLIPBOARD"}, --Hayes
            {coords = vector4(-195.5, -1321.16, 31.09, 64.45), ped = "mp_m_waremech_01", scenario = "WORLD_HUMAN_CLIPBOARD"}, --JWC
            {coords = vector4(87.8, 6517.1, 31.26, 229.82), ped = "mp_m_waremech_01", scenario = "WORLD_HUMAN_CLIPBOARD"}, --WAS
            {coords = vector4(-590.8, -939.84, 28.14, 352.75), ped = "mp_m_waremech_01", scenario = "WORLD_HUMAN_CLIPBOARD"}, --WAS City
            
        }
    }, ]]
   --[[  ["fire"] = {
        name = "Fire Department",
        job = "fire", -- if you want only a job to access this shop
        items = {
            {name = "weapon_fireextinguisher", price = 1},
            {name = "radio", price = 1},
            {name = "hose", price = 1},
            {name = "fan", price = 1},
            {name = "spreaders", price = 1},
            {name = "stabilisers", price = 1},
            {name = "throwbag", price = 1},
            {name = "watermonitor", price = 1},
        },
        locations = {
            {coords = vector4(-1226.2, -1807.18, 4.4, 173.39), ped = "mp_m_waremech_01", scenario = "WORLD_HUMAN_CLIPBOARD"},
        }
    }, ]]
   --[[  ["used"] = {
        name = "Contract Man",
        job = "used", -- if you want only a job to access this shop
        items = {
            {name = "vehiclecontract", price = 1},
        },
        locations = {
            {coords = vector4(-1106.53, -1275.71, 5.85, 308.39), ped = "a_m_y_business_02", scenario = "WORLD_HUMAN_CLIPBOARD"},
        }
    }, ]]
    --[[ ["pharmacy"] = {
        name = "Dr. Pharmacist",
        job = "ambulance", -- if you want only a job to access this shop   vector4(354.61, -593.55, 28.85, 344)
        items = {
            {name = "legaloxy", price = 1},
            {name = "tylenol", price = 1},
            {name = "peptobismol", price = 1},
            {name = "loperamide", price = 1},
            {name = "aspirin", price = 1},
            {name = "ibuprofen", price = 1},
            {name = "dramamine", price = 1},
            {name = "covidvaccine", price = 1},
        },
        locations = {
            {coords = vector4(354.61, -593.55, 28.85, 344.0), ped = "s_m_y_autopsy_01", scenario = "WORLD_HUMAN_CLIPBOARD"},
        }
    }, ]]
}