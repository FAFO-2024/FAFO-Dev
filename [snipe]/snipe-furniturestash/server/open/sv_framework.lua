QBCore, ESX = nil, nil
disabled = false

if Config.Framework == "qb" then
    TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
    if QBCore == nil then
        QBCore = exports[Config.FrameworkTriggers["qb"].ResourceName]:GetCoreObject()
    end
elseif Config.Framework == "esx" then
    local status, errorMsg = pcall(function() ESX = exports[Config.FrameworkTriggers["esx"].ResourceName]:getSharedObject() end)
    -- ESX = exports[Config.FrameworkTriggers["esx"].ResourceName]:getSharedObject()
    if (ESX == nil) then
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
else
    print("Framework not found")
    disabled = true
end

function GetPlayerFrameworkIdentifier(id)
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(id)
        return Player.PlayerData.citizenid
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(id)
        return xPlayer.identifier
    end
end

function HasMoney(source, amount, type)
    
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player.PlayerData.money[type] >= amount then
            return true
        else
            return false
        end
        
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if type == "cash" then
            
            if xPlayer.getMoney() >= amount then
                return true
            else
                return false
            end
        elseif type == "bank" then
            if xPlayer.getAccount("bank").money >= amount then
                return true
            else
                return false
            end
        end
    end
end

function AddMoney(source, amount, type)
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.AddMoney(type, amount)
        return true
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if type == "cash" then
            xPlayer.addMoney(amount)
            return true
        elseif type == "bank" then
            xPlayer.addAccountMoney("bank", amount)
            return true
        end
    end
end

function RemoveMoney(source, amount, type)
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.RemoveMoney(type, amount)
        return true
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if type == "cash" then
            xPlayer.removeMoney(amount)
            return true
        elseif type == "bank" then
            xPlayer.removeAccountMoney("bank", amount)
            return true
        end
    end
end