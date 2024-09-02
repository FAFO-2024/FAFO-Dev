--================================================================================================
--==            --    XenKnighT --        https://discord.gg/XUck63E                            ==
--================================================================================================
-- Credits to txAdmin for the list.
local isCarSpawned = false
VehClassNamesEnum = {
    [8] = "bike",
    [11] = "trailer",
    [13] = "bike",
    [14] = "boat",
    [15] = "heli",
    [16] = "plane",
    [21] = "train",
}

MismatchedTypes = {
    [`airtug`] = "automobile", -- trailer
    [`avisa`] = "submarine", -- boat
    [`blimp`] = "heli", -- plane
    [`blimp2`] = "heli", -- plane
    [`blimp3`] = "heli", -- plane
    [`caddy`] = "automobile", -- trailer
    [`caddy2`] = "automobile", -- trailer
    [`caddy3`] = "automobile", -- trailer
    [`chimera`] = "automobile", -- bike
    [`docktug`] = "automobile", -- trailer
    [`forklift`] = "automobile", -- trailer
    [`kosatka`] = "submarine", -- boat
    [`mower`] = "automobile", -- trailer
    [`policeb`] = "bike", -- automobile
    [`ripley`] = "automobile", -- trailer
    [`rrocket`] = "automobile", -- bike
    [`sadler`] = "automobile", -- trailer
    [`sadler2`] = "automobile", -- trailer
    [`scrap`] = "automobile", -- trailer
    [`slamtruck`] = "automobile", -- trailer
    [`Stryder`] = "automobile", -- bike
    [`submersible`] = "submarine", -- boat
    [`submersible2`] = "submarine", -- boat
    [`thruster`] = "heli", -- automobile
    [`towtruck`] = "automobile", -- trailer
    [`towtruck2`] = "automobile", -- trailer
    [`tractor`] = "automobile", -- trailer
    [`tractor2`] = "automobile", -- trailer
    [`tractor3`] = "automobile", -- trailer
    [`trailersmall2`] = "trailer", -- automobile
    [`utillitruck`] = "automobile", -- trailer
    [`utillitruck2`] = "automobile", -- trailer
    [`utillitruck3`] = "automobile", -- trailer
}



--- GKSPHONE VALET APP (client) ---
-- Made by GKSHOP  | https://discord.gg/XUck63E
-- Version: 2.0.0

local function BringCar(netId, vehicleData, pos)
    debugprint('BringCar Test', {netId, vehicleData, pos})

    local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
    local model = type(vehicleData.vehicle) == "string" and GetHashKey(vehicleData.vehicle) or vehicleData.vehicle
    
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end

    Config.Core.Functions.SpawnVehicle(model, function (vehID)
        Config.Core.Functions.SetVehicleProperties(vehID, vehicleData.mods)
        SetVehicleEngineOn(vehID, true, true, false)
        local carBlip = AddBlipForEntity(vehID)
        SetBlipSprite(carBlip, 225)--Blip Spawning.
        SetBlipFlashes(carBlip, true)
        SetBlipColour(carBlip, 0)
        SetBlipFlashes(carBlip, false)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Vale Car")
        EndTextCommandSetBlipName(carBlip)
        GiveKeyCar(vehID)

        if Config.ValeNPC then
            RequestModel("s_m_y_valet_01")
            local timeout = 0
            while not HasModelLoaded("s_m_y_valet_01") and timeout < 1500 do
                timeout = timeout + 1
                Wait(1)
            end
            local ValePed = CreatePedInsideVehicle(vehID, 5, "s_m_y_valet_01", -1, true, false)
            Wait(1000)
            SetDriverAbility(ValePed, 1.0)
            SetDriverAggressiveness(ValePed, 0.0)
            TaskVehicleDriveToCoordLongrange(ValePed, vehID, playerCoords.x, playerCoords.y, playerCoords.z, 30.0, 39, 7.0)
    
            while true do
                local pedCoords = GetEntityCoords(ValePed)
                local distance = #(playerCoords - pedCoords)
                if distance > 200.0 then
                    SetPedCoordsKeepVehicle(ValePed, playerCoords.x, playerCoords.y, playerCoords.z)
                end
                if GetScriptTaskStatus(ValePed, 567490903) == 7 then
                    TaskLeaveVehicle(ValePed, vehID, 0)
                    Wait(1000)
                    TaskWanderStandard(ValePed, 10.0, 10)
                    Wait(10000)
                    DeleteEntity(ValePed)
                    RemoveBlip(carBlip)
                    break
                end
                if GetPedInVehicleSeat(vehID, -1) == 0 then
                    DeleteEntity(ValePed)
                    RemoveBlip(carBlip)
                    break
                end
                Wait(250)
            end
        else
            Wait(5000)
            RemoveBlip(carBlip)
        end

        SetFuel(vehID, vehicleData.fuel)
        isCarSpawned = false
    end, pos, true, false)
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
    debugprint('Car Spawn', data.plate, data.model, isCarSpawned)
    if isCarSpawned then return end
    isCarSpawned = true
    local model = type(data.model) == "string" and joaat(data.model) or data.model
    if not IsModelInCdimage(model) then
        debugprint('Model not found in CDImage', data.model)
        return
    end

    local modelType
    if MismatchedTypes[model] then
        modelType = MismatchedTypes[model]
    else
        local modelClassNumber = GetVehicleClassFromName(model)
        modelType = VehClassNamesEnum[modelClassNumber] or "automobile"
    end

    local coords = GetEntityCoords(PlayerPedId())
    local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(coords.x + math.random(-Config.ValespawnRadius, Config.ValespawnRadius), coords.y + math.random(-Config.ValespawnRadius, Config.ValespawnRadius), coords.z, 0, 3, 0)
    local coordinates = {x = spawnPos.x, y = spawnPos.y, z = spawnPos.z, spawnHeading}
    Config.Core.Functions.TriggerCallback('gksphone:server:vale:vehiclebring', function(netId, vehicleData)
        debugprint('Car Spawn2', {netId, vehicleData})
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
        elseif netId == "spawned" then
            local notify = {
                title = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
                message = _T(lastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_SUCESS_BRING"), -- The message of the notification
                icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
                duration = 20000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            exports["gksphone"]:Notification(notify)
            BringCar(netId, vehicleData, coordinates)
        end
        isCarSpawned = false
    end, data.plate, coordinates, modelType)
    cb('ok')
end)


