Config = {}
Config.Framework = 'qb' -- esx, oldesx, qb, oldqb, autodetect
Config.SQL = "oxmysql" -- oxmysql, ghmattimysql, mysql-async
Config.Inventory = "codem-inventory" -- ox_inventory, qb_inventory, esx_inventory, codem-inventory, qs_inventory
Config.InteractionHandler = 'qb_target' -- drawtext, ox_target, qb_target, qb_textui, esx_textui, codem-textui
Config.DisableAFKMode = false -- if true minigame shows up 
Config.JobCheck = { -- if enabled only players with the job you have written can access the menu
  enable = false,
  name = 'miner',
}

Config.DailyMissions = {
  ["gather_mine"] = {
    header = "Gather At Least 1 Mine",
    label = "Gather at least 1 mine in any mining areas.",
    max = 1,
    xp = 1250,
  },
  ["gather_diamonds"] = {
    header = "Diamonds On My Neck",
    label = "Gather 10 diamonds in Abandoned Mines",
    max = 10,
    xp = 2500,
  },  
  ["process_ore"] = {
    header = "Process At Least 10 Ore",
    label = "Process at leats 10 ore in processing area.",
    max = 10,
    xp = 2500,
  }, 
}

Config.GiveXP = {
  collectMine = math.random(5, 10),
  processOre = math.random(5, 10),
}

Config.MinerMenu = {
  coords = vector4(1054.49, -1952.89, 31.09, 272.64),
  model = `g_m_m_chiboss_01`,
  vehSpawnCoords = vector4(1068.4234619141, -1960.2872314453, 30.014419555664, 346.75964355469),
  blip = {
    name = 'Miner Job',
    show = true, -- if you want to disable the blip, set this to false
    sprite = 78, 
    color  = 42,
    scale = 0.8,
  }
}


Config.Process = {
  coords = vector3(1110.0534667969, -2008.1168212891, 31.061630249023),
   blip = {
    name = 'Ore Process Area',
    sprite = 270, 
    color  = 5,
    scale = 0.8,
  }
}

Config.Areas = {
   ["redwood"]= {
      label = "Redwood Lights Area",
      bg= "mine-map-1.png",
      itemsLabel = "Copper, Sulfur, Sandstone",
      possible_items = {
        "copper_ore",
        "sandstone",
        "sulfur",
        "rock",

      },
      level= 1,
      tool= "normal_pickaxe",
      toolLabel= "Normal Pickaxe Recommended",
      coords = {
        vector3(1150.240234375, 2186.7883300781, 45.120315551758),
        vector3(1150.5992431641, 2183.73828125, 45.344005584717),
        vector3(1150.8804931641, 2190.0681152344, 45.28742980957),
        vector3(1150.8286132813, 2192.63671875, 45.522129058838),
        vector3(1148.9595947266, 2193.8454589844, 46.764041900635),
        vector3(1150.4240722656, 2183.3435058594, 45.516536712646)
      },
    },
    ["david_quartz"]= {
      
      label= "David Quartz Area",
      bg= "mine-map-2.png",
      itemsLabel= "Iron, Limestone, Sandstone",
      possible_items = {
        "iron_ore",
        "limestone",
        "sandstone",
        "rock",
      },
      level= 15,
      tool= "advanced_pickaxe",
      toolLabel= "Advanced Pickaxe Recommended",
      coords = {
        vector3(2998.4541015625, 2756.9118652344, 43.040542602539),
        vector3(2999.5092773438, 2759.9768066406, 42.944328308105),
        vector3(3004.1899414063, 2762.7766113281, 43.679538726807),
        vector3(3005.1018066406, 2766.5942382813, 43.077896118164),
        vector3(3005.1635742188, 2770.4331054688, 42.829959869385),
        vector3(3004.5891113281, 2773.7390136719, 43.037490844727),
        vector3(3005.4477539063, 2779.0786132813, 43.437244415283)
      },
    },
    ["abandoned_mine"]= { 
      label= "Abandoned Mines",
      bg= "mine-map-3.png",
      itemsLabel= "Diamond, Gold, Coal",
      possible_items = {
        "diamond_ore",
        "gold_ore",
        "coal",
        "rock",

      },
      level= 30,
      tool= "professional_pickaxe",
      toolLabel= "Professional Pickaxe Recommended",
      coords = {
        vector3(-593.75360107422, 2083.6606445313, 131.57299804688),
        vector3(-592.33862304688, 2081.091796875, 131.36380004883),
        vector3(-591.91662597656, 2077.8989257813, 131.41575622559),
        vector3(-591.85174560547, 2075.8767089844, 131.35877990723),
        vector3(-593.82592773438, 2076.1850585938, 131.44123840332),
        vector3(-594.35321044922, 2078.783203125, 131.40226745605),
        vector3(-595.63720703125, 2082.5634765625, 131.58988952637),
        vector3(-596.2392578125, 2085.740234375, 131.42182922363)
      },
    },
}

Config.Shipments = {
  {
        factoryname = "Bristols INC.",
        factorylabel= "Bristols Coal Factory",
        itemLabel= "Coal",
        itemname= "coal",
        coords = vector3(539.72, -2736.7, 6.06),
        itemamount= 100,
        offer= 15000,
        itemimg= "coal.png",
      },
      {
        factoryname = "Bugstars PC.",
        factorylabel= "Bugstars Logistics",
        itemLabel = "Glass",
        itemname ="glass",
        itemamount= 50,
        offer= 50000,
        itemimg= "glass.png",
        coords = vector3(142.01, -3096.19, 5.9),

      },
      {
        factoryname= "Stoner CW.",
        factorylabel= "Stoner Cement Works",
        itemLabel ="Concrete",
        item2Label = "Rock",
        itemname= "concrete_package",
        item2name= "rock",
        itemamount= 200,
        item2amount= 350,
        offer= 35000,
        itemimg= "concrete_package.png",
        item2img= "rock.png",
        coords = vector3(281.47, 2826.16, 43.44),

      },
      {
        factoryname= "Walker INC.",
        factorylabel= "Walker Logistics",
        itemLabel= "Iron Ingot",
        item2Label= "Copper Ingot",
        itemname= "iron_ingot",
        item2name= "copper_ingot",
        itemamount= 100,
        item2amount= 250,
        offer= 60000,
        itemimg= "iron_ingot.png",
        item2img= "copper_ingot.png",
        coords = vector3(136.24, -3203.55, 5.86),
      },
      {
        factoryname= "Ammu - Nation INC.",
        factorylabel= "AMU Transports",
        itemLabel= "Black Powder",
        itemname= "blackpowder",
        itemamount= 200,
        offer= 80000,
        itemimg= "black_powder.png",
        coords =  vector3(469.71, -3234.21, 6.07),
      },
      {
        factoryname= "Vangelico FJ.",
        factorylabel= "Vangelico Transport",
        itemLabel= "Diamond Ingot",
        item2Label= "Gold Ingot",
        itemname= "diamond_ingot",
        item2name= "goldingot",
        itemamount= 25,
        item2amount= 45,
        offer= 100000,
        itemimg= "diamond_ingot.png",
        item2img= "gold_ingot.png",
        coords =  vector3(759.94, -3195.27, 6.07),
      },
}


Config.SellItems = {
  {
        name = "diamond_ore",
        label= "Diamond Ore",
        price= 150,
        image= "diamond_ore.png",
        desc= "A diamond ore that can be obtainable from the Abandoned Mines. Can be convertible to diamond ingot in the process areas as well.",
      },
      {
        name = "gold_ore",
        label= "Gold Ore",
        price= 450,
        image= "gold_ore.png",
        desc= "A gold ore that can be obtainable from the Abandoned Mines. Can be convertible to gold ingot in the process areas as well.",
      },
      {
        name = "iron_ore",
        label= "Iron Ore",
        price= 1050,
        image= "iron_ore.png",
        desc= "An iron ore that can be obtainable from the Davis Quartz Area. Can be convertible to iron ingot in the process areas as well.",
      },
      {
        name = "copper_ore",
        label= "Copper Ore",
        price= 1050,
        image= "copper_ore.png",
        desc= "A copper ore that can be obtainable from the Redwood Lights Area. Can be convertible to copper ingot in the process areas as well.",
      },
      {
        name = "sulfur",
        label= "Sulfur",
        price= 1050,
        image= "sulfur.png",
        desc= "This coal can be obtainable from the Redwood Lights Area. Can be convertible to powder in the process areas with coal as well.",
      },
      {
        name = "limestone",
        label= "Limestone",
        price= 1050,
        image= "limestone.png",
        desc= "This limestone can be obtainable from the Davis Quartz Area. Can be convertible to concrete in the process areas as well.",
      },
      {
        name = "sandstone",
        label= "Sandstone",
        price= 1050,
        image= "sandstone.png",
        desc= "This sandstone can be obtainable from the Davis Quartz and Redwood Light Area. Can be convertible to glass in the process areas as well.",
      },
      {
        name = "rock",
        label= "Rock",
        price= 1050,
        image= "rock.png",
        desc= "Basic rock that can be obtainable from any mining areas. ",
      },
      {
        name = "coal",
        label= "Coal",
        price= 1050,
        image= "coal.png",
        desc= "This coal can be obtainable from the Abandoned Mines. Can beconvertible to powder in the process areas with sulfur as well.",
      },
}

Config.BuyItems = {
  {
        name  = "normal_pickaxe",
        label = "Normal Pickaxe",
        price = 150,
        image = "normal_pickaxe.png",
        desc = "This pickaxe can gather “ Sandstone, Sulfur, Copper and Rock “ from the mine areas.",
      },
      {
        name  = "advanced_pickaxe",
        label = "Advanced Pickaxe",
        price = 450,
        image = "advanced_pickaxe.png",
        desc = "This pickaxe can gather “ Sandstone, Limestone, Iron Ore and Rock “ from the mine areas.",
      },
      {
        name  = "professional_pickaxe",
        label = "Professional Pickaxe",
        price = 1050,
        image = "professional_pickaxe.png",
        desc= "This pickaxe can gather “ Gold Ore, Diamond Ore, Coal and Rock “ from the mine areas. ",
      },
      {
        name = "ingot_mold",
        label= "Ingot Mold",
        price= 50,
        image= "ingot_mold.png",
        desc= "This ingot mold used in the process of conver all ores into ingots.",
      },
      {
        name = "sticky_gel",
        label= "Sticky Gel",
        price= 75,
        image= "sticky_gel.png",
        desc= "This sticky gel used in the process of converting sands to glass material process.",
      },
      {
        name = "glass_mold",
        label= "Glass Mold",
        price= 3000,
        image= "glass_mold.png",
        desc= "This glass mold used in the process of converting sands to glass material process.",
      },
      {
        name = "special_water",
        label= "Special Water",
        price= 20,
        image= "special_water.png",
        desc= "This special water used in the process of converting limestones to concrete process.",
      },
      {
        name = "concrete_package",
        label= "Concrete Packge",
        price= 5,
        image= "concrete_package.png",
        desc= "This concrete package used in the process of converting limestones to concrete process.",
      },
}


Config.XP = {
}
CreateThread(function()
    for i = 1, 100 do
        table.insert(Config.XP, i * 1000)
    end
end)

-- Config.UseLegacyFuel  = GetResourceState("LegacyFuel") ~= "missing" -- true enabled -- false disabled
Config.FuelSystem = ""                      -- LegacyFuel / x-fuel

Config.SetVehicleFuel = function(vehicle, fuel_level) -- you can change LegacyFuel export if you use another fuel system
    if Config.FuelSystem == 'cdn-fuel' then
        return exports["cdn-fuel"]:SetFuel(vehicle, fuel_level)
    elseif Config.FuelSystem == 'x-fuel' then
        return exports["x-fuel"]:SetFuel(vehicle, fuel_level)
    else
        return SetVehicleFuelLevel(vehicle, fuel_level + 0.0)
    end
end


Config.Vehiclekey          = true
Config.VehicleSystem       = "qb-vehiclekeys"       -- cd_garage / qs-vehiclekeys / wasabi-carlock / qb-vehiclekeys
Config.Removekeys          = true
Config.RemoveVehicleSystem = "qb-vehiclekeys"       -- cd_garage / qs-vehiclekeys / wasabi-carlock / qb-vehiclekeys

Config.GiveVehicleKey      = function(plate, model) -- you can change vehiclekeys export if you use another vehicle key system
    if Config.Vehiclekey then
        if Config.VehicleSystem == 'cd_garage' then
            TriggerEvent('cd_garage:AddKeys', exports['cd_garage']:GetPlate(vehicle))
        elseif Config.VehicleSystem == 'qs-vehiclekeys' then
            exports['qs-vehiclekeys']:GiveKeys(plate, model)
        elseif Config.VehicleSystem == 'wasabi-carlock' then
            exports.wasabi_carlock:GiveKey(plate)
        elseif Config.VehicleSystem == 'qb-vehiclekeys' then
            TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
        end
    end
end
Config.RemoveVehiclekey = function(plate, model)
    if Config.Removekeys then
        if Config.RemoveVehicleSystem == 'cd_garage' then
            TriggerServerEvent('cd_garage:RemovePersistentVehicles', exports['cd_garage']:GetPlate(vehicle))
        elseif Config.RemoveVehicleSystem == 'qs-vehiclekeys' then
            exports['qs-vehiclekeys']:RemoveKeys(plate, model)
        elseif Config.RemoveVehicleSystem == 'wasabi-carlock' then
            exports.wasabi_carlock:RemoveKey(plate)
        elseif Config.RemoveVehicleSystem == 'qb-vehiclekeys' then
            TriggerServerEvent('qb-vehiclekeys:client:RemoveKeys', plate)
        end
    end
end

Config.OnMenuOpen = function()
  -- hide your other ui elements
end


Config.OnMenuClose = function()
  -- show your other ui elements
end