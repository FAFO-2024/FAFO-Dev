QBCore, ESX = nil, nil

if Config.Framework == "qb" then
    QBCore = exports[Config.FrameworkTriggers["qb"].ResourceName]:GetCoreObject()
elseif Config.Framework == "esx" then
    local status, errorMsg = pcall(function() ESX = exports[Config.FrameworkTriggers["esx"].ResourceName]:getSharedObject() end)
    if (ESX == nil) then
        while ESX == nil do
            Wait(100)
            TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
        end
    end
end
