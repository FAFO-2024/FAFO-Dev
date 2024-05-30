
-- 'QB' = For QBCore Framework
-- 'ESX' = For ESX Framework
-- false = For Standalone

CodeStudio.ServerType = false


if CodeStudio.ServerType == "QB" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif CodeStudio.ServerType == "ESX" then
    ESX = exports['es_extended']:getSharedObject()
end



---EDIT THIS AS PER YOUR SERVER NEEDS---


if CodeStudio.OpenUI.useItem then 
    if CodeStudio.ServerType == 'ESX' then
        ESX.RegisterUsableItem(CodeStudio.OpenUI.Item_Name, function(source)
            TriggerClientEvent('cs:drunk:openUI', source)
        end)
    elseif CodeStudio.ServerType == 'QB' then
        QBCore.Functions.CreateUseableItem(CodeStudio.OpenUI.Item_Name, function(source)
            TriggerClientEvent('cs:drunk:openUI', source)
        end)
    else
        --YOU CAN ADD YOUR CUSTOM EVENTS HERE
    end
end