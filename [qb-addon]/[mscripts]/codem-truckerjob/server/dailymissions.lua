function CreateDailyMission()
    local missions = {}
    for _,v in pairs(Config.DailyMissions) do
        missions[_] = v
        missions[_].process = 0 
    end
    return missions
end

RegisterServerEvent("codem-truckerjob:AddDailyMissionProcess")
AddEventHandler("codem-truckerjob:AddDailyMissionProcess", function(key)
    local src = source
    local identifier = GetIdentifier(src)
    local playerData = GetPlayerJobData(src)
    if playerData then
        if playerData.dailymissions.data[key].max > playerData.dailymissions.data[key].process then
            playerData.dailymissions.data[key].process = playerData.dailymissions.data[key].process + 1
        end
        if  playerData.dailymissions.data[key].process == playerData.dailymissions.data[key].max then
             playerData.dailymissions.data[key].process =  playerData.dailymissions.data[key].max
              AddXP(src, playerData.dailymissions.data[key].xp)
        end
        SyncPlayerDataByKey(src, "dailymissions", playerData.dailymissions)
        ExecuteSql("UPDATE codem_truckerjob SET `dailymissions` = '" .. json.encode(playerData.dailymissions) .. "' WHERE `identifier` = '" .. identifier .. "'")

    end
end)

RegisterServerEvent('codem-truckerjob:CheckDailyMission')
AddEventHandler('codem-truckerjob:CheckDailyMission', function()
    local src = source
    local identifier = GetIdentifier(src)
    local playerData = GetPlayerJobData(src)
    if playerData then
        local diff = os.difftime(playerData.dailymissions.resetAt, os.time())
        if diff <= 0 then
            playerData.dailymissions.resetAt = os.time() + 86400
            playerData.dailymissions.data = CreateDailyMission()
            ExecuteSql("UPDATE codem_truckerjob SET `dailymissions` = '" .. json.encode(playerData.dailymissions) .. "' WHERE `identifier` = '" .. playerData.identifier .. "'")
            SyncPlayerDataByKey(src, "dailymissions", playerData.dailymissions)
        end
    end
end)
