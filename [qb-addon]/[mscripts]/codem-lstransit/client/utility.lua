cam = nil
jobData = {
    jobname = nil,
    job_grade_name = nil,
    job_grade = nil,
    job_label = nil
}
RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function()
    Wait(1000)
    SetPlayerJob()
    TriggerServerEvent('codem-busjob:LoadData')
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    Wait(1000)
    SetPlayerJob()
    TriggerServerEvent('codem-busjob:LoadData')
end)

CreateThread(function()
    Core, Config.Framework = GetCore()
    spawnPed()
    createBlips()
    SetPlayerJob()
end)

function WaitPlayer()
    if Config.Framework == "esx" or Config.Framework == 'oldesx' then
        while Core == nil do
            Wait(0)
        end
        while Core.GetPlayerData() == nil do
            Wait(0)
        end
        while Core.GetPlayerData().job == nil do
            Wait(0)
        end
    else
        while Core == nil do
            Wait(0)
        end
        while Core.Functions.GetPlayerData() == nil do
            Wait(0)
        end
        while Core.Functions.GetPlayerData().metadata == nil do
            Wait(0)
        end
    end
end

function SetPlayerJob()
    while Core == nil do
        Wait(0)
    end
    Wait(500)
    while not nuiLoaded do
        Wait(50)
    end
    WaitPlayer()

    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        local PlayerData = Core.GetPlayerData()
        jobData.jobname = PlayerData.job.name
        jobData.job_grade_name = PlayerData.job.label
        jobData.job_grade = tonumber(PlayerData.job.grade)
    else
        local PlayerData = Core.Functions.GetPlayerData()
        jobData.jobname = PlayerData["job"].name
        jobData.job_grade_name = PlayerData["job"].label
        jobData.job_grade = PlayerData["job"].grade.level
    end
end

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    Wait(1000)
    SetPlayerJob()
end)

RegisterNetEvent("QBCore:Player:SetPlayerData")
AddEventHandler("QBCore:Player:SetPlayerData", function(data)
    Wait(1000)
    SetPlayerJob()
end)

local blips = {}

function createBlips()
    if Config.BusjobSettings['blip']['show'] then
        blips = AddBlipForCoord(tonumber(Config.BusjobSettings['coords'].intreactionCoords.x),
            tonumber(Config.BusjobSettings['coords'].intreactionCoords.y),
            tonumber(Config.BusjobSettings['coords'].intreactionCoords.z))
        SetBlipSprite(blips, Config.BusjobSettings['blip'].blipType)
        SetBlipDisplay(blips, 4)
        SetBlipScale(blips, Config.BusjobSettings['blip'].blipScale)
        SetBlipColour(blips, Config.BusjobSettings['blip'].blipColor)
        SetBlipAsShortRange(blips, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(tostring(Config.BusjobSettings['blip'].blipName))
        EndTextCommandSetBlipName(blips)
    end
end

function canOpen()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        return false
    end
    if Config.BusjobSettings['job'] then
        if Config.BusjobSettings['job'] ~= 'all' and Config.BusjobSettings['job'] ~= jobData.jobname then
            Config.Notification(Config.NotificationText['wrongjob'].text,
                Config.NotificationText['wrongjob'].type, false)
            return false
        end
    end
    return true
end

function spawnPed()
    if Config.BusjobSettings.coords.ped then
        WaitForModel(Config.BusjobSettings.coords.pedHash)
        local createNpc = CreatePed("PED_TYPE_PROSTITUTE",
            Config.BusjobSettings.coords.pedHash,
            Config.BusjobSettings.coords.pedCoords.x,
            Config.BusjobSettings.coords.pedCoords.y,
            Config.BusjobSettings.coords.pedCoords.z - 0.98,
            Config.BusjobSettings.coords.pedHeading, false,
            false)
        FreezeEntityPosition(createNpc, true)
        SetEntityInvincible(createNpc, true)
        SetBlockingOfNonTemporaryEvents(createNpc, true)
    end
end

function spawnBusStopNpc(durak)
    -- if durak.npcCount == 0 then
    --     return
    -- end
    if durak.passengerPickedUp then
        return
    end
    for i = 1, durak.npcCount do
        local xOffset = math.random(-2, 2)
        local yOffset = math.random(-2, 2)
        local npc = spawnNpcForBus(durak.coords.x + xOffset, durak.coords.y + yOffset, durak.coords.z, durak.heading)
        if npc ~= nil then
            table.insert(durak.npcList, npc)
        end
        Citizen.Wait(200)
    end
end

function spawnNpcForBus(x, y, z, heading)
    local randomModel = Config.RandomNpc[math.random(#Config.RandomNpc)]
    local model = randomModel
    WaitForModel(model)
    local createNpcForBus = CreatePed("PED_TYPE_PROSTITUTE",
        model,
        x,
        y,
        z - 0.98,
        heading, false,
        false)
    if createNpcForBus == 0 or createNpcForBus == nil then
        print('Uyarı: Ped oluşturulamadı', model)
        return nil
    end
    FreezeEntityPosition(createNpcForBus, true)
    SetEntityInvincible(createNpcForBus, true)
    SetBlockingOfNonTemporaryEvents(createNpcForBus, true)
    SetEntityAsMissionEntity(createNpcForBus, true, true)
    return createNpcForBus
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.3, 0.3)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 90)
end

function SetBlipAttributes(blip, id)
    SetBlipSprite(blip, 1)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, 26)
    ShowNumberOnBlip(blip, id)
    SetBlipShowCone(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Bus Stop: " .. id)
    EndTextCommandSetBlipName(blip)
end

function WaitForModel(model)
    if not IsModelValid(model) then
        return
    end

    if not HasModelLoaded(model) then
        RequestModel(model)
    end

    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
end

function CodemGetVehicles()
    return GetGamePool('CVehicle')
end

function CodemGetVehiclesInArea(coords, maxDistance)
    return CodemEnumerateEntitiesWithinDistance(CodemGetVehicles(), false, coords, maxDistance)
end

function CodemEnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
    local nearbyEntities = {}

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        local playerPed = PlayerPedId()
        coords = GetEntityCoords(playerPed)
    end
    for k, entity in pairs(entities) do
        local distance = #(coords - GetEntityCoords(entity))

        if distance <= maxDistance then
            nearbyEntities[#nearbyEntities + 1] = isPlayerEntities and k or entity
        end
    end
    return nearbyEntities
end

RegisterNetEvent('codem-busjob:openMenu', function()
    if canOpen() then
        openBusMenu()
    end
end)

Citizen.CreateThread(function()
    Config.OpenTrigger = function()
        if Config.InteractionHandler == "qb-target" then
            exports['qb-target']:RemoveZone('codembusmenu' .. 1)

            exports['qb-target']:AddBoxZone("codembusmenu" .. 1,
                vector3(Config.BusjobSettings.coords.intreactionCoords.x,
                    Config.BusjobSettings.coords.intreactionCoords.y,
                    Config.BusjobSettings.coords.intreactionCoords.z), 1.5,
                1.5,
                {
                    name = "codembusmenu" .. 1,
                    debugPoly = false,
                    heading = -20,
                    minZ = Config.BusjobSettings.coords.intreactionCoords.z - 2,
                    maxZ = Config.BusjobSettings.coords.intreactionCoords.z + 2,
                }, {
                    options = {
                        {
                            type = "client",
                            event = "codem-busjob:openMenu",
                            icon = 'fas fa-credit-card',
                            label = "Open Bus Menu",

                        },
                    },
                    distance = 2
                })
        elseif Config.InteractionHandler == "ox-target" then
            exports.ox_target:removeZone('codembusmenu' .. 1)


            exports['ox_target']:addBoxZone({
                coords = vector3(Config.BusjobSettings.coords.intreactionCoords.x,
                    Config.BusjobSettings.coords.intreactionCoords.y,
                    Config.BusjobSettings.coords.intreactionCoords.z),
                minZ = Config.BusjobSettings.coords.intreactionCoords.z - 2,
                maxZ = Config.BusjobSettings.coords.intreactionCoords.z + 2,
                heading = -20,
                name = "codembusmenu" .. 1,
                id = "codembusmenu" .. 1,
                options = {
                    {
                        type = "client",
                        event = "codem-busjob:openMenu",
                        icon = 'fas fa-credit-card',
                        label = "Open Bus Menu",
                    },
                },
                distance = 2
            })
        elseif Config.InteractionHandler == "drawtext" then
            local isTextUiOpen = false
            Citizen.CreateThread(function()
                while true do
                    local wait = 1500
                    local playerPed = PlayerPedId()
                    local coords = GetEntityCoords(playerPed)
                    local distance = #(coords - Config.BusjobSettings.coords.intreactionCoords)
                    local isInZone = false
                    if distance < 1.5 then
                        wait = 0
                        isInZone = true
                        if not isTextUiOpen and Config.CodemTextUi then
                            exports["codem-textui"]:OpenTextUI('Bus Menu', 'E', 'thema-6')
                            isTextUiOpen = true
                        elseif not Config.CodemTextUi then
                            DrawText3D(Config.BusjobSettings.coords.intreactionCoords.x,
                                Config.BusjobSettings.coords.intreactionCoords.y,
                                Config.BusjobSettings.coords.intreactionCoords.z + 1.0,
                                "Press [~g~E~s~] to Bus Menu")
                        end


                        if IsControlJustReleased(0, 38) then
                            if canOpen() then
                                openBusMenu()
                            end
                        end
                    end
                    if isTextUiOpen and not isInZone and Config.CodemTextUi then
                        exports["codem-textui"]:CloseTextUI()
                        isTextUiOpen = false
                    end

                    Citizen.Wait(wait)
                end
            end)
        end
    end
end)


CreateCamera = function()
    local invehicle = IsPedInAnyVehicle(PlayerPedId(), false)
    if invehicle then return end
    local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.38, -1.7, 0)
    RenderScriptCams(true, true, 500, true, true)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamActive(cam, true)
        RenderScriptCams(true, true, 500, true, true)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.2)
        SetCamRot(cam, 5.0, 0.0, GetEntityHeading(PlayerPedId())) -- Change here
        SetCamNearClip(cam, 0.1)                                  -- Adjust the near clip distance
        SetCamFarClip(cam, 1000.0)                                -- Adjust the far clip distance
        SetCamFov(cam, 68.0)                                      -- Adjust the field of view
        SetCamDofFnumberOfLens(camera, 24.0)                      -- Number of lens in the camera's focus
        SetCamDofFocalLengthMultiplier(camera, 50.0)              -- Focal length of the camera's lens
    end
end
