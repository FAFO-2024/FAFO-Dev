function ShowNotification(source, msg, type)
    if Config.Notify == "qb" then
        TriggerClientEvent('QBCore:Notify', source, msg, type)
    elseif Config.Notify == "ox" then
        TriggerClientEvent('ox_lib:notify', source, {type = type, description = msg})
    elseif Config.Notify == "esx" then
        TriggerClientEvent('esx:showNotification', source, msg)
    elseif Config.Notify == "okok" then
        TriggerClientEvent('okokNotify:Alert', source, "Bundles", msg, 5000, type)
    end
end

RegisterNetEvent("snipe-furniturestash:server:registerStash", function(stashId, inventory, item)
    if inventory == "ox" then
        exports.ox_inventory:RegisterStash(stashId, "Furniture Stash", Config.FurnitureStash[item].slot, Config.FurnitureStash[item].size)
    end
end)