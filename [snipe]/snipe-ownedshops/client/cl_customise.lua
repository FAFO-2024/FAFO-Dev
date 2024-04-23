QBCore, ESX = nil, nil
itemTable = {}

-- added to take care of exports which let you add items on runtime in QBCore (Do not touch)
RegisterNetEvent('QBCore:Client:UpdateObject', function()
	QBCore = exports['qb-core']:GetCoreObject()
end)

CreateThread(function()
    if Config.Core == "qbcore" then
        QBCore = exports[Config.CoreFolderName]:GetCoreObject()
    elseif Config.Core == "esx" then
        local status, errorMsg = pcall(function() ESX = exports[Config.CoreFolderName]:getSharedObject() end)
        Wait(250)
        if (ESX == nil) then
            while ESX == nil do
                Wait(100)
                TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
            end
        end
    end
end)

-- fetches all the items
CreateThread(function()
    Wait(1000)
    if Config.Core == 'qbcore' and Config.Inventory ~= 'ox' then
        itemTable = QBCore.Shared.Items
    elseif Config.Inventory == 'ox' then
        itemTable = exports['ox_inventory']:Items()
    elseif Config.Core == "esx" and Config.Inventory == 'qs' then
        itemTable = exports['qs-inventory']:GetItemList()
    end
end)

function SetTargetExports(obj, data)
    Wait(1000)
    exports["qb-target"]:AddTargetEntity(obj, {
        options = {
            {
                event = "snipe-ownedshops:client:manageShop",
                icon = "fas fa-shopping-cart",
                label = "Manage Shop",
                shopId = data.id,
            },
            {
                event = "snipe-ownedshops:client:addItems",
                icon = "fas fa-shopping-cart",
                label = "Add Items",
                shopData = data
            },
            {
                event = "snipe-ownedshops:client:openShop",
                icon = "fas fa-shopping-cart",
                label = "Shop",
                shopData = data
            },
        },
        distance = 1.5
    })
end

function DrawAllBlips(override, coords, name)
    
    for k, v in pairs(shopTable) do
        if v.enabledBlip then
            local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
            SetBlipSprite(blip, 457)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.8)
            SetBlipColour(blip, 44)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            SetBlipCategory(blip, 10) -- makes the blip not unique (this has been added because there is a blip limit from fivem. If you want to make it unique, remove this line)
            AddTextComponentString("Owned Shop: "..v.name)
            EndTextCommandSetBlipName(blip)
            shopTable[k].blip = blip
        end
    end
end

function DrawBlip(coords, name)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 457)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 44)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    SetBlipCategory(blip, 10) -- makes the blip not unique (this has been added because there is a blip limit from fivem. If you want to make it unique, remove this line)
    AddTextComponentString("Owned Shop: "..name)
    EndTextCommandSetBlipName(blip)
    return blip
end

function ShowNotification(msg, type)
    if Config.Core == "qbcore" then
        QBCore.Functions.Notify(msg, type)
    elseif Config.Core == "esx" then
        ESX.ShowNotification(msg)
    end
end

-- this thread will help you find the broken items

-- CreateThread(function()
--     local items = QBCore.Shared.Items

--     for k, v in pairs(items) do
--         if not v.label then
--             print(k)
--         end
--     end
-- end)