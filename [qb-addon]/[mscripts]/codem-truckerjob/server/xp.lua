
function AddLevel(source)
    local identifier = GetIdentifier(source)
    local myData = GetPlayerJobData(source)
    if myData then
        myData.level = myData.level + 1
        if not Config.XP[myData.level] then
            myData.level = #Config.XP
            myData.xp = Config.XP[myData.level]
        else
            myData.xp = 0
        end
        for _,v in pairs(Config.Missions) do
            if v.reqLevel and myData.level == v.reqLevel then
                myData.unlockedMissions[tostring(v.id)] = true
            end
        end
        SyncPlayerDataByKey(source, "unlockedMissions", myData.unlockedMissions)
        SyncPlayerDataByKey(source, "xp", myData.xp)
        SyncPlayerDataByKey(source, "level", myData.level)
        ExecuteSql("UPDATE codem_truckerjob SET `level` = '" ..
            myData.level .. "', `xp` = '" ..
            myData.xp .. "', `unlockedMissions` = '"..json.encode(myData.unlockedMissions).."' WHERE `identifier` = '" .. identifier .. "'")
    end
end

-- RegisterCommand('addlevel', function(source, args)
--     for i=1, tonumber(args[1]) do
--         AddLevel(source)
--     end
-- end)


function AddXP(source, xp)
    local identifier = GetIdentifier(source)
    local myData = GetPlayerJobData(source) 
    if not xp and xp <= 0 then
        return
    end
    if myData then

        local level = myData.level
        if level == #Config.XP then
            myData.xp = 0
            return
        end
        myData.xp = tonumber(myData.xp) + tonumber(xp)
        if Config.XP[level] and myData.xp >= Config.XP[level] then
            local remainXp = Config.XP[level]-myData.xp
            AddLevel(source)
            if remainXp < 0 then
                AddXP(source, -(remainXp))
            end
        else
            SyncPlayerDataByKey(source, "xp", myData.xp)
        end
        ExecuteSql("UPDATE codem_truckerjob SET `level` = '" ..
            myData.level .. "', `xp` = '" ..
            myData.xp .. "' WHERE `identifier` = '" .. identifier .. "'")   
    end
end