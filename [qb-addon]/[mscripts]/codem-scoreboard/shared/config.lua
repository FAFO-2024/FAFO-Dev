Config = {}
Config.Framework = 'qb' -- esx, oldesx, qb, oldqb or autodetect
Config.Servername = 'FAFORP' -- write in lowercase
Config.EnablePlayerList = false 
Config.ProfilPicture = "discord"   --discord or steam
Config.ShowID = true
Config.OpenKey = 243
Config.CloseKey = 27 --check here for close key https://api.jquery.com/event.which/
Config.OnlyOnDuty = false -- if true, only on duty players can see the menus
Config.Admins = {
    "admin",
    "superadmin",
    "god",
    "mod",
    "moderator",
}
Config.MenuOpen = function()

end
Config.MenuClose = function()

end
Config.Robberies = {
    ["jewelry_robbery"] = {
        bgImage = "./images/jewelry-robbery.png",
        label = "Jewelry Robbery", 
        requiredJobs = {"police", "fbi", "swat"},
        minPolice = 3,
        coords = {
            vector3(-626.3253, -239.0511, 37.64523)
        },
        canRob = false, -- dont touch
        disabledByServer = false, -- dont touch
    },
    ["pacific_robbery"] = {
        bgImage = "./images/pacific-robbery.png",
        label = "Pacific Robbery", 
        requiredJobs = {"police", "fbi", "swat"},
        minPolice = 1,
        coords = {
            vector3(257.10, 220.30, 106.28)
        },
        canRob = false, -- dont touch
        disabledByServer = false, -- dont touch
    },
    ["bank_robbery"] = {
        bgImage = "./images/bank-robbery.png",
        label = "Bank Robbery", 
        requiredJobs = {"police", "fbi", "swat"},
        minPolice = 3,
        coords = {},
        canRob = false, -- dont touch
        disabledByServer = false, -- dont touch
    },
    ["vehicle_robbery"] = {
        bgImage = "./images/vehicle-robbery.png",
        label = "Vehicle Robbery", 
        requiredJobs = {"police", "fbi", "swat"},
        minPolice = 3,
        coords = {},
        canRob = false, -- dont touch
        disabledByServer = false, -- dont touch
    },
    ["shop_robbery"] = {
        bgImage = "./images/shop-robbery.png",
        label = "Shop Robbery", 
        requiredJobs = {"police", "fbi", "swat"},
        minPolice = 3,
        coords = {
            vector3(373.8, 325.8, 103.5),
			vector3(2557.4, 382.2, 108.6),
			vector3(-3038.9, 585.9, 7.9),
			vector3(-3241.9, 1001.4, 12.8),
			vector3(547.4, 2671.7, 42.1),
			vector3(1961.4, 3740.6, 32.3),
			vector3(2678.9, 3280.6, 55.2),
			vector3(1729.2, 6414.1, 35.0),
            vector3(1135.8, -982.2, 46.4),
			vector3(-1222.9, -906.9, 12.3),
			vector3(-1487.5, -379.1, 40.1),
			vector3(-2968.2, 390.9, 15.0),
			vector3(1166.0, 2708.9, 38.1),
			vector3(1392.5, 3604.6,  34.9),
            vector3(-48.5,  -1757.5, 29.4),
			vector3(1163.3, -323.8, 69.2),
			vector3(-707.5, -914.2, 19.2),
			vector3(-1820.5, 792.5, 138.1),
			vector3(1698.3, 4924.4, 42.0)
        },
        canRob = false, -- dont touch
        disabledByServer = false, -- dont touch

    },
    ["lester_robbery"] = {
        bgImage = "./images/lester-robbery.png",
        label = "Lester Robbery", 
        requiredJobs = {"police", "fbi", "swat"},
        minPolice = 3,
        coords = {},
        canRob = false, -- dont touch
        disabledByServer = false, -- dont touch
    },
}
Config.Jobs = {
    ["ambulance"] = {
        bg = './images/ambulance-container.png',
        logo = './images/ambulance-logo.png',
        textColor = '#FF636A',
        playerCount = 0, -- dont touch
    },
    ["police"] = {
        bg = './images/police-container.png',
        logo = './images/police-logo.png',
        textColor = '#0049FF',
        playerCount = 0, -- dont touch
    },
    ["mechanic"] = {
        bg = './images/mechanic-container.png',
        logo = './images/mechanic-logo.png',
        textColor = '#A03AFF',
        playerCount = 0, -- dont touch
    },
    ["taxi"] = {
        bg = './images/taxi-container.png',
        logo = './images/taxi-logo.png',
        textColor = '#FFEB00',
        playerCount = 0, -- dont touch
    
    },

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
            TriggerEvent('QBCore:Notify', message, type, 1500)
        end
    end
end