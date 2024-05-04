if Config.Framework == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()

    function GetPlayer(source)
        return QBCore.Functions.GetPlayer(tonumber(source))
    end

    function CreateUseableItem(name, cb)
        if Config.UsedInventory == 'qs' then
            exports['qs-inventory']:CreateUsableItem(name, cb)
        else
            QBCore.Functions.CreateUseableItem(name, cb)
        end
    end

    function GetIdentifier(source)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer then
            return xPlayer.PlayerData.citizenid
        end
    end

    function ClearInventory(Player)
        if Config.UsedInventory == 'qs' then
            exports['qs-inventory']:ClearInventory(Player.PlayerData.source)
        elseif Config.UsedInventory == 'ox' then
            exports.ox_inventory:ClearInventory(Player.PlayerData.source, {'iphone'})
        else
            Player.Functions.ClearInventory()
        end
        MySQL.update('UPDATE players SET inventory = ? WHERE citizenid = ?', { json.encode({}), Player.PlayerData.citizenid })
    end

    RegisterServerEvent("osp_ambulance:addItem")
    AddEventHandler("osp_ambulance:addItem", function(name, amount)
        if amount == nil then amount = 1 end
        local src = source
        local player = QBCore.Functions.GetPlayer(src)
        if Config.UsedInventory == 'qs' then
            exports['qs-inventory']:AddItem(src, name, amount)
        else
            player.Functions.AddItem(name, amount)
        end
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[name], "add")
    end)

    RegisterServerEvent("osp_ambulance:removeItem")
    AddEventHandler("osp_ambulance:removeItem", function(name, amount)
        if amount == nil then amount = 1 end
        local src = source
        local player = QBCore.Functions.GetPlayer(src)
        if Config.UsedInventory == 'qs' then
            exports['qs-inventory']:RemoveItem(src, name, amount)
        else
            player.Functions.RemoveItem(name, amount)
        end
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[name], "remove")
    end)

    lib.callback.register('osp_ambulance:CheckMoney', function(source, data)
        local src = source
        local player = QBCore.Functions.GetPlayer(src)
        local currentCash = player.Functions.GetMoney('bank')
        return currentCash
    end)

    RegisterServerEvent("osp_ambulance:RemoveMoney")
    AddEventHandler("osp_ambulance:RemoveMoney", function(amount, source)
        local src = source
        local player = QBCore.Functions.GetPlayer(src)
        if player then
            player.Functions.RemoveMoney('bank', amount)
        end
    end)

    RegisterServerEvent("osp_ambulance:AddMoney")
    AddEventHandler("osp_ambulance:AddMoney", function(amount)
        local src = source
        local player = QBCore.Functions.GetPlayer(src)
        player.Functions.AddMoney('cash', amount)
    end)


    -- Commands

    QBCore.Commands.Add('911ems', lang.info.ems_report, {{name = 'message', help = lang.info.message_sent}}, false, function(source, args)
        local src = source
        local message
        if args[1] then message = table.concat(args, " ") else message = lang.info.civ_call end
        local ped = GetPlayerPed(src)
        local coords = GetEntityCoords(ped)
        local players = QBCore.Functions.GetQBPlayers()
        for _, v in pairs(players) do
            for _,x in pairs(Config.AmbulanceJobs) do
                if v.PlayerData.job.name == x and v.PlayerData.job.onduty then
                    TriggerClientEvent('hospital:client:ambulanceAlert', v.PlayerData.source, coords, message)
                end
            end
        end
    end)

    QBCore.Commands.Add("revive", lang.info.revive_player_a, {{name = "id", help = lang.info.player_id}}, false, function(source, args)
        local src = source
        if args[1] then
            local Player = GetPlayer(tonumber(args[1]))
            if Player then
                TriggerClientEvent('hospital:client:Revive', Player.PlayerData.source)
            else
                TriggerClientEvent('osp_ambulance:SendTextMessage', src, 'Chat', 'Player was not online', 3000, 'error')
            end
        else
            TriggerClientEvent('hospital:client:Revive', src)
        end
    end, "admin")


    QBCore.Commands.Add("kill", lang.info.kill, {{name = "id", help = lang.info.player_id}}, false, function(source, args)
        local src = source
        if args[1] then
            local Player = GetPlayer(tonumber(args[1]))
            if Player then
                TriggerClientEvent('hospital:client:KillPlayer', Player.PlayerData.source)
            else
                TriggerClientEvent('osp_ambulance:SendTextMessage', src, 'Chat', 'Player was not online', 3000, 'error')
            end
        else
            TriggerClientEvent('hospital:client:KillPlayer', src)
        end
    end, "admin")

    lib.callback.register('osp_ambulance:getWoundData', function(source, data)
        if source == nil then return end
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local sqlQuery = [[
            SELECT `woundData` FROM players WHERE `citizenid` = @citizenid
        ]]
        local callbackData = nil
        
        MySQL.Async.fetchAll(sqlQuery, {
            ['@citizenid'] = Player.PlayerData.citizenid
        },function(response)
            local woundData = nil
            if response[1] and response[1].woundData then
                woundData = json.decode(response[1].woundData)
            else
                woundData = false
            end
            callbackData = woundData
        end)

        while callbackData == nil do
            Citizen.Wait(10)
        end
        return callbackData
    end)

    lib.callback.register('osp_ambulance:getInventory', function(source, data)
        local Player = GetPlayer(source)
        local inventory = nil
        if Config.UsedInventory == 'qs' then
            inventory = exports['qs-inventory']:GetInventory(source)
        elseif Config.UsedInventory == 'ox' then
            inventory = exports.ox_inventory:GetInventoryItems(source)
        else
            inventory = Player.PlayerData.items
        end
        return inventory
    end)

    RegisterServerEvent("osp_ambulance:saveWoundDataSv")
    AddEventHandler("osp_ambulance:saveWoundDataSv", function(data)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        -- print('Player saving data dead:', data.isDead, data.inLastStand, Player.PlayerData.citizenid)
        if Player then 
            MySQL.Async.execute('UPDATE players SET woundData = @woundData WHERE citizenid = @citizenid', {
                ['@woundData'] = json.encode(data),
                ['@citizenid'] = Player.PlayerData.citizenid,
            }, function()
            end)
        end
    end)

    RegisterNetEvent('hospital:server:SetDeathStatus', function(isDead) -- Used to set the death status of a player, used by other qbcore scripts for easy intregration
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            Player.Functions.SetMetaData("isdead", isDead)
        end
        if isDead then
            TriggerClientEvent('osp_ambulance:OnPlayerDead', src)
        else
            TriggerClientEvent('osp_ambulance:OnPlayerSpawn', src)
        end 
    end)
    
    RegisterNetEvent('hospital:server:SetLaststandStatus', function(bool) -- Used to set the laststand status of a player, used by other qbcore scripts for easy intregration
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            Player.Functions.SetMetaData("inlaststand", bool)
        end
        if bool then
            TriggerClientEvent('osp_ambulance:OnPlayerDead', src)
        else
            TriggerClientEvent('osp_ambulance:OnPlayerSpawn', src)
        end 
    end)

    RegisterNetEvent('hospital:server:resetHungerThirst', function()
        local Player = QBCore.Functions.GetPlayer(source)
    
        if not Player then return end
    
        Player.Functions.SetMetaData('hunger', 100)
        Player.Functions.SetMetaData('thirst', 100)
    
        TriggerClientEvent('hud:client:UpdateNeeds', source, 100, 100)
    end)

    RegisterNetEvent('osp_ambulance:registerStash', function(stashid)
        if Config.UsedInventory == 'ox' then
            exports.ox_inventory:RegisterStash(stashid, 'Ambulance Stash', 20, 20000, true)
        end
    end)


elseif Config.Framework == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()

    function GetPlayer(source)
        return ESX.GetPlayerFromId(source)
    end

    function CreateUseableItem(name, cb)
        if Config.UsedInventory == 'qs' then
            exports['qs-inventory']:CreateUsableItem(name, cb)
        else
            ESX.RegisterUsableItem(name, cb)
        end
    end

    function GetIdentifier(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            return xPlayer.identifier
        end
    end

    function ClearInventory(Player)
        if Config.UsedInventory == 'qs' then
            exports['qs-inventory']:ClearInventory(Player.source)
        elseif Config.UsedInventory == 'ox' then
            exports.ox_inventory:ClearInventory(Player.source, {'iphone'})
        else
            for i = 1, #Player.inventory, 1 do
                if Player.inventory[i].count > 0 then
                    Player.setInventoryItem(Player.inventory[i].name, 0)
                end
            end
        end
    end

    RegisterServerEvent("osp_ambulance:addItem")
    AddEventHandler("osp_ambulance:addItem", function(item, amount)
        local src = source
        local player = GetPlayer(source)
        if Config.UsedInventory == 'qs' then
            exports['qs-inventory']:AddItem(src, item, amount)
        else
            player.addInventoryItem(item, amount)
        end
    end)

    RegisterServerEvent("osp_ambulance:removeItem")
    AddEventHandler("osp_ambulance:removeItem", function(name, amount)
        local src = source
        local player = GetPlayer(source)
        if Config.UsedInventory == 'qs' then
            exports['qs-inventory']:RemoveItem(src, name, amount)
        else
            player.removeInventoryItem(name, amount)
        end
    end)

    lib.callback.register('osp_ambulance:CheckMoney', function(source, data)
        local src = source
        local player = GetPlayer(source)
        local currentCash = player.getAccount('bank').money
        return currentCash
    end)

    lib.callback.register('osp_ambulance:getName', function(source, data)
		local player = GetPlayer(source)
        while not player do
            Citizen.Wait(100)
            player = GetPlayer(source)
        end
        while not player.identifier do
            Citizen.Wait(100)
        end
		local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM `users` WHERE identifier = @identifier', {
		    ['@identifier'] = player.identifier
		})
		if result[1] and result[1].firstname and result[1].lastname then
			return {firstname = result[1].firstname, lastname = result[1].lastname}
		end
    end)

    RegisterServerEvent("osp_ambulance:RemoveMoney")
    AddEventHandler("osp_ambulance:RemoveMoney", function(amount, source)
        local src = source
        local player = GetPlayer(src)
        if player then
            player.removeAccountMoney('bank', tonumber(amount))
        end
    end)

    RegisterServerEvent("osp_ambulance:AddMoney")
    AddEventHandler("osp_ambulance:AddMoney", function(amount)
        local src = source
        local player = GetPlayer(source)
        player.addMoney(amount)
    end)


    -- Commands

    ESX.RegisterCommand('911ems', 'user', function(xPlayer, args, showError)
        local src = xPlayer.source
        local message
        if args[1] then message = table.concat(args, " ") else message = lang.info.civ_call end
        local ped = GetPlayerPed(src)
        local coords = GetEntityCoords(ped)
        local serverPlayers = GetPlayers()
        for k,v in pairs(serverPlayers) do
            local Player = GetPlayer(k)
            if Player then
                for _,x in pairs(Config.AmbulanceJobs) do
                    if Player.job.name == x then
                        TriggerClientEvent('hospital:client:ambulanceAlert', v, coords, message)
                    end
                end
            end
        end
    end, false, {help = lang.info.message_sent})

    ESX.RegisterCommand('revive', 'admin', function(xPlayer, args, showError)
        if args.id then
            TriggerClientEvent('hospital:client:Revive', args.id)
        else
            TriggerClientEvent('hospital:client:Revive', xPlayer.source)
        end
    end, true, {help = 'revive', validate = true, arguments = {
        {name = 'id', help = 'The player id', type = 'number'}
    }})

    ESX.RegisterCommand('kill', 'admin', function(xPlayer, args, showError)
        local src = xPlayer.source
        if args.id  then
            local Player = GetPlayer(args.id)
            if Player then
                TriggerClientEvent('hospital:client:KillPlayer', args.id)
            else
                TriggerClientEvent('osp_ambulance:SendTextMessage', src, 'Chat', 'Player was not online', 3000, 'error')
            end
        else
            TriggerClientEvent('hospital:client:KillPlayer', src)
        end
    end, false, {help = 'kill', validate = false, arguments = {
        {name = 'id',validate = false, help = 'kill', type = 'number'}
    }}) 

    lib.callback.register('osp_ambulance:getWoundData', function(source, data)
        local src = source
        local Player = GetPlayer(source)
        if not Player then
            print("Error: Invalid player data or identifier.")
            return
        end
        local sqlQuery = [[
            SELECT `woundData` FROM users WHERE `identifier` = @identifier
        ]]
        
        local callbackData = nil
        
        MySQL.Async.fetchAll(sqlQuery, {
            ['@identifier'] = Player.identifier
        },function(response)
            local woundData = nil
            if response[1] and response[1].woundData then
                woundData = json.decode(response[1].woundData)
            else
                woundData = false
            end
            callbackData = woundData
        end)

        while callbackData == nil do
            Citizen.Wait(10)
        end
        return callbackData
    end)
    
    lib.callback.register('osp_ambulance:getInventory', function(source, data)
        local Player = GetPlayer(source)
        local inventory = nil
        if Config.UsedInventory == 'qs' then
            inventory = exports['qs-inventory']:GetInventory(source)
        elseif Config.UsedInventory == 'ox' then
            inventory = exports.ox_inventory:GetInventoryItems(source)
        else
            inventory = Player.getInventory()
        end
        return inventory
    end)

    RegisterServerEvent("osp_ambulance:saveWoundDataSv")
    AddEventHandler("osp_ambulance:saveWoundDataSv", function(data)
        local src = source
        local Player = GetPlayer(source)
        if not Player then
            print("Error: Invalid player data or identifier.")
            return
        end
        MySQL.Async.execute('UPDATE users SET woundData = @woundData WHERE identifier = @identifier', {
            ['@woundData'] = json.encode(data),
            ['@identifier'] = Player.identifier,
        }, function()
        end)
    end)

    RegisterNetEvent('hospital:server:SetDeathStatus', function(isDead) -- Used to set the death status of a player, used by other qbcore scripts for easy intregration
        local src = source
        if isDead then
            TriggerClientEvent('osp_ambulance:OnPlayerDead', src)
        else
            TriggerClientEvent('osp_ambulance:OnPlayerSpawn', src)
        end 
    end)
    
    RegisterNetEvent('hospital:server:SetLaststandStatus', function(bool) -- Used to set the laststand status of a player, used by other qbcore scripts for easy intregration
        local src = source
        if bool then
            TriggerClientEvent('osp_ambulance:OnPlayerDead', src)
        else
            TriggerClientEvent('osp_ambulance:OnPlayerSpawn', src)
        end 
    end)

    RegisterNetEvent('hospital:server:resetHungerThirst', function()
        local Player = GetPlayer(source)
        if not Player then return end
    
        TriggerClientEvent('esx_status:set', source, 'hunger', 1000000)
        TriggerClientEvent('esx_status:set', source, 'thirst', 1000000)
    end)

    ESX.RegisterServerCallback('osp_ambulance:HasItem', function(source, cb, item)
        local Player = GetPlayer(source)
        local HasItem = Player.getInventoryItem(item).count
        if HasItem >= 1 then
            cb(true)
        else
            cb(false)
        end
    end)

    RegisterNetEvent('osp_ambulance:registerStash', function(stashid)
        if Config.UsedInventory == 'ox' then
            exports.ox_inventory:RegisterStash(stashid, 'Ambulance Stash', 20, 20000, true)
        end
    end)

    RegisterNetEvent('osp_amblance:setDeathStatus')
    AddEventHandler('osp_amblance:setDeathStatus', function(isDead)
        local xPlayer = GetPlayer(source)
        if type(isDead) == 'boolean' then
            MySQL.update('UPDATE users SET is_dead = ? WHERE identifier = ?', {isDead, xPlayer.identifier})
        end
    end)

end


lib.callback.register('osp_ambulance:GetTime', function(source, data)
    return os.date("%X")
end)

CreateUseableItem('pager', function(source, item)
    TriggerClientEvent('osp_ambulance:incoming', source)
end)

CreateUseableItem('stretcher', function(source, item)
    TriggerClientEvent('osp_ambulance:SpawnStretcher', source)
end)

CreateUseableItem('wheelchair', function(source, item)
    TriggerClientEvent('osp_ambulance:givePlayerWheelChair', source, true)
end)

CreateUseableItem('crutch', function(source, item)
    TriggerClientEvent('osp_ambulance:givePlayerCrutch', source, true)
end)

CreateUseableItem('ecg', function(source, item)
    TriggerClientEvent('osp_ambulance:activate', source)
end)

CreateUseableItem('bandage', function(source, item)
    TriggerClientEvent('osp_ambulance:useBandage', source)
end)

CreateUseableItem('temporary_tourniquet', function(source, item)
    TriggerClientEvent('osp_ambulance:useTorniquet', source)
end)

CreateUseableItem('painkillers', function(source, item)
    TriggerClientEvent('osp_ambulance:painKillers', source)
end)

CreateUseableItem('ifak', function(source, item)
    TriggerClientEvent('osp_ambulance:useIfak', source)
end)








RegisterNetEvent('osp_ambulance:revive', function(player)
    TriggerClientEvent('hospital:client:Revive', player)
end)

RegisterNetEvent('osp_ambulance:partialRevive', function(player)
    TriggerClientEvent('osp_ambulance:partialRevive', player)
end)

AddEventHandler('txAdmin:events:healedPlayer', function(eventData)
    if GetInvokingResource() ~= "monitor" or type(eventData) ~= "table" or type(eventData.id) ~= "number" then
        return
    end

    TriggerClientEvent('hospital:client:Revive', eventData.id)
end)

-- CreateThread(function()
--     Wait(1000)
--     while true do
--         doctorCount = 0
--         local serverPlayers = GetPlayers()
--         for k,v in pairs(serverPlayers) do
--             local Player = GetPlayer(v)
--             if Player then
--                 if Config.Framework == 'qb' then
--                     for _,x in pairs(Config.AmbulanceJobs) do
--                         if Player.PlayerData.job.name == x then
--                             doctorCount = doctorCount + 1
--                         end
--                     end
--                 else
--                     for _,x in pairs(Config.AmbulanceJobs) do
--                         if Player.job.name == x then
--                             doctorCount = doctorCount + 1
--                         end
--                     end
--                 end
--             end
--         end
--         Wait(5*60*1000)
--         TriggerClientEvent("hospital:client:SetDoctorCount", -1, doctorCount)
--     end
-- end)

RegisterNetEvent('hospital:server:SendToBed', function(bedId, isRevive)
    local src = source
    local Player = GetPlayer(src)
    TriggerClientEvent('hospital:client:SendToBed', src, bedId, Config.Locations["beds"][bedId], isRevive)
    TriggerClientEvent('hospital:client:SetBed', -1, bedId, true)
    if isRevive then
        TriggerClientEvent('hospital:client:SendBillEmail', src, Config.BillCost)
        if Config.Framework == 'qb' then 
            Player.Functions.RemoveMoney("bank", Config.BillCost, "respawned-at-hospital")
        else
            Player.removeAccountMoney('bank', tonumber(Config.BillCost))
        end
    end
end)

RegisterNetEvent('osp_ambulance:mutePlayer', function(bool)
    MumbleSetPlayerMuted(source, bool)
end)

RegisterNetEvent('hospital:server:RespawnAtHospital', function()
    local src = source
    local Player = GetPlayer(src)
    if Config.Framework == 'qb' then
        if Player.PlayerData.metadata["injail"] > 0 then
            for k, v in pairs(Config.Locations["jailbeds"]) do
                if not v.taken then
                    TriggerClientEvent('hospital:client:SendToBed', src, k, v, true)
                    TriggerClientEvent('hospital:client:SetBed2', -1, k, true)
                    if Config.WipeInventoryOnRespawn then
                        ClearInventory(Player)
                        TriggerClientEvent('osp_ambulance:SendTextMessage', src, lang.interactions.medicalHeader, lang.error.possessions_taken, 3000, 'error')
                    end
                    Player.Functions.RemoveMoney("bank", Config.BillCost, "respawned-at-hospital")
                    exports['qb-management']:AddMoney("ambulance", Config.BillCost)
                    TriggerClientEvent('hospital:client:SendBillEmail', src, Config.BillCost)
                    return
                end
            end
            TriggerClientEvent('hospital:client:SendToBed', src, 1, Config.Locations["jailbeds"][1], true)
            TriggerClientEvent('hospital:client:SetBed', -1, 1, true)
            if Config.WipeInventoryOnRespawn then
                ClearInventory(Player)
                TriggerClientEvent('osp_ambulance:SendTextMessage', src, lang.interactions.medicalHeader, lang.error.possessions_taken, 3000, 'error')
            end
            Player.Functions.RemoveMoney("bank", Config.BillCost, "respawned-at-hospital")
                exports['qb-management']:AddMoney("ambulance", Config.BillCost)
            TriggerClientEvent('hospital:client:SendBillEmail', src, Config.BillCost)
        else
            for k, v in pairs(Config.Locations["beds"]) do
                if not v.taken then
                    TriggerClientEvent('hospital:client:SendToBed', src, k, v, true)
                    TriggerClientEvent('hospital:client:SetBed', -1, k, true)
                    if Config.WipeInventoryOnRespawn then
                        ClearInventory(Player)
                        TriggerClientEvent('osp_ambulance:SendTextMessage', src, lang.interactions.medicalHeader, lang.error.possessions_taken, 3000, 'error')
                    end
                    Player.Functions.RemoveMoney("bank", Config.BillCost, "respawned-at-hospital")
                    exports['qb-management']:AddMoney("ambulance", Config.BillCost)
                    TriggerClientEvent('hospital:client:SendBillEmail', src, Config.BillCost)
                    return
                end
            end
            TriggerClientEvent('hospital:client:SendToBed', src, 1, Config.Locations["beds"][1], true)
            TriggerClientEvent('hospital:client:SetBed', -1, 1, true)
            if Config.WipeInventoryOnRespawn then
                ClearInventory(Player)
                TriggerClientEvent('osp_ambulance:SendTextMessage', src, lang.interactions.medicalHeader, lang.error.possessions_taken, 3000, 'error')
            end
            Player.Functions.RemoveMoney("bank", Config.BillCost, "respawned-at-hospital")
            exports['qb-management']:AddMoney("ambulance", Config.BillCost)
            TriggerClientEvent('hospital:client:SendBillEmail', src, Config.BillCost)
        end
    else
        for k, v in pairs(Config.Locations["beds"]) do
            if not v.taken then
                TriggerClientEvent('hospital:client:SendToBed', src, k, v, true)
                TriggerClientEvent('hospital:client:SetBed', -1, k, true)
                if Config.WipeInventoryOnRespawn then
                    ClearInventory(Player)
                    TriggerClientEvent('osp_ambulance:SendTextMessage', src, lang.interactions.medicalHeader, lang.error.possessions_taken, 3000, 'error')
                end
                Player.removeAccountMoney('bank', tonumber(Config.BillCost))
                return
            end
        end

        TriggerClientEvent('hospital:client:SendToBed', src, 1, Config.Locations["beds"][1], true)
        TriggerClientEvent('hospital:client:SetBed', -1, 1, true)
        if Config.WipeInventoryOnRespawn then
            ClearInventory(Player)
            TriggerClientEvent('osp_ambulance:SendTextMessage', src, lang.interactions.medicalHeader, lang.error.possessions_taken, 3000, 'error')
        end
        Player.removeAccountMoney('bank', tonumber(Config.BillCost))
    end
end)


RegisterNetEvent('hospital:server:ambulanceAlert', function(text)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local serverPlayers = GetPlayers()
    for k,v in pairs(serverPlayers) do
        local Player = GetPlayer(v)
        if Player then
            if Config.Framework == 'qb' then 
                for _,x in pairs(Config.AmbulanceJobs) do
                    if Player.PlayerData.job.name == x then
                        TriggerClientEvent('hospital:client:ambulanceAlert', Player.PlayerData.source, coords, text)
                    end
                end
            else
                for _,x in pairs(Config.AmbulanceJobs) do
                    if Player.job.name == x then
                        TriggerClientEvent('hospital:client:ambulanceAlert', v, coords, text)
                    end
                end
            end
        end
    end
end)

AddEventHandler("playerDropped", function(reason)
    local src = source
    local Player = GetPlayer(src)
    if Config.Framework == 'qb' then
        if Player then
            MySQL.Async.execute('UPDATE players SET woundData = @woundData WHERE citizenid = @citizenid', {
                ['@woundData'] = json.encode(PlayerServerData[src]),
                ['@citizenid'] = Player.PlayerData.citizenid,
            }, function()
            end)
        end
    else
        if Player then
            MySQL.Async.execute('UPDATE users SET woundData = @woundData WHERE identifier = @identifer', {
                ['@woundData'] = json.encode(PlayerServerData[src]),
                ['@identifer'] = Player.identifier,
            }, function()
            end)
        end
    end

    if Doctors[src] then
        doctorCount = doctorCount - 1
        TriggerClientEvent("hospital:client:SetDoctorCount", -1, doctorCount)
        Doctors[src] = nil
    end
end)

lib.callback.register('osp_ambulance:getPlayerNames', function(source, data)
    local newtable = {}
    for k,v in pairs(data) do
        local player = GetPlayer(v.id)
        local charactername = nil
        if Config.Framework == 'qb' then
            local firstname = player.PlayerData.charinfo.firstname
            local lastname = player.PlayerData.charinfo.lastname
            charactername = firstname .. ' ' .. lastname
        elseif Config.Framework == 'esx' then
            charactername = player.name
        end

        local table = {name = v.name, id = v.id, charactername = charactername}
        newtable[k] = table
    end
    return newtable
end)


RegisterNetEvent('hospital:server:SendDoctorAlert', function()
    local src = source
    if not doctorCalled then
        doctorCalled = true
        local serverPlayers = GetPlayers()
        for k,v in pairs(serverPlayers) do
            local Player = GetPlayer(v)
            if Config.Framework == 'qb' then
                for _,x in pairs(Config.AmbulanceJobs) do
                    if Player.PlayerData.job.name == x and Player.PlayerData.job.onduty then
                        TriggerClientEvent('osp_ambulance:SendTextMessage', Player.PlayerData.source, lang.interactions.medicalHeader, lang.info.dr_needed, 3000, 'error')
                    end
                end
            else
                for _,x in pairs(Config.AmbulanceJobs) do
                    if Player.job.name == x then
                        TriggerClientEvent('osp_ambulance:SendTextMessage', v, lang.interactions.medicalHeader, lang.info.dr_needed, 3000, 'error')
                    end
                end
            end
        end

        SetTimeout(Config.DocCooldown * 60000, function()
            doctorCalled = false
        end)
    else
        TriggerClientEvent('osp_ambulance:SendTextMessage', src, lang.interactions.medicalHeader, 'Doctor has already been notified', 3000, 'error')
    end
end)



function SendWebHook(title, color, message, img)
    local embedMsg = {}
    timestamp = os.date("%c")
    embedMsg = {
        {
            ["color"] = color,
            ["title"] = title,
            ["description"] =  ""..message.."",
            ["footer"] ={
                ["text"] = timestamp.." (Server Time).",
            },
        }
    }
    PerformHttpRequest(Config.webHook,
    function(err, text, headers)end, 'POST', json.encode({username = Config.webHookName, avatar_url= Config.webHookLogo ,embeds = embedMsg}), { ['Content-Type']= 'application/json' })
end


RegisterNetEvent('osp_ambulance:sendWebhook', function(data)
    title = data.title
    color = data.color
    message = data.message
    SendWebHook(title, color, message, img)
end)

RegisterNetEvent('osp_ambulance:requestScreenshotSv', function(target)
    TriggerClientEvent('osp_ambulance:requestScreenshotCl', target)
end)

