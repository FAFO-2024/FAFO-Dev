if CodeStudio.ServerType == "QB" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif CodeStudio.ServerType == "ESX" then
    ESX = exports['es_extended']:getSharedObject()
end



--[RECORDING FEEATURE] If you are using Fivemanage or Fivemerr then put api key here otherwise put discord webhook  *[PROTECTED]

lib.callback.register('cs:bodycam:fetchWebhookAPI', function(source)
    local WebhookAPI = 'https://discord.com/api/webhooks/1276659270103859394/me8gxfeuVuWHT3um-o5in1n2uFKo5dXjg6hYBnc8njGCaszEBHx7n2sbz74SIp-fbmR2'
    return WebhookAPI
end)





function GetIdentifier(source)
    if CodeStudio.ServerType == 'QB' then
        local Player = QBCore.Functions.GetPlayer(source)
        local ident = Player.PlayerData.citizenid
        return ident
    elseif CodeStudio.ServerType == 'ESX' then
        local Player = ESX.GetPlayerFromId(source)
        local ident = Player.identifier
        return ident
    else
        return GetPIdentifier(source, 'license')
    end
end


function GetPlayerRealName(source)
    if CodeStudio.ServerType == 'QB' then
        local Player = QBCore.Functions.GetPlayer(source)
        local Name = Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname
        return Name
    elseif CodeStudio.ServerType == 'ESX' then
        local Player = ESX.GetPlayerFromId(source)
        local Name = Player.getName()
        return Name
    else
        return GetPlayerName(source)
    end
end

function GetPlayerJob(source)
    if CodeStudio.ServerType == 'QB' then
        local Player = QBCore.Functions.GetPlayer(source)
        local Job = Player.PlayerData.job.name
        local Grade = Player.PlayerData.job.grade.level
        local GradeLabel = Player.PlayerData.job.grade.name
        return Job, Grade, GradeLabel
    elseif CodeStudio.ServerType == 'ESX' then
        local Player = ESX.GetPlayerFromId(source)
        local Job = Player.job.name
        local Grade = Player.job.grade
        local GradeLabel = Player.job.grade_label
        return Job, Grade, GradeLabel
    end
end



if CodeStudio.BodyCam.Use.WithItem then
    local itemName = CodeStudio.BodyCam.Use.ItemName
    if CodeStudio.ServerType == 'QB' then
        QBCore.Functions.CreateUseableItem(itemName, function(source, item)
            TriggerClientEvent('cs:bodycam:useBodyCam', source)
        end)
    elseif CodeStudio.ServerType == 'ESX' then
        ESX.RegisterUsableItem(itemName, function(source)
            TriggerClientEvent('cs:bodycam:useBodyCam', source)
        end)
    else
        --Standlone [You can Edit this accoirdingly] --
    end
end

if CodeStudio.DashCam.Use.WithItem then
    local itemName = CodeStudio.DashCam.Use.ItemName
    if CodeStudio.ServerType == 'QB' then
        QBCore.Functions.CreateUseableItem(itemName, function(source, item)
            TriggerClientEvent('cs:bodycam:useDashCam', source)
        end)
    elseif CodeStudio.ServerType == 'ESX' then
        ESX.RegisterUsableItem(itemName, function(source)
            TriggerClientEvent('cs:bodycam:useDashCam', source)
        end)
    else
        --Standlone [You can Edit this accoirdingly] --
    end
end


function DashCamState(source, active)
    if not CodeStudio.DashCam.Use.RemoveItemOnUse then return end
    local itemName = CodeStudio.DashCam.Use.ItemName
    if active then
        if GetResourceState('ox_inventory') == 'started' then
            exports['ox_inventory']:RemoveItem(source, itemName, 1)
        elseif GetResourceState('qs-inventory') == 'started' then
            exports['qs-inventory']:RemoveItem(source, itemName, 1, false)
        else
            if CodeStudio.ServerType == 'QB' then
                local Player = QBCore.Functions.GetPlayer(source)
                Player.Functions.RemoveItem(itemName, 1)
            elseif CodeStudio.ServerType == 'ESX' then
                local Player = ESX.GetPlayerFromId(source)
                Player.removeInventoryItem(itemName, 1)
            end
        end
    else
        if GetResourceState('ox_inventory') == 'started' then
            exports['ox_inventory']:AddItem(source, itemName, 1)
        elseif GetResourceState('qs-inventory') == 'started' then
            exports['qs-inventory']:AddItem(source, itemName, 1, false)
        else
            if CodeStudio.ServerType == 'QB' then
                local Player = QBCore.Functions.GetPlayer(source)
                Player.Functions.AddItem(itemName, 1)
            elseif CodeStudio.ServerType == 'ESX' then
                local Player = ESX.GetPlayerFromId(source)
                Player.addInventoryItem(itemName, 1)
            end
        end
    end
end
