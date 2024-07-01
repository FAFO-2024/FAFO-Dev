RegisterNetEvent("gksphone:server:musicListen", function (musicid, volume, action, time)
    debugprint("Music event", musicid, volume, action, time)
    local src = source
    if action == "play" then
        local getPlayerPed = GetPlayerPed(src)
        local getPlayerCoords = GetEntityCoords(getPlayerPed)
        TriggerClientEvent("gksphone:client:music", -1, action, musicid, volume, getPlayerCoords, src, time)
    elseif action == "volume" then
        TriggerClientEvent("gksphone:client:music", -1, action, nil, volume, nil, src)
    elseif action == "pause" or action == "resume" or action == "stop" or action == "stopcall" then
        print("Music action: " .. action)
        TriggerClientEvent("gksphone:client:music", -1, action,  nil, nil, nil, src)
    elseif action == "seek" then
        TriggerClientEvent("gksphone:client:music", -1, action, nil, nil, nil, src, time)
    elseif action == "call" then
        local getPlayerPed = GetPlayerPed(src)
        local getPlayerCoords = GetEntityCoords(getPlayerPed)
        TriggerClientEvent("gksphone:client:music", -1, action, musicid, volume, getPlayerCoords, src)
    else
        print("Invalid action: " .. action)
    end
end)