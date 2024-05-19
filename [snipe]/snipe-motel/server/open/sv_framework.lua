QBCore, ESX = nil, nil
if Config.Framework == "qb" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == "esx" then
    ESX = exports['es_extended']:getSharedObject()
elseif Config.Framework == "ox" then
    local file = ('imports/%s.lua'):format(IsDuplicityVersion() and 'server' or 'client')
    local import = LoadResourceFile('ox_core', file)
    local chunk = assert(load(import, ('@@ox_core/%s'):format(file)))

    chunk()
end

function getPlayerIdentifier(id)
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(tonumber(id))
        if Player ~= nil then
            return Player.PlayerData.citizenid
        end
        return nil
    elseif Config.Framework == "esx" then
        local Player = ESX.GetPlayerFromId(tonumber(id))
        if Player ~= nil then
            return Player.identifier
        end
        return nil
    elseif Config.Framework == "ox" then
        local player = Ox.GetPlayer(id)

        if player ~= nil then
            return player.charId
        end
        return nil
    else
        local identifier = GetPlayerIdentifiers(id)
        -- get the license
        for _, v in pairs(identifier) do
            if string.find(v, "license") then
                return v
            end
        end
        return nil
    end
end

function RemoveMoney(source, amount)
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(tonumber(source))
        if Player ~= nil then
            if Player.Functions.RemoveMoney(Config.MoneyType, amount) then
                return true
            else
                return false
            end
        end
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(tonumber(source))
        if xPlayer ~= nil then
            if Config.MoneyType == "cash" then
                if xPlayer.getMoney() >= amount then
                    xPlayer.removeMoney(amount)
                    return true
                else
                    return false
                end
            elseif Config.MoneyType == "bank" then
                if xPlayer.getAccount("bank").money then
                    xPlayer.removeAccountMoney("bank", amount)
                    return true
                else
                    return false
                end
            end
        else
            return false
        end
    elseif Config.Framework == "ox" then -- only type cash is supported for ox because there is no banking for ox
        return exports.ox_inventory:RemoveItem(source, 'money', amount)
    elseif Config.Framework == "other" then
        return true
    end
end

function AddMoney(source, amount)
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(tonumber(source))
        if Player ~= nil then
            Player.Functions.AddMoney(Config.MoneyType, amount)
        end
        
    elseif Config.Framework == "esx" then
        local Player = ESX.GetPlayerFromId(tonumber(source))
        if Player ~= nil then
            Player.addAccountMoney(Config.MoneyType, money)
        end
    elseif Config.Framework == "ox" then -- only type cash is supported for ox because there is no banking for ox
        return exports.ox_inventory:AddItem(source, 'money', amount) 
    elseif Config.Framework == "other" then
        return true
    end
end

function GetName(source)
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(tonumber(source))
        return Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
        
    elseif Config.Framework == "esx" then
        local Player = ESX.GetPlayerFromId(tonumber(source))
        return Player.getName()
    elseif Config.Framework == "ox" then -- only type cash is supported for ox because there is no banking for ox
        return GetPlayerName(source) -- need to find the way to get name in ox
    elseif Config.Framework == "other" then
        return GetPlayerName(source)
    end
end

lib.callback.register("snipe-apartments:server:getRoomNumber", function(source, id)
    return exports["snipe-motel"]:currentPlayerRoom(id)
end)

lib.callback.register("snipe-apartments:server:lockdownRoom", function(source, roomno, state)
    Locations[roomno].lockdown = state
    UpdateDoorLock(Config.DoorIdPrefix..""..roomno, false, true)
    TriggerClientEvent("snipe-apartments:client:lockdownRoom", -1, roomno, state)
    SendLogs("lockdown", source, "Room "..roomno.." is now "..(state and "locked down" or "unlocked").." by "..GetPlayerName(source).."("..source..")", state)
    return true
end)