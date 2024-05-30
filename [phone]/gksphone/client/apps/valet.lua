--================================================================================================
--==            --    XenKnighT --        https://discord.gg/XUck63E                            ==
--================================================================================================



--- GKSPHONE VALET APP (client) ---
-- Made by GKSHOP  | https://discord.gg/XUck63E
-- Version: 2.0.0

local function DoCarDamage(currentVehicle, stats, props)
    local engine = stats.engine + 0.0
    local body = stats.body + 0.0
    SetVehicleEngineHealth(currentVehicle, engine)
    SetVehicleBodyHealth(currentVehicle, body)
    if not next(props) then return end
    if props.doorStatus then
        for k, v in pairs(props.doorStatus) do
            if v then SetVehicleDoorBroken(currentVehicle, tonumber(k), true) end
        end
    end
    if props.tireBurstState then
        for k, v in pairs(props.tireBurstState) do
            if v then SetVehicleTyreBurst(currentVehicle, tonumber(k), true) end
        end
    end
    if props.windowStatus then
        for k, v in pairs(props.windowStatus) do
            if not v then SmashVehicleWindow(currentVehicle, tonumber(k)) end
        end
    end
end

local function BringCar(netId, vehicleData, pedId)
    debugprint('BringCar Test', {netId, vehicleData, pedId})
    if pedId then
        local player = PlayerPedId()
        local playerCoords = GetEntityCoords(player)
        local driverPed = NetToPed(pedId)
        local veh = NetToVeh(netId)
        debugprint(vehicleData.mods)
        Config.Core.Functions.SetVehicleProperties(veh, vehicleData.mods)

        GiveKeyCar(veh)
        SetFuel(veh, vehicleData)

        DoCarDamage(veh, vehicleData, vehicleData.mods)
        SetVehicleEngineOn(veh, true, true)

        carBlip = AddBlipForEntity(veh)
        SetBlipSprite(carBlip, 225)--Blip Spawning.
        SetBlipFlashes(carBlip, true)
        SetBlipColour(carBlip, 0)
        SetBlipFlashes(carBlip, false)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(plate)
        EndTextCommandSetBlipName(carBlip)

        SetDriverAbility(ped, 1.0)
        SetDriverAggressiveness(ped, 0.0)
        TaskVehicleDriveToCoordLongrange(driverPed, veh, playerCoords.x, playerCoords.y, playerCoords.z, 30.0, 39, 7.0)

        while true do
            local pedCoords = GetEntityCoords(driverPed)
            local distance = #(playerCoords - pedCoords)
            if distance > 200.0 then
                SetPedCoordsKeepVehicle(driverPed, playerCoords.x, playerCoords.y, playerCoords.z)
            end
            if GetScriptTaskStatus(driverPed, 567490903) == 7 then
                TaskLeaveVehicle(driverPed, veh, 0)
                Wait(1000)
                TaskWanderStandard(driverPed, 10.0, 10)
                Wait(10000)
                DeleteEntity(driverPed)
                RemoveBlip(carBlip)
                break
            end
            if GetPedInVehicleSeat(veh, -1) == 0 then
                DeleteEntity(driverPed)
                RemoveBlip(carBlip)
                break
            end
            Wait(250)
        end
    else
        local veh = NetToVeh(netId)
        Config.Core.Functions.SetVehicleProperties(veh, vehicleData.mods)
        GiveKeyCar(veh)
        SetFuel(veh, vehicleData)
        DoCarDamage(veh, vehicleData, vehicleData.mods)
        SetVehicleEngineOn(veh, true, true)
    end
end

function WaitTaskToEnd(ped, task)
	while GetScriptTaskStatus(ped, task) == 0 do
		Wait(250)
	end
	while GetScriptTaskStatus(ped, task) == 1 do
		Wait(250)
	end
end

RegisterNUICallback('gksphone:vale:getVehicles', function(data, cb)
    debugprint('gksphone:vale:getVehicles', data)
    Config.Core.Functions.TriggerCallback('gksphone:server:vale:getVehicles', function(vehicles)
        debugprint('gksphone:server:vale:getVehicles', vehicles)
        for i = 1, #vehicles do
            local hash = tonumber(vehicles[i].hash) or GetHashKey(vehicles[i].vehicle)
            vehicles[i].speed = math.floor(GetVehicleModelEstimatedMaxSpeed(hash) * 3.6)
        end
        cb(vehicles)
    end)
end)

RegisterNUICallback('gksphone:vale:track', function(data, cb)
    debugprint('Car Point', data)
    Config.Core.Functions.TriggerCallback('gksphone:server:vale:vehichlepoint', function(status, vehicleCoords)
        debugprint('Car Point', {status, vehicleCoords})
        if status then
            SetNewWaypoint(vehicleCoords.x, vehicleCoords.y)
            local notify = {
                title = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
                message = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_MARKED"), -- The message of the notification
                icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
                duration = 5000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            -- Trigger the notification using the gksphone exports
            exports["gksphone"]:Notification(notify)
        else
            local notify = {
                title = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
                message = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_ERROR_TRACK_CARGARAGE"), -- The message of the notification
                icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
                duration = 5000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            -- Trigger the notification using the gksphone exports
            exports["gksphone"]:Notification(notify)
        end
    end, data.plate)
    cb('ok')
end)

RegisterNUICallback('gksphone:vale:bring', function(data, cb)
    debugprint('Car Spawn', data.plate)
    local coords = GetEntityCoords(PlayerPedId())
    local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(coords.x + math.random(-Config.ValespawnRadius, Config.ValespawnRadius), coords.y + math.random(-Config.ValespawnRadius, Config.ValespawnRadius), coords.z, 0, 3, 0)
    local coordinates = {x = spawnPos.x, y = spawnPos.y, z = spawnPos.z, spawnHeading}
    Config.Core.Functions.TriggerCallback('gksphone:server:vale:vehiclebring', function(netId, vehicleData, pedId)
        debugprint('Car Spawn2', {netId, vehicleData, pedId})
        if netId == "nomoney" then
            local notify = {
                title = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
                message = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_ERROR_BRING_NOMONEY"), -- The message of the notification
                icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
                duration = 20000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            exports["gksphone"]:Notification(notify)
        elseif netId == "carnotfound" then
            local notify = {
                title = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
                message = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_ERROR_BRING_CARNOTFOUND"), -- The message of the notification
                icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
                duration = 20000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            exports["gksphone"]:Notification(notify)
        elseif netId == "carimpounded" then
            local notify = {
                title = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
                message = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_ERROR_BRING_CARIMPOUNDED"), -- The message of the notification
                icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
                duration = 20000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            exports["gksphone"]:Notification(notify)
        elseif netId == "carnotingarage" then
            local notify = {
                title = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
                message = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_ERROR_BRING_NOTINGARAGE"), -- The message of the notification
                icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
                duration = 20000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            exports["gksphone"]:Notification(notify)
        elseif netId == "carnotingarage" then
            local notify = {
                title = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
                message = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_ERROR_BRING_NOTINGARAGE"), -- The message of the notification
                icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
                duration = 20000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            exports["gksphone"]:Notification(notify)
        elseif netId == "carout" then
            local notify = {
                title = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
                message = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_ERROR_BRING_CAROUTSIDE"), -- The message of the notification
                icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
                duration = 20000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            exports["gksphone"]:Notification(notify)
        else
            local notify = {
                title = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
                message = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_SUCESS_BRING"), -- The message of the notification
                icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
                duration = 20000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            exports["gksphone"]:Notification(notify)
            BringCar(netId, vehicleData, pedId)
        end
    end, data.plate, coordinates)
    cb('ok')
end)


