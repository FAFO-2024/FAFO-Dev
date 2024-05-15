

function AddLevel(source)
    local identifier = GetIdentifier(source)
    local myData = GetPlayerJobData(identifier)
    if myData then
        myData.level = myData.level + 1
        if not Config.XP[myData.level] then
            myData.level = #Config.XP
            myData.xp = Config.XP[myData.level]
        else
            myData.xp = 0
        end
        SyncPlayerDataByKey(source, "xp", myData.xp)
        SyncPlayerDataByKey(source, "level", myData.level)
        ExecuteSql("UPDATE codem_minerjob SET `level` = '" ..
            myData.level .. "', `xp` = '" ..
            myData.xp .. "' WHERE `identifier` = '" .. identifier .. "'")
    end
end

function RemoveLevel(source)
    local identifier = GetIdentifier(source)
    local myData = GetPlayerJobData(identifier)
    if myData then
        myData.level = myData.level - 1
        if myData.level <= 0 then
            myData.level = 1
        end
        myData.xp = 0
        SyncPlayerDataByKey(source, "xp", myData.xp)
        SyncPlayerDataByKey(source, "level", myData.level)
        ExecuteSql("UPDATE codem_minerjob SET `level` = '" ..
            myData.level .. "', `xp` = '" ..
            myData.xp .. "' WHERE `identifier` = '" .. identifier .. "'")
    end
end
function RemoveXP(source, xp)
    local identifier = GetIdentifier(source)
    local myData = GetPlayerJobData(identifier)
    if not xp and xp <= 0 then
        return
    end
    if myData then
        myData.xp = tonumber(myData.xp) - tonumber(xp)
        if myData.xp < 0 then
            RemoveLevel(source)
        else
            --ExecuteSql(string.format("UPDATE `codem_battlepass_data` SET xp = %d WHERE identifier='%s'", myData.xp, identifier))
            SyncPlayerDataByKey(source, "xp", myData.xp)
            SyncPlayerDataByKey(source, "level", myData.level)
        
        end
        ExecuteSql("UPDATE codem_minerjob SET `level` = '" ..
            myData.level .. "', `xp` = '" ..
            myData.xp .. "' WHERE `identifier` = '" .. identifier .. "'")   
    end
end



function AddXP(source, xp)
    local identifier = GetIdentifier(source)
    local myData = GetPlayerJobData(identifier) 
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
     
    end
end