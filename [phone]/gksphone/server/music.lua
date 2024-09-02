local musicData = {}

RegisterNetEvent("gksphone:server:musicListen", function (musicid, volume, action, time)
    debugprint("Music event", {musicid, volume, action, time, source})
    local src = source
    if action == "play" then
        musicData[src] = "play"
        local getPlayerPed = GetPlayerPed(src)
        local getPlayerCoords = GetEntityCoords(getPlayerPed)
        TriggerClientEvent("gksphone:client:music", -1, action, musicid, volume, getPlayerCoords, src, time)
    elseif action == "volume" then
        TriggerClientEvent("gksphone:client:music", -1, action, nil, volume, nil, src)
    elseif action == "pause" or action == "resume" or action == "stop" or action == "stopcall" then
        if action == "stop" or action == "stopcall" then
            musicData[src] = nil
        end
        TriggerClientEvent("gksphone:client:music", -1, action,  nil, nil, nil, src)
    elseif action == "seek" then
        TriggerClientEvent("gksphone:client:music", -1, action, nil, nil, nil, src, time)
    elseif action == "call" then
        musicData[src] = "call"
        local getPlayerPed = GetPlayerPed(src)
        local getPlayerCoords = GetEntityCoords(getPlayerPed)
        TriggerClientEvent("gksphone:client:music", -1, action, musicid, volume, getPlayerCoords, src)
    elseif action == "musicNext" then
        TriggerClientEvent("gksphone:client:music", -1, action, musicid, nil, nil, src)
    end
end)

AddEventHandler('playerDropped', function (reason)
    local src = source
    if src then
        if musicData[src] then
            if musicData[src] == "play" then
                TriggerClientEvent("gksphone:client:music", -1, "stop",  nil, nil, nil, src)
            else
                TriggerClientEvent("gksphone:client:music", -1, "stopcall",  nil, nil, nil, src)
            end
        end
    end
end)