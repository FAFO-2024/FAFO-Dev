CreateCallback("snipe-menu:server:fetchPlayerListCustom", function(source, cb)
    local players = {}
    for _, player in ipairs(GetPlayers()) do
        table.insert(players, {
            id = player,
            name = GetPlayerName(player)
        })
    end
    cb(players)
end)

CreateCallback("snipe-menu:server:getAllVehiclesOwnedByPlayers", function(source, cb)
    local returnData = {}
    if Config.Core == "QBCore" then
        query = 'SELECT citizenid as cid, plate FROM '..Config.GarageTables[Config.Core].vehicle_table
    elseif Config.Core == "ESX" then
        query = 'SELECT owner as cid, plate FROM '..Config.GarageTables[Config.Core].vehicle_table
    end

    local result = MySQL.query.await(query)
    if result ~= nil then
        for k, v in pairs(result) do
            returnData[#returnData + 1] = {
                id = k,
                name = v.plate,
            }
        end
        cb(returnData)
    else
        cb(nil)
    end
end)

RegisterServerEvent("snipe-menu:server:removeVehicle", function(plate)
    local src = source
    if onlineAdmins[src] then
        if Config.Core == "QBCore" then
            query = 'DELETE FROM '..Config.GarageTables[Config.Core].vehicle_table..' WHERE plate = @plate'
        elseif Config.Core == "ESX" then
            query = 'DELETE FROM '..Config.GarageTables[Config.Core].vehicle_table..' WHERE plate = @plate'
        end
        local result = MySQL.Async.execute(query, {
            ['@plate'] = plate
        }, function(rowsChanged)
            print("Wiped "..rowsChanged.." row from "..Config.GarageTables[Config.Core].vehicle_table)
        end)
    end
end)

RegisterNetEvent('snipe-menu:server:PutPlayerInVehicle', function(playerId)
    local src = source
    if playerId == 0 then
        playerId = source
    end
    
    if onlineAdmins[src] then
        local EscortPlayer = QBCore.Functions.GetPlayer(playerId)

        TriggerClientEvent("snipe-menu:client:PutInVehicle", EscortPlayer.PlayerData.source)
    else
        print("triggering event")
    end
end)