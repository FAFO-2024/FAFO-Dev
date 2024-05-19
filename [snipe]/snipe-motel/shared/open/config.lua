Config = {}

Config.DoorIdPrefix = 77652

Config.Debug = false

Config.RequireMoneyToRent = false
Config.RentPrice = 100 -- per day
Config.MoneyType = "cash" -- you can modify the logic in sv_framework RemoveMoney() function to suit your needs.


-- if the players dont extend the room after it expires within 3 days, it will delete all the entries from the database
-- this will also delete the furniture placed in the room
Config.GracePeriod = 3 
Config.GraceAmount = 1000 -- amount to charge the player for the grace period

Config.TargetOrInteract = true -- only works with qb-target, qtarget and ox_target or interact script (https://github.com/darktrovx/interact). If you dont have interact, it will auto fall back to target

Config.PresetFurniture = false -- if true, players will have a room with preset furniture. If false, players will have an empty room.
Config.RequireMoneyToBuyFurniture = true
Config.ReturnMoneyOnDelete = true -- if true, it will return the money to the player when he deletes the furniture (Only works when RequireMoneyToBuyFurniture is true)
Config.DefaultFurniturePrice = 100 -- if you have set the above to true and you have missed to set the price for the furniture in furniture_list.lua, it will use this price

Config.LobbyCoords = vector4(-701.84, -2267.54, 13.46, 142.5) -- if a player leaves the server while being in a room, he will be teleported to this location

Config.PedLocations = {
    [1] = {
        coords = vector4(-715.68212890625, -2259.4946289063, 13.458878517151, 222.40846252441),
        model = "a_m_m_bevhills_01",
    }
    
}


Config.OnlyOwnerShouldAccessStashOutfit = true -- if true, only the owner of the room can access the stash and outfits

Config.AllowStash = true -- if true, players can access and place stashes in the room
Config.AllowOutfit = true -- if true, players can access the outfit in the room

Config.Inventory = "codem" -- "qb", "qs", "ox", "mf", "codem" (if you use any other stash, modify in client/open/cl_stash.lua) (NO SUPPORT FOR PAID INVENTORIES IF THERE IS NO DOCUMENTATION. I am willing to help if you provide the documentation)
Config.StashSize = 100000
Config.StashSlots = 50 

-- fivem is if you use wasabi's fivem appearance
Config.Clothing = "illenium" -- "qb", "illenium", "fivem", "rcore" (if you use any other clothing, modify in client/open/cl_clothing.lua) (NO SUPPORT FOR PAID CLOTHING IF THERE IS NO DOCUMENTATION. I am willing to help if you provide the documentation)

Config.AllowKeys = true -- if you want people to add key owners
Config.KeyLimit = 5 -- how many keys can be added for each room

Config.Framework = "other" -- do not touch this 
-- if you have renamed your qb-core, es_extended, event names, make sure to change them. Based on this information your framework will be detected.
Config.FrameworkTriggers = {
    ["qb"] = {
        ResourceName = "qb-core",
        PlayerLoaded = "QBCore:Client:OnPlayerLoaded",
        PlayerUnload = "QBCore:Client:OnPlayerUnload",
        JobUpdate = "QBCore:Client:OnJobUpdate"
    },
    ["esx"] = {
        ResourceName = "es_extended",
        PlayerLoaded = "esx:playerLoaded",
        PlayerUnload = "esx:playerDropped",
        JobUpdate = "esx:setJob"
    },
    ["ox"] = {
        ResourceName = "ox_core",
        PlayerLoaded = "ox:playerLoaded",
        PlayerUnload = "ox:playerLogout",
        JobUpdate = "ox:setGroup"
    }
}

Config.AllowRaiding = true -- to allow the raidable jobs to raid the motel rooms
Config.RaidableJobs = {
    ["police"] = true,
    ["sasp"] = true,
    ["sheriff"] = true
}

for k, v in pairs(Config.FrameworkTriggers) do
    if GetResourceState(v.ResourceName) == "started" then
        Config.Framework = k
        break
    end
end

if Config.Framework == "other" then
    Config.TargetOrInteract = false -- if your framework is not supported by default, this will be set to false. You can comment this out and change the target code to work with your system.
end




