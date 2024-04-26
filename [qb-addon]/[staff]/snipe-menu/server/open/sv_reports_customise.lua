
RegisterNetEvent("snipe-menu:server:toggleReports", function()
    local src = source
    if not hideNoti[src] then
        hideNoti[src] = true
        ShowNotification(src, "You will no longer get report notifications", "error")
    else
        hideNoti[src] = nil
        ShowNotification(src, "You will now get report notifications", "success")
    end
end)

function GetPlayerGameIdentifier(playerId)
    if Config.Core == "QBCore" then
        local player = QBCore.Functions.GetPlayer(playerId)
        if player ~= nil then
            return player.PlayerData.citizenid
        else
            return "Unknown"
        end
    elseif Config.Core == "ESX" then
        local player = ESX.GetPlayerFromId(playerId)
        if player ~= nil then
            return player.identifier
        else
            return "Unknown"
        end
    else
        return "Unknown"
    end
end