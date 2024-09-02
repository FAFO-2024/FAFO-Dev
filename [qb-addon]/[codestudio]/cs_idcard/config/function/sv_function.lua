QBCore = exports['qb-core']:GetCoreObject()


function GiveCard(src, job, pfp)
    local info = {}
    local Player = QBCore.Functions.GetPlayer(src)
    info.citizenid = Player.PlayerData.citizenid
    info.firstname = Player.PlayerData.charinfo.firstname
    info.lastname = Player.PlayerData.charinfo.lastname
    info.birthdate = Player.PlayerData.charinfo.birthdate
    info.gender = Player.PlayerData.charinfo.gender
    info.pfp = pfp
    if CodeStudio.ID_Cards[tostring(job)] then
        item = CodeStudio.ID_Cards[job].useableItem
        if usingOX then
            info.description = ('Name: %s | ID: %s'):format(Player.PlayerData.charinfo.firstname, CodeStudio.ID_Cards[job].menuName)
        end
    elseif CodeStudio.Job_Cards[tostring(job)] then
        info.job = Player.PlayerData.job.label
        info.rank = Player.PlayerData.job.grade.name
        item = CodeStudio.Job_Cards[job].useableItem
        if usingOX then
            info.description = ('Name: %s | ID: %s'):format(Player.PlayerData.charinfo.firstname, CodeStudio.Job_Cards[job].menuName)
        end
    else
        return
    end
    if CodeStudio.UseMetaData then
        if usingOX then
            exports.ox_inventory:AddItem(src, item, 1, info)
        elseif usingQS then
            exports['qs-inventory']:AddItem(src, item, 1, false, info)
        else
            Player.Functions.AddItem(item, 1, nil, info)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item], "add", 1)
        end
    else
        if usingOX then
            exports.ox_inventory:AddItem(src, item, 1)
        else
            Player.Functions.AddItem(item, 1, nil)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item], "add", 1)
        end
    end
end




for k, v in pairs(CodeStudio.Job_Cards) do
    QBCore.Functions.CreateUseableItem(tostring(v.useableItem), function(source, item)
        local src = source
        local PlayerPed = GetPlayerPed(src)
        local PlayerCoords = GetEntityCoords(PlayerPed)

        for _, ply in pairs(QBCore.Functions.GetPlayers()) do
            local TargetPed = GetPlayerPed(ply)
            local dist = #(PlayerCoords - GetEntityCoords(TargetPed))
            if dist < 3.0 and PlayerPed ~= TargetPed then
                if CodeStudio.UseMetaData then
                    if usingOX then
                        TriggerClientEvent('cs:idcard:useJobCard', ply, item.metadata, k, src)
                    else
                        TriggerClientEvent('cs:idcard:useJobCard', ply, item.info, k, src)
                    end
                else
                    TriggerClientEvent('cs:idcard:useJobCard', ply, QBCore.Functions.GetPlayer(src).PlayerData, k, src) 
                end
                break
            end
        end

        if CodeStudio.UseMetaData then
            if usingOX then
                TriggerClientEvent('cs:idcard:useJobCard', src, item.metadata, k, src)
            else
                TriggerClientEvent('cs:idcard:useJobCard', src, item.info, k, src) 
            end
        else
            TriggerClientEvent('cs:idcard:useJobCard', src, QBCore.Functions.GetPlayer(src).PlayerData, k, src) 
        end
    end)
    if GetResourceState('qb-inventory') == 'started' then
        if not QBCore.Shared.Items[v.useableItem] then print("Item check - '"..tostring(v.useableItem).."' not found in the shared lua") end
    end
end


for k, v in pairs(CodeStudio.ID_Cards) do
    if v.enable then
        QBCore.Functions.CreateUseableItem(tostring(v.useableItem), function(source, item) 
            local src = source
            local PlayerPed = GetPlayerPed(src)
            local PlayerCoords = GetEntityCoords(PlayerPed)

            for _, ply in pairs(QBCore.Functions.GetPlayers()) do
                local TargetPed = GetPlayerPed(ply)
                local dist = #(PlayerCoords - GetEntityCoords(TargetPed))
                if dist < 3.0 and PlayerPed ~= TargetPed then
                    if CodeStudio.UseMetaData then
                        if usingOX then
                            if item.metadata.firstname then
                                TriggerClientEvent('cs:idcard:useIDCard', ply, item.metadata, k, src)
                            else
                                print("METADATA NOT FOUND FOR THIS CARD, ARE YOU TRYING TO SPAWN CARD DIRECTLY?")
                            end
                        else
                            if item.info.firstname then
                                TriggerClientEvent('cs:idcard:useIDCard', ply, item.info, k, src)
                            else
                                print("METADATA NOT FOUND FOR THIS CARD, ARE YOU TRYING TO SPAWN CARD DIRECTLY?")
                            end
                        end
                    else
                        TriggerClientEvent('cs:idcard:useIDCard', ply, QBCore.Functions.GetPlayer(src).PlayerData, k, src) 
                    end
                    break
                end
            end

            if CodeStudio.UseMetaData then
                if usingOX then
                    if item.metadata.firstname then
                        TriggerClientEvent('cs:idcard:useIDCard', src, item.metadata, k, src)
                    else
                        print("METADATA NOT FOUND FOR THIS CARD, ARE YOU TRYING TO SPAWN CARD DIRECTLY?")
                    end
                else
                    if item.info.firstname then
                        TriggerClientEvent('cs:idcard:useIDCard', src, item.info, k, src)
                    else
                        print("METADATA NOT FOUND FOR THIS CARD, ARE YOU TRYING TO SPAWN CARD DIRECTLY?")
                    end 
                end
            else
                TriggerClientEvent('cs:idcard:useIDCard', src, QBCore.Functions.GetPlayer(src).PlayerData, k, src) 
            end
        end)
        if GetResourceState('qb-inventory') == 'started' then
            if not QBCore.Shared.Items[k] then print("Item check - '"..tostring(k).."' not found in the shared lua") end
        end
    end
end
