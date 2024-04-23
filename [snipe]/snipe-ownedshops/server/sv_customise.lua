QBCore, ESX = nil, nil
local jobs = {}

if Config.Core == "qbcore" then
    QBCore = exports[Config.CoreFolderName]:GetCoreObject()
elseif Config.Core == "esx" then
    TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end) -- comment this line if you see ESX error on console for sharedobject
    if ESX == nil then
        ESX = exports[Config.CoreFolderName]:getSharedObject() 
    end
end

function GetIdentifier(id)
    if Config.Core == "qbcore" then
        local result = QBCore.Functions.GetPlayer(id)
        if result then
            return result.PlayerData.citizenid
        else
            return false
        end
    elseif Config.Core == "esx" then
        local result = ESX.GetPlayerFromId(id)
        if result then
            return result.identifier
        else
            return false
        end
    end

end

function GetPlayerNameFromIdentifier(id)
    if Config.Core == "qbcore" then
        local result = QBCore.Functions.GetPlayer(id)
        if result then
            return result.PlayerData.charinfo.firstname .. " " .. result.PlayerData.charinfo.lastname
        else
            return false
        end
    elseif Config.Core == "esx" then
        local result = ESX.GetPlayerFromId(id)
        if result then
            return result.getName()
        else
            return false
        end
    end
end

function GetPlayerJob(id)
    if Config.Core == "qbcore" then
        local result = QBCore.Functions.GetPlayer(id)
        if result then
            return result.PlayerData.job.name
        else
            return false
        end
    elseif Config.Core == "esx" then
        local result = ESX.GetPlayerFromId(id)
        if result then
            return result.job.name
        else
            return false
        end
    end
end

function CanAddItemsToShop(src, identifier, jobTable, playerTable)
    local job = GetPlayerJob(src)
    if jobTable and jobTable[job] then
        return true
    end

    if playerTable and playerTable[identifier] then
        return true
    end

    return false
end

function GetJobLabel(job)
    if Config.Core == "qbcore" then
        local jobs = QBCore.Shared.Jobs
        for k, v in pairs(jobs) do
            if k == job then
                return v.label
            end
        end
        return false
    elseif Config.Core == "esx" then
        for k, v in pairs(jobs) do
            if k == job then
                return v.label
            end
        end
        return false
    end
end

function GetMoneyInfo(source, moneyType)
    if Config.Core == "qbcore" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if moneyType == "Cash" then
            return xPlayer.PlayerData.money["cash"]
        elseif moneyType == "Bank" then
            return xPlayer.PlayerData.money["bank"]
        end
    elseif Config.Core == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if moneyType == "Cash" then
            return xPlayer.getMoney()
        elseif moneyType == "Bank" then
            return xPlayer.getAccount("bank").money
        end
    end
end

function RemovePlayerMoney(source, type, amount)
    if Config.Core == "qbcore" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if type == "Cash" then
            return xPlayer.Functions.RemoveMoney("cash", amount)
        elseif type == "Bank" then
            return xPlayer.Functions.RemoveMoney("bank", amount)
        end
    elseif Config.Core == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if type == "Cash" then
            if xPlayer.getMoney() >= amount then
                xPlayer.removeMoney(amount)
                return true
            else
                return false
            end
        elseif type == "Bank" then
            if xPlayer.getAccount("bank").money then
                xPlayer.removeAccountMoney("bank", amount)
                return true
            else
                return false
            end
        end
    end
end

function AddPlayerMoney(source, type, amount)
    if Config.Core == "qbcore" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if type == "Cash" then
            xPlayer.Functions.AddMoney("cash", amount)
        elseif type == "Bank" then
            xPlayer.Functions.AddMoney("bank", amount)
        end
    elseif Config.Core == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if type == "Cash" then
            xPlayer.addMoney(amount)
        elseif type == "Bank" then
            xPlayer.addAccountMoney("bank", amount)
        end
    end
end

function AddItem(source, item, amount)

    if Config.Inventory == "ox" then
        if exports.ox_inventory:AddItem(source, item, amount) then
            return true
        else
            return false
        end
    elseif Config.Core == "qbcore" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer.Functions.AddItem(item, amount) then
            return true
        else
            return false
        end
    elseif Config.Core == "esx" and Config.Inventory == "qs" then
        if exports['qs-inventory']:AddItem(source, item, amount) then
            return true
        else
            return false
        end
    end
end

function RemoveItem(source, item, amount, slot)

    if Config.Inventory == "ox" then
        if exports.ox_inventory:RemoveItem(source, item, amount, nil,  slot) then
            return true
        else
            return false
        end
    elseif Config.Core == "qbcore" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer.Functions.RemoveItem(item, amount, slot) then
            return true
        else
            return false
        end
    elseif Config.Core == "esx" and Config.Inventory == "qs" then
        if exports['qs-inventory']:RemoveItem(source, item, amount, slot) then
            return true
        else
            return false
        end
    end
end

CreateCallback("snipe-ownedshops:server:isDegradeValid", function(source, cb ,slot)
    if Config.Inventory == "ox" then
        local itemInfo = exports.ox_inventory:GetSlot(source, slot)
        if not itemInfo.metadata.degrade then 
            cb(true)
        else
            if itemInfo.metadata.durability == 0 then
                cb(false)
            elseif itemInfo.metadata.durability > Config.AllowedDurability and itemInfo.metadata.durability <= 100 then
                cb(true)
            elseif itemInfo.metadata.durability > 100 then
                local durability = itemInfo.metadata.durability
                local degrade = (itemInfo.metadata.degrade) * 60
                local percentage2 = ((durability - os.time()) * 100) / degrade
                if percentage2 > Config.AllowedDurability then
                    cb(true)
                end
            end
        end
    end
    cb(false)
end)


function ShowNotification(src, msg, type)
    if Config.Core == "qbcore" then
        TriggerClientEvent('QBCore:Notify', src, msg, type)
    elseif Config.Core == "esx" then
        TriggerClientEvent('esx:showNotification', src, msg)
    end
end


-- do not touch if you dont know what you are doing
CreateThread(function()
    if Config.Core == "esx" then
        jobs = ESX.GetJobs()
    end
end)


-- Event to check QBCore License

function HasItem(source, item)
    local src = source
    if Config.Core == "qbcore" and Config.Inventory ~= "ox" then
        local Player = QBCore.Functions.GetPlayer(source)
        local itemInfo = Player.Functions.GetItemByName(item)
        if itemInfo ~= nil then
            return true
        else
            return false
        end
    elseif Config.Inventory == "ox" then
        local itemCount = exports.ox_inventory:GetItem(source, item, nil, true)
        if itemCount >= 1 then
            return true
        else
            return false
        end
    end
end

CreateCallback('getLicenseStatus', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local licenseTable = Player.PlayerData.metadata["licences"]
    local licenseItem = HasItem(src, "weaponlicense")
    cb({licenseTable.weapon, licenseItem})
end)

function HasPerms(source)
    if GetResourceState("snipe-menu") == "started" then
        return exports["snipe-menu"]:isAdmin(source)
    end
    local returnValue = false
    for k, v in pairs(Config.Permissions) do
        local identifiers = GetPlayerIdentifiers(source)
        for _, id in pairs(identifiers) do
            if string.find(id, k) then
                return true
            end
        end
        if Config.Core == "esx" then
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer ~= nil then
                if xPlayer.identifier == k then
                    return true
                end
            end
        end
        if Config.Core == "qbcore" then
            local xPlayer = QBCore.Functions.GetPlayer(source)
            if xPlayer ~= nil then
                if xPlayer.PlayerData.citizenid == k then
                    return true
                end
            end
        end
    end
    return returnValue
end


function GetOfflinePlayerName(id)
    if Config.Core == "qbcore" then
        local player = MySQL.query.await('SELECT JSON_VALUE(players.charinfo, "$.firstname") as firstname, JSON_VALUE(players.charinfo, "$.lastname") as lastname FROM players WHERE citizenid = ?', {id})
        if player[1] ~= nil then
            return player[1].firstname .. " " .. player[1].lastname
        else
            return "Unknown"
        end
    elseif Config.Core == "esx" then
        local player = MySQL.query.await('SELECT firstname, lastname FROM users WHERE identifier = ?', {id})
        if player[1] ~= nil then
            return player[1].firstname .. " " .. player[1].lastname
        else
            return "Unknown"
        end
    end
end