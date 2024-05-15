RegisterServerEvent("codem-minerjob:ProcessItems")
AddEventHandler("codem-minerjob:ProcessItems", function(data)
    local src = source
    local hasRequiredItems = true
    for _,v in pairs(data.requiredItems) do
        if not HasItem(src, {
            name = v.name,
            amount = 1
        }) then
            RemoveItem(src, v.name, 1)
            hasRequiredItems = false
        end
    end
    if hasRequiredItems then

        local hasItem = true
        if not HasItem(src, {
            name = data.fromItem.name,
            amount = 1
        }) then
            hasItem = false
        end
        if hasItem then
            for _,v in pairs(data.requiredItems) do
                RemoveItem(src, v.name, 1)
            end
            RemoveItem(src, data.fromItem.name, 1)
            AddInventoryItem(src, data.toItem.name, data.toItem.amount)
            TriggerClientEvent("codem-minerjob:AddItemLog", src, data.toItem.name)
            AddXP(src, Config.GiveXP.processOre)
        else
            TriggerClientEvent("codem-minerjob:Notify", src, locales.not_enough_items)
        end
    else
        TriggerClientEvent("codem-minerjob:Notify", src, locales.not_enough_items)
    end
end)
function CreateDailyMission()
    local missions = {}
    for _,v in pairs(Config.DailyMissions) do
        missions[_] = v
        missions[_].process = 0 
    end
    return missions
end

RegisterServerEvent("codem-minerjob:AddDailyMissionProcess")
AddEventHandler("codem-minerjob:AddDailyMissionProcess", function(key)
    local src = source
    local identifier = GetIdentifier(src)
    local playerData = GetPlayerJobData(identifier)
    if playerData then
        if playerData.dailyMissions.data[key].max > playerData.dailyMissions.data[key].process then
            playerData.dailyMissions.data[key].process = playerData.dailyMissions.data[key].process + 1
        end
        if  playerData.dailyMissions.data[key].process == playerData.dailyMissions.data[key].max then
             playerData.dailyMissions.data[key].process =  playerData.dailyMissions.data[key].max
              AddXP(src, playerData.dailyMissions.data[key].xp)
        end
        SyncPlayerDataByKey(src, "dailyMissions", playerData.dailyMissions)
        ExecuteSql("UPDATE codem_minerjob SET `dailyMissions` = '" .. json.encode(playerData.dailyMissions) .. "' WHERE `identifier` = '" .. identifier .. "'")

    end
end)

RegisterServerEvent('codem-minerjob:CheckDailyMission')
AddEventHandler('codem-minerjob:CheckDailyMission', function()
    local src = source
    local identifier = GetIdentifier(src)
    local playerData = GetPlayerJobData(identifier)
    if playerData then
        local diff = os.difftime(playerData.dailyMissions.resetAt, os.time())
        if diff <= 0 then
            playerData.dailyMissions.resetAt = os.time() + 86400
            playerData.dailyMissions.data = CreateDailyMission()
            ExecuteSql("UPDATE codem_minerjob SET `dailyMissions` = '" .. json.encode(playerData.dailyMissions) .. "' WHERE `identifier` = '" .. playerData.identifier .. "'")
            SyncPlayerDataByKey(src, "dailyMissions", playerData.dailyMissions)
        end
    end
end)

