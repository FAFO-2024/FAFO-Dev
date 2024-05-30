print('loading client_open.lua')
incomingScreenScale = 0.103
incomingScreenOffset = vector3(-0.77, -0.65, -0.4)
incomingScreenRot = 20
stationaryScale = 0.031
stationaryScreenOffset = vector3(-0.21, -0.07, -0.86)
stationaryScreenRot = 15 
ecgScreenOffset = vector3(-0.075, -0.099999999, 0.26)
PlayerJob = {}
PlayerLoaded = true
xSound = exports.xsound

lastStandDict = "combat@damage@writhe"
lastStandAnim = "writhe_loop"
deadAnimDict = "dead"
deadAnim = "dead_a"

if Config.Framework == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
    onDuty = false
    CreateThread(function()
        QBCore.Functions.GetPlayerData(function(PlayerData)
            if PlayerData.job ~= nil then
                PlayerJob = PlayerData.job
                onDuty = PlayerData.job.onduty
            end
        end)
    end)

    function HasItem(item)
        local hasItem = QBCore.Functions.HasItem(item)
        return hasItem
    end

    function GiveVehicleKeys(veh)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
    end

    function GetPlayerData()
        return QBCore.Functions.GetPlayerData()
    end

    function GetCharacterName()
        if GetPlayerData().charinfo ~= nil then
            return GetPlayerData().charinfo.firstname
        end
    end

    function AmbulanceDeleteVehicle(veh)
        QBCore.Functions.DeleteVehicle(veh)
    end

    function GetPlayerJobGrade()
        return PlayerJob.grade.level
    end

    function FullFuel(veh)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
    end

    function IfInJail()
        QBCore.Functions.GetPlayerData(function(PlayerData)
            if PlayerData.metadata["injail"] > 0 then
                TriggerEvent("prison:client:Enter", PlayerData.metadata["injail"])
            end
        end)
    end

    invItems = {}
    function GetMedicalInventoryItems()
        invItems = {}
        DebugPrint('Getting Medical Inventory Items')
        if Config.UsedInventory == '' or Config.UsedInventory == 'default' then
            local inventory = lib.callback.await('osp_ambulance:getInventory', 1000)
            Wait(100)
            DebugPrint('Got Inventory', inventory)
            for k,v in pairs(Config.InventoryItems) do
                for _, x in pairs(inventory) do
                    DebugPrint('Checking Item', k,v,x.name)
                    if x.name == k then
                        table.insert(invItems, {label = k, item = v})
                    end
                end
            end
        elseif Config.UsedInventory == 'qs' then
            local inventory = lib.callback.await('osp_ambulance:getInventory', 1000)
            Wait(100)
            DebugPrint('Got Inventory', inventory)
            for k,v in pairs(Config.InventoryItems) do
                for _, x in pairs(inventory) do
                    DebugPrint('Checking Item', k,v,x.name)
                    if x.name == k then
                        table.insert(invItems, {label = k, item = v})
                    end
                end
            end
        elseif Config.UsedInventory == 'ox' then
            local inventory = lib.callback.await('osp_ambulance:getInventory', 1000)
            Wait(100)
            DebugPrint('Got Inventory', inventory)
            for k,v in pairs(Config.InventoryItems) do
                for _, x in pairs(inventory) do
                    DebugPrint('Checking Item', k,v,x.name)
                    if x.name == k then
                        table.insert(invItems, {label = k, item = v})
                    end
                end
            end
        elseif Config.UsedInventory == 'core' then
            QBCore.Functions.TriggerCallback('core_inventory:server:getInventory', function(inventory)
                Wait(100)
                DebugPrint('Got Inventory', inventory)
                for k,v in pairs(Config.InventoryItems) do
                    for _, x in pairs(inventory) do
                        DebugPrint('Checking Item', k,v,x.name)
                        if x.name == k then
                            table.insert(invItems, {label = k, item = v})
                        end
                    end
                end
            end)
        end
        DebugPrint(json.encode(invItems))
    end

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        exports.spawnmanager:setAutoSpawn(false)
        initLanguages()
        Wait(Config.startDamageTimer)
        local ped = PlayerPedId()
        local player = PlayerId()
        SetEntityMaxHealth(ped, 200)
        SetEntityHealth(ped, 200)
        SetPlayerHealthRechargeMultiplier(player, 0.0)
        SetPlayerHealthRechargeLimit(player, 0.0)
        local data = lib.callback.await('osp_ambulance:getWoundData', 1000)
        if data then
            BodyDamage = data
            BodyDamage.ServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(PlayerPedId()))
            BodyDamage.MessageLog = {}
            BodyDamage.inBodyBag = false
            LocalPlayer.state:set('BodyDamage',  BodyDamage, true)
            TriggerServerEvent("hospital:server:SetDeathStatus", BodyDamage.isDead)
            TriggerServerEvent("hospital:server:SetLaststandStatus", BodyDamage.inLastStand)
            if BodyDamage.inLastStand then
                SetLaststand(true)
            elseif BodyDamage.isDead then
                BodyDamage.isDead = false
                deathTime = Config.RespawnTime
                OnDeath()
                DeathTimer()
            else
                if BodyDamage.playerHealth ~= nil then
                    -- SetEntityHealth(ped, BodyDamage.playerHealth)
                end
            end
        end
        QBCore.Functions.GetPlayerData(function(PlayerData)
            PlayerJob = PlayerData.job
            onDuty = PlayerData.job.onduty
            SetPedArmour(PlayerPedId(), PlayerData.metadata["armor"])
            for _,x in pairs(Config.AmbulanceJobs) do
                if PlayerJob.name == x and onDuty then
                    TriggerServerEvent("hospital:server:AddDoctor", PlayerJob.name)
                end
            end
        end)
        BodyDamage.BodyPartDamage.appliedTourniquets["Rarm"] = false
        BodyDamage.BodyPartDamage.appliedTourniquets["Larm"] = false
        BodyDamage.BodyPartDamage.appliedTourniquets["Rleg"] = false
        BodyDamage.BodyPartDamage.appliedTourniquets["Lleg"] = false
        Wait(2000)
        local timeLeft = lib.callback.await('osp_ambulance:checkInjuryTime', 100)
        if timeLeft then
            if timeLeft?.crutch then
                TriggerEvent('osp_ambulance:giveCrutch', timeLeft.time)
            elseif timeLeft?.WheelChair then
                TriggerEvent('osp_ambulance:giveWheelChair', timeLeft.time)
            end
        end
        TriggerServerEvent("police:server:UpdateBlips")
        PlayerLoaded = true
        BodyDamage.playerName = GetCharacterName()
        LocalPlayer.state:set('BodyDamage',  BodyDamage, true)
        loadScreens()
        ReloadJobInteractions()
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        PlayerLoaded = false
        for _,x in pairs(Config.AmbulanceJobs) do
            if PlayerJob.name == x and onDuty then
                TriggerServerEvent("hospital:server:RemoveDoctor", PlayerJob.name)
            end
        end
        local ped = PlayerPedId()
        TriggerServerEvent("hospital:server:SetDeathStatus", false)
        TriggerServerEvent('hospital:server:SetLaststandStatus', false)
        TriggerServerEvent('osp_ambulance:saveWoundDataSv', BodyDamage)
        TriggerServerEvent("hospital:server:SetArmor", GetPedArmour(ped))
        SetExtraTimecycleModifier("fp_vig_red")
        SetExtraTimecycleModifierStrength(1.0)
        SetPedMotionBlur(player, false)
        ClearExtraTimecycleModifier()
        SendNUIMessage(
            {
                death = 3,  
                blackout = 4,
            }
        )
        if bedOccupying then
            TriggerServerEvent("hospital:server:LeaveBed", bedOccupying)
        end
        deathTime = 0
        BodyDamage.isDead = false
        BodyDamage.inLastStand = false
        RestorePlayer()
        SetEntityInvincible(ped, false)
        SetPedArmour(ped, 0)
    end)

    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
        PlayerJob = JobInfo
        local isauth = false
        for _,x in pairs(Config.AmbulanceJobs) do
            if PlayerJob.name == x then
                ReloadJobInteractions()
                onDuty = PlayerJob.onduty
                if onDuty then
                    TriggerServerEvent("hospital:server:AddDoctor", PlayerJob.name)
                end
            end
        end
        if not isauth then
            TriggerServerEvent("hospital:server:RemoveDoctor", PlayerJob.name)
        end
    end)
    
    RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
        for _,x in pairs(Config.AmbulanceJobs) do
            if PlayerJob.name == x and duty == onDuty then
                if duty then
                    TriggerServerEvent("hospital:server:AddDoctor", PlayerJob.name)
                else
                    TriggerServerEvent("hospital:server:RemoveDoctor", PlayerJob.name)
                end
            end
        end
        onDuty = duty
    end)


    RegisterNetEvent('osp_ambulance:stash', function()
        if onDuty then
            if Config.UsedInventory == 'qs' then
                exports['qs-inventory']:RegisterStash("ambulancestash_" .. GetPlayerData().citizenid, 20, 20000) 
                local other = {}
                other.maxweight = 10000
                other.slots = 50
                TriggerServerEvent("inventory:server:OpenInventory", 'Ambulance Stash', "ambulancestash_" .. GetPlayerData().citizenid, other)
                TriggerEvent("inventory:client:SetCurrentStash", "ambulancestash_" .. GetPlayerData().citizenid)
            elseif Config.UsedInventory == 'ox' then
                TriggerServerEvent('osp_ambulance:registerStash', "ambulancestash_" .. GetPlayerData().citizenid)
                Wait(100)
                exports.ox_inventory:openInventory('Ambulance Stash', "ambulancestash_" .. GetPlayerData().citizenid)
            else
                TriggerServerEvent("inventory:server:OpenInventory", "stash",
                "ambulancestash_" .. GetPlayerData().citizenid)
                TriggerEvent("inventory:client:SetCurrentStash", "ambulancestash_" .. GetPlayerData().citizenid)
            end
        end
    end)



    AddEventHandler('onResourceStart', function(name)
        QBCore.Functions.GetPlayerData(function(PlayerData)
            PlayerJob = PlayerData.job
            onDuty = PlayerData.job.onduty
            for _,x in pairs(Config.AmbulanceJobs) do
                if PlayerJob.name == x and onDuty then
                    TriggerServerEvent("hospital:server:AddDoctor", PlayerJob.name)
                end
            end
        end)
    end)




elseif Config.Framework == 'esx' then

    ESX = exports["es_extended"]:getSharedObject()
    onDuty = false

    function HasItem(item)
        local hasItem = false
        if Config.UsedInventory == 'qs' then
            hasItem = exports['qs-inventory']:Search(item)
        end
        return hasItem
    end


    invItems = {}
    function GetMedicalInventoryItems()
        invItems = {}
        DebugPrint('Getting Medical Inventory Items')
        if Config.UsedInventory == '' or Config.UsedInventory == 'default' then
            local inventory = lib.callback.await('osp_ambulance:getInventory', 1000)
            Wait(100)
            DebugPrint('Got Inventory', inventory)
            for k,v in pairs(Config.InventoryItems) do
                for _, x in pairs(inventory) do
                    DebugPrint('Checking Item', k,v,x.name)
                    if x.name == k and x.count > 0 then
                        table.insert(invItems, {label = k, item = v})
                    end
                end
            end
        elseif Config.UsedInventory == 'qs' then
            local inventory = lib.callback.await('osp_ambulance:getInventory', 1000)
            Wait(100)
            DebugPrint('Got Inventory', inventory)
            for k,v in pairs(Config.InventoryItems) do
                for _, x in pairs(inventory) do
                    DebugPrint('Checking Item', k,v,x.name)
                    if x.name == k then
                        table.insert(invItems, {label = k, item = v})
                    end
                end
            end
        elseif Config.UsedInventory == 'ox' then
            local inventory = lib.callback.await('osp_ambulance:getInventory', 1000)
            Wait(100)
            DebugPrint('Got Inventory', inventory)
            for k,v in pairs(Config.InventoryItems) do
                for _, x in pairs(inventory) do
                    DebugPrint('Checking Item', k,v,x.name)
                    if x.name == k then
                        table.insert(invItems, {label = k, item = v})
                    end
                end
            end
        elseif Config.UsedInventory == 'core' then
            ESX.TriggerServerCallback('core_inventory:server:getInventory', function(inventory)
                Wait(100)
                DebugPrint('Got Inventory', inventory)
                for k,v in pairs(Config.InventoryItems) do
                    for _, x in pairs(inventory) do
                        DebugPrint('Checking Item', k,v,x.name)
                        if x.name == k then
                            table.insert(invItems, {label = k, item = v})
                        end
                    end
                end
            end)
        end
        DebugPrint(json.encode(invItems))
    end

    function GiveVehicleKeys(veh)
        --- ADD VEHICLE KEYS CODE HERE IF NEEDED
    end

    function GetPlayerData()
        return ESX.PlayerData
    end

    function GetCharacterName()
        local name = lib.callback.await('osp_ambulance:getName', 1000)
        while name == nil do
            Wait(1)
        end
        return name.firstname
    end

    function AmbulanceDeleteVehicle(veh)
        DeleteVehicle(veh)
    end

    function GetPlayerJobGrade()
        return PlayerJob.grade
    end

    function FullFuel(veh)
        SetVehicleFuelLevel(veh, 100.0)
    end


    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(d)
        PlayerLoaded = true
        ESX.PlayerData = d
        initLanguages()
        Wait(Config.startDamageTimer)
        local ped = PlayerPedId()
        local player = PlayerId()
        SetEntityMaxHealth(ped, 200)
        SetEntityHealth(ped, 200)
        SetPlayerHealthRechargeMultiplier(player, 0.0)
        SetPlayerHealthRechargeLimit(player, 0.0)
        PlayerJob = ESX.PlayerData['job']
        for _,x in pairs(Config.AmbulanceJobs) do
            if PlayerJob.name == x then
                onDuty = true
            end
        end
        for _,x in pairs(Config.AmbulanceJobs) do
            if PlayerJob.name == x and onDuty then
                TriggerServerEvent("hospital:server:AddDoctor", PlayerJob.name)
            end
        end
        local data = lib.callback.await('osp_ambulance:getWoundData', 1000)
        if data then
            BodyDamage = data
            BodyDamage.ServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(PlayerPedId()))
            BodyDamage.MessageLog = {}
            BodyDamage.inBodyBag = false
            LocalPlayer.state:set('BodyDamage',  BodyDamage, true)
            if BodyDamage.inLastStand then
                SetLaststand(true)
            elseif BodyDamage.isDead then
                BodyDamage.isDead = false
                deathTime = Config.RespawnTime
                OnDeath()
                DeathTimer()
            else
                if BodyDamage.playerHealth ~= nil then
                    -- SetEntityHealth(ped, BodyDamage.playerHealth)
                end
            end
        end
        BodyDamage.playerName = GetCharacterName()
        BodyDamage.BodyPartDamage.appliedTourniquets["Rarm"] = false
        BodyDamage.BodyPartDamage.appliedTourniquets["Larm"] = false
        BodyDamage.BodyPartDamage.appliedTourniquets["Rleg"] = false
        BodyDamage.BodyPartDamage.appliedTourniquets["Lleg"] = false
        LocalPlayer.state:set('BodyDamage',  BodyDamage, true)
        Wait(2000)
        local timeLeft = lib.callback.await('osp_ambulance:checkInjuryTime', 100)
        if timeLeft then
            if timeLeft?.crutch then
                TriggerEvent('osp_ambulance:giveCrutch', timeLeft.time)
            elseif timeLeft?.WheelChair then
                TriggerEvent('osp_ambulance:giveWheelChair', timeLeft.time)
            end
        end
        loadScreens()
        ReloadJobInteractions()
    end)


    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        ESX.PlayerData.job = job
        PlayerJob = ESX.PlayerData.job
        local isauth = false
        for _,x in pairs(Config.AmbulanceJobs) do
            if PlayerJob.name == x then
                onDuty = true
                ReloadJobInteractions()
                if onDuty then
                    isauth = true
                    TriggerServerEvent("hospital:server:AddDoctor", PlayerJob.name)
                end
            end
        end
        Wait(100)
        if not isauth then
            TriggerServerEvent("hospital:server:RemoveDoctor", PlayerJob.name)
        end
    end)

    AddEventHandler('onResourceStart', function(name)
        ESX.PlayerData = ESX.GetPlayerData()
        PlayerJob = ESX.PlayerData.job
        while PlayerJob == nil do 
            Wait(100)
        end
        for _,x in pairs(Config.AmbulanceJobs) do
            if PlayerJob.name == x then
                onDuty = true
            end
        end
        for _,x in pairs(Config.AmbulanceJobs) do
            if PlayerJob.name == x and onDuty then
                TriggerServerEvent("hospital:server:AddDoctor", PlayerJob.name)
            end
        end
    end)

    RegisterNetEvent('osp_ambulance:stash', function()
        if onDuty then
            if Config.UsedInventory == 'qs' then
                exports['qs-inventory']:RegisterStash("ambulancestash_" .. GetPlayerData().identifier, 20, 20000) 
                local other = {}
                other.maxweight = 10000
                other.slots = 50
                TriggerServerEvent("inventory:server:OpenInventory", 'Ambulance Stash', "ambulancestash_" .. GetPlayerData().identifier, other)
                TriggerEvent("inventory:client:SetCurrentStash", "ambulancestash_" .. GetPlayerData().identifier)
            elseif Config.UsedInventory == 'ox' then
                TriggerServerEvent('osp_ambulance:registerStash', "ambulancestash_" .. GetPlayerData().identifier)
                Wait(100)
                exports.ox_inventory:openInventory('Ambulance Stash', "ambulancestash_" .. GetPlayerData().identifier)
            else
                -- Currently have no replacement for inventories that doesn't already have implemented stash functions
            end
        end
    end)

    RegisterNetEvent('esx_ambulancejob:revive', function()
        TriggerEvent('hospital:client:Revive')
    end)

    AddEventHandler('playerSpawned', function()
        BodyDamage.isDead = false
        BodyDamage.inLastStand = false
        exports.spawnmanager:setAutoSpawn(false)
    end)

end

RegisterNetEvent('EMSToggle:Duty', function()
    onDuty = not onDuty
    if Config.Framework == 'qb' then
        TriggerServerEvent("QBCore:ToggleDuty")
        TriggerServerEvent("police:server:UpdateBlips")
    else
        if onDuty then
            TriggerServerEvent("hospital:server:AddDoctor", PlayerJob.name)
            SendTextMessage(lang.interactions.medicalHeader, lang.info.on_duty, 5000, "success")
        else
            SendTextMessage(lang.interactions.medicalHeader, lang.info.off_duty, 5000, "error")
            TriggerServerEvent("hospital:server:RemoveDoctor", PlayerJob.name)
        end
    end
end)


function CreateBloodDropEvidence()
    local randX = math.random() + math.random(-1, 1)
    local randY = math.random() + math.random(-1, 1)
    local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), randX, randY, 0)
    if Config.Framework == 'qb' then
        TriggerServerEvent("evidence:server:CreateBloodDrop", GetPlayerData().citizenid, GetPlayerData().metadata["bloodtype"], coords)
    end
end



RegisterNetEvent('osp_ambulance:SaveBodyDamageCl', function()
    local data = lib.callback.await('osp_ambulance:getWoundData', 1000)
    if data then
        BodyDamage = data
        BodyDamage.ServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(PlayerPedId()))
        BodyDamage.MessageLog = {}
        BodyDamage.inBodyBag = false
        if BodyDamage.inLastStand then
            SetLaststand(true)
        elseif BodyDamage.isDead then
            BodyDamage.isDead = false
            deathTime = Config.RespawnTime
            OnDeath()
            DeathTimer()
        end
        LocalPlayer.state:set('BodyDamage',  BodyDamage, true)
    end
end)



function textUi(txt)
    lib.showTextUI(txt, {
        position = "left-center",
    })
end

function removeTextUi()
    lib.hideTextUI()
end

function TargetingBoxZone(name, coords, x,y,z, list1, list2, list3)
    if Config.UseOxTarget then
        exports.ox_target:addBoxZone({
            coords = vec3(coords),
            size = vec3(x, y, z),
            rotation = 0,
            debug = false,
            drawSprite = true,
            options = {
                list1,

                list2,

                list3,
            }
        })
    else
        exports[Config.TargetName]:AddBoxZone(name, vector3(coords), x, y, {
            name = name,
            heading = 0,
            debugPoly = false,
            minZ = coords.z - z,
            maxZ = coords.z + z,
        }, {
            options = {
                list1, 
    
                list2,
    
                list3,
            },
            distance = 1.5
        })
    end
end

function TargetingEntityZone(entity, list1, list2, list3)
    exports[Config.TargetName]:AddEntityZone(entity, entity, {
        name = entity,
        heading = GetEntityHeading(entity),
        debugPoly = false,
    }, {
        options = {
            list1, 

            list2,

            list3,
        },
        distance = 4.0
    })
end

function TargetEntity(entity, list1, list2, list3, list4, list5)
    if Config.UseOxTarget then
        exports.ox_target:addLocalEntity(entity,
            {
                list1,

                list2,

                list3,

                list4,

                list5,
            }
        )
    else
        exports[Config.TargetName]:AddTargetEntity(entity, {
            options = {
                list1,
    
                list2,
    
                list3,
    
                list4,
    
                list5,
            },
            distance = 4.0
        })
    end
end


function RemoveTargetZone(entity)
    if Config.UseOxTarget then
        exports.ox_target:removeLocalEntity(entity, entity)
    else
        exports[Config.TargetName]:RemoveTargetEntity(entity)
    end
end

function RemoveZone(entity)
    if Config.UseOxTarget then
        
    else
        exports[Config.TargetName]:RemoveZone(entity)
    end
end

function SendTextMessage(msgtitle, msg, time, type2)
    if Config.UseOxNotif then
        lib.notify({
            title = msgtitle,
            description = msg,
            type = type2,
            position = 'top-right',
        })
    else
        if Config.Framework == 'qb' then
            QBCore.Functions.Notify(msg, type2, time)
        elseif Config.Framework == 'esx' then
            TriggerEvent('esx:showNotification', source, msg, type2, time)
        end
    end
end

RegisterNetEvent("osp_ambulance:SendTextMessage")
AddEventHandler("osp_ambulance:SendTextMessage", function(msgtitle, msg, time, type)
    SendTextMessage(msgtitle, msg, time, type)
end)


function ProgressBar(msg, time, animdict, anim)
    if Config.UseRadialProgressBar then
        if lib.progressCircle({
            duration = time,
            position = 'bottom',
            useWhileDead = true,
            canCancel = false,
            disable = {
                car = true,
            },
            anim = {
                dict = animdict,
                clip = anim
            },
            prop = {
            },
        }) then return true else return false end
    else
        if animdict then
            if lib.progressBar({
                duration = time,
                label = msg,
                useWhileDead = true,
                canCancel = false,
                disable = {
                    car = true,
                },
                anim = {
                    dict = animdict,
                    clip = anim
                },
                prop = {
                },
            }) then return true else return false end
        else
            if lib.progressBar({
                duration = time,
                label = msg,
                useWhileDead = true,
                canCancel = false,
                disable = {
                    car = true,
                },
                prop = {
                },
            }) then return true else return false end
        end
    end
end

function drawtext3d(coordsx, coordsy, coordsz, text)
    local onScreen,_x,_y=World3dToScreen2d(coordsx, coordsy, coordsz)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.25, 0.25)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)  
    local factor = string.len(text) / 270
    DrawRect(_x, _y + 0.008, 0.008 + factor, 0.03, 0, 0, 0, 0)
end

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function GetDamagingWeapon(ped)
    for k, v in pairs(Config.Weapons) do
        if HasPedBeenDamagedByWeapon(ped, k, 0) then
            return v
        end
    end
    return nil
end

function SetVehicleExtras(veh, table)
    for k,v in pairs(table) do
        SetVehicleExtra(veh, k, v) 
    end
end

function DebugPrint(...)
    if Config.Debug then
        print(...)
    end
end





AddEventHandler('onResourceStop', function(r)
    if r == GetCurrentResourceName() then
        for k, v in pairs(ScreenPropList) do
            DeleteObject(v)
        end
        ScreenPropList = {}
    end
end)



function CPRFunction(data)
    RequestAnimDict("mini@cpr@char_a@cpr_str")
    while not HasAnimDictLoaded("mini@cpr@char_a@cpr_str") do
        Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_str", "cpr_pumpchest", 8.0, -8.0, -1, 1, 0, false, false, false)
    local performingcpr = true
    local ent = Player(data.PlayerId)
    local stat = ent.state.BodyDamage
    local startingPulse = stat.Pulse
    local startingState = stat.cardiacState
    local revived = false
    Citizen.CreateThread(function()
        while true do
            local ent = Player(data.PlayerId)
            local stat = ent.state.BodyDamage
            if performingcpr then
                if not IsEntityPlayingAnim(PlayerPedId(), 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest', 3) then
                    TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_str", "cpr_pumpchest", 8.0, -8.0, -1, 1, 0, false, false, false)
                end
                if stat.Pulse == 0 then
                    stat.Pulse = 80
                    stat.cardiacState = 'NSR'
                    stat.beingPerformedCPROn = true
                    TriggerServerEvent('osp_ambulance:SaveDataSv', data.PlayerId, stat)
                    Wait(25000)
                    if not performingcpr then
                        return
                    end
                    -- local haswounds = false
                    -- for k,x in pairs(stat.BodyPartDamage.Wounds) do
                    --     for i,v in pairs(x) do
                    --         if v then
                    --             haswounds = true
                    --         end
                    --     end
                    -- end 
                    -- if not haswounds then
                    --     TriggerServerEvent('osp_ambulance:partialRevive', data.PlayerId)
                    --     revived = true
                    -- end
                    TriggerServerEvent('osp_ambulance:partialRevive', data.PlayerId)
                    revived = true
                    ClearPedTasks(PlayerPedId())
                end
            else
                stat.beingPerformedCPROn = false
                TriggerServerEvent('osp_ambulance:SaveDataSv', data.PlayerId, stat)
                ClearPedTasks(PlayerPedId())
                stat.Pulse = startingPulse
                stat.cardiacState = startingState
                table.insert(stat.MessageLog, lang.vitals.cpr_was_performed_until..' | '.. time)
                TriggerServerEvent('osp_ambulance:SaveDataSv', data.PlayerId, stat)
                break
            end
            if revived then
                ClearPedTasks(PlayerPedId())
                table.insert(stat.MessageLog, lang.vitals.cpr_was_performed_until..' | '.. time)
                Wait(100)
                local ent = Player(data.PlayerId)
                local stat = ent.state.BodyDamage
                stat.beingPerformedCPROn = false
                TriggerServerEvent('osp_ambulance:SaveDataSv', data.PlayerId, stat)
                break
            end
            Wait(2000)
        end
    end)
    Citizen.CreateThread(function()
        while true do
            if IsControlJustPressed(0, 73) then
                ClearPedTasks(PlayerPedId())
                Wait(1000)
                local ent = Player(data.PlayerId)
                local stat = ent.state.BodyDamage
                SetNuiFocus(true, true)
                SendNUIMessage(
                    {
                        display = true,
                        damageStatus = json.encode(stat),
                    }
                )
                performingcpr = false
                TriggerServerEvent('osp_ambulance:SaveDataSv', data.PlayerId, stat)
                break
            end
            Wait(3)
        end
    end)
end

RegisterNetEvent("osp_ambulance:OnPlayerLastStand", function(bool)
    if Config.MutePlayerOnLastStand then
        TriggerServerEvent('osp_ambulance:mutePlayer', true)
    end
    if Config.Framework == 'qb' then
        TriggerServerEvent("hospital:server:SetLaststandStatus", true)
    end
    DebugPrint('Setting laststand')
    SetLaststand(bool)
end)

RegisterNetEvent("osp_ambulance:OnPlayerDeath", function()
    if Config.MutePlayerOnDeath then
        TriggerServerEvent('osp_ambulance:mutePlayer', true)
    end
    if Config.Framework == 'qb' then
        TriggerServerEvent("hospital:server:SetDeathStatus", true)
    end
    OnDeath()
end)

RegisterNetEvent("osp_ambulance:OnPlayerDead", function()
    -- You can use this event to do something when the player dies/is dead
end)

RegisterNetEvent("osp_ambulance:OnPlayerSpawn", function()
    -- You can use this event to do something when the player spawns
end)

function dispatchNotify()
    -- Place custom dispatch notify code here
end


function disableAllSystems()
    return false
    -- Place custom code here when you want to block all medical systems (eg when in paintball)
    -- To disable all system trigger this inside a if statment:    return true
end


function disabledControls()
    DisableAllControlActions(0)
    EnableControlAction(0, 1, true) -- LookLeftRight
    EnableControlAction(0, 2, true) -- LookUpDown
    EnableControlAction(0, 245, true) -- T
    EnableControlAction(0, 38, true) -- A
    EnableControlAction(0, 0, true)
    EnableControlAction(0, 322, true) -- ESC
    EnableControlAction(0, 213, true) -- HOME
    EnableControlAction(0, 249, true) -- N
    EnableControlAction(0, 46, true) -- E
    EnableControlAction(0, 47, true) -- G
end

function isPedMovingCheck(ped)
    local timeout = 5000
    while GetEntitySpeed(ped) > 0.5 or IsPedRagdoll(ped) do
        Wait(10)
        timeout = timeout - 10
        if timeout <= 0 then
            break
        end
    end
end


function GetPlayers()
    local maxplayers = GetConvarInt('sv_maxclients', 255) - 1
    local players = {}

    for i=0, maxplayers do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end
    return players
end

local SlowEffect1 = false
local SlowEffect2 = false
local SlowEffect3 = false

local isinjuried = false

function ProcessRunStuff()
    if IsInjuryCausingLimp() then
        isinjuried = true
        RequestAnimSet("move_m@injured")
        while not HasAnimSetLoaded("move_m@injured") do
            Wait(0)
        end
        SetPedMovementClipset(PlayerPedId(), "move_m@injured", 1)
        SetPlayerSprint(PlayerId(), false)
    else
        if isinjuried then
            ResetPedMovementClipset(PlayerPedId(), 0.0)
            SetPlayerSprint(PlayerId(), true)
            isinjuried = false
        end
    end
    if Config.UseMovementRate then
        if BodyDamage.BodyPartDamage.DamageType["Rleg"] > 0 or BodyDamage.BodyPartDamage.DamageType["Lleg"] > 0 then
            SlowEffect1 = true
        elseif BodyDamage.BodyPartDamage.DamageType["Rleg"] > 1 or BodyDamage.BodyPartDamage.DamageType["Lleg"] > 1 then
            SlowEffect2 = true
        elseif BodyDamage.BodyPartDamage.DamageType["Rleg"] > 2 or BodyDamage.BodyPartDamage.DamageType["Lleg"] > 2 then
            SlowEffect2 = true
        else
            SlowEffect1 = false
            SlowEffect2 = false
            SlowEffect3 = false
            SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
            SetPedMoveRateOverride(PlayerPedId(), 1.0)
        end
    end
end

Citizen.CreateThread(function()
    if Config.UseMovementRate then
        while true do
            if SlowEffect1 then
                SetPedMoveRateOverride(PlayerPedId(), Config.MovementRate[1])
            elseif SlowEffect2 then
                SetPedMoveRateOverride(PlayerPedId(), Config.MovementRate[2])
            elseif SlowEffect3 then
                SetPedMoveRateOverride(PlayerPedId(), Config.MovementRate[3])
            end
            Wait(1000)
        end
    end
end)


signPoly = {}
stashPoly = {}
shopPoly = {}
roofPoly = {}
mainPoly = {}
function ReloadJobInteractions()
    if Config.UseTarget then
        for k,v in pairs(Config.Locations["duty"]) do
            RemoveZone('duty'..k)
        end
        for k,v in pairs(Config.Locations["stash"]) do
            RemoveZone('stash'..k)
        end
        for k,v in pairs(Config.Locations["shop"]) do
            RemoveZone('shop'..k)
        end
        for k,v in pairs(Config.Locations["roof"]) do
            RemoveZone('roof'..k)
        end
        for k,v in pairs(Config.Locations["main"]) do
            RemoveZone('main'..k)
        end
    else
        if #signPoly > 0 then
            check = false
            breakControls = true
            for k,v in pairs(signPoly) do
                v:remove()
            end
            for k,v in pairs(stashPoly) do
                v:remove()
            end
            for k,v in pairs(shopPoly) do
                v:remove()
            end
            for k,v in pairs(roofPoly) do
                v:remove()
            end
            for k,v in pairs(mainPoly) do
                v:remove()
            end
        end
    end

    CreateThread(function()
        while not PlayerJob do
            Wait(100)
        end
    
        if Config.UseGarageSystem then
            for k,v in pairs(Config.Locations["vehicle"]) do
                local function onEnter(self)
                    for _,x in pairs(Config.AmbulanceJobs) do
                        if onDuty and PlayerJob.name == x then
                            textUi(lang.text.veh_button)
                            EMSVehicle(k)
                        end
                    end
                end
                
                local function onExit(self)
                    CheckVehicle = false
                    removeTextUi()
                end
        
                lib.zones.box({
                    coords = vec3(v.x, v.y, v.z),
                    name = "vehicle" .. k,
                    size = vec3(5.0, 5.0, 5.0),
                    rotation = 70,
                    debug = false,
                    inside = inside,
                    onEnter = onEnter,
                    onExit = onExit
                })
            end
        end
    
        for k, v in pairs(Config.Locations["helicopter"]) do
            local function onEnter(self)
                for _,x in pairs(Config.AmbulanceJobs) do
                    if onDuty and PlayerJob.name == "ambulance" then
                        textUi(lang.text.heli_button)
                        EMSHelicopter(k)
                    end
                end
            end
            
            local function onExit(self)
                CheckHeli = false
                removeTextUi()
            end
    
            lib.zones.box({
                coords = vec3(v.x, v.y, v.z),
                name = "helicopter" .. k,
                size = vec3(5.0, 5.0, 5.0),
                rotation = 70,
                debug = false,
                inside = inside,
                onEnter = onEnter,
                onExit = onExit
            })
        end

        

        for k, v in pairs(Config.Locations["boss"]) do
            local function inside(self)
                for _,x in pairs(Config.AmbulanceJobs) do
                    if onDuty and PlayerJob.name == x and GetPlayerData().job.grade_name == 'boss' then
                        textUi('[E] Bossmenu')

                        if IsControlJustPressed(0, 38) then 
                            TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
                                menu.close()
                            end, { wash = false })
                        end
                    end
                end
            end
            
            local function onExit(self)
                removeTextUi()
            end

            lib.zones.box({
                coords = vec3(v.x, v.y, v.z),
                name = "boss" .. k,
                size = vec3(1.5, 1.5, 1.5),
                rotation = 20,
                debug = false,
                inside = inside,
                onEnter = onEnter,
                onExit = onExit
            })
        end

        for k, v in pairs(Config.Locations["cloakroom"]) do
            local function inside(self)
                for _,x in pairs(Config.AmbulanceJobs) do
                    if onDuty and PlayerJob.name == x then
                        textUi('[E] Cloakroom')
                        if IsControlJustPressed(0, 38) then
                            OpenCloakroom()
                        end
                    end
                end
            end
            
            local function onExit(self)
                removeTextUi()
            end

            lib.zones.box({
                coords = vec3(v.x, v.y, v.z),
                name = "cloakroom" .. k,
                size = vec3(1.5, 1.5, 1.5),
                rotation = 20,
                debug = false,
                inside = inside,
                onEnter = onEnter,
                onExit = onExit
            })
        end


    end)
    
    
    if Config.UseTarget then
        CreateThread(function()
            for k, v in pairs(Config.Locations["duty"]) do
                for _,x in pairs(Config.AmbulanceJobs) do
                    if PlayerJob.name == x then
                        TargetingBoxZone("duty"..k, v, 1.5,1,2,
                            {
                                type = "client",
                                event = "EMSToggle:Duty",
                                icon = "fa fa-clipboard",
                                label = lang.text.duty,
                                job = x
                            }
                        )
                    end
                end
            end
            for k, v in pairs(Config.Locations["stash"]) do
                for _,x in pairs(Config.AmbulanceJobs) do
                    if PlayerJob.name == x then
                        TargetingBoxZone("stash" .. k, v, 1,1,2,
                            {
                                type = "client",
                                event = "osp_ambulance:stash",
                                icon = "fa fa-hand",
                                label = lang.text.pstash,
                                job = x
                            }
                        )
                    end
                end
            end
            for k, v in pairs(Config.Locations["shop"]) do
                for _,x in pairs(Config.AmbulanceJobs) do
                    if PlayerJob.name == x then
                        TargetingBoxZone("shop" .. k, v, 1,1,2,
                            {
                                type = "client",
                                event = "osp_ambulance:shop",
                                icon = "fa fa-hand",
                                label = lang.text.store,
                                job = x
                            }
                        )
                    end
                end
            end
            for k, v in pairs(Config.Locations["roof"]) do
                for _,x in pairs(Config.AmbulanceJobs) do
                    if PlayerJob.name == x then
                        TargetingBoxZone("roof" .. k, v, 2,2,2,
                            {
                                type = "client",
                                event = "osp_ambulance:elevator_roof",
                                icon = "fa-solid fa-elevator",
                                label = lang.text.elevator_roof,
                                job = x
                            }
                        )
                    end
                end
            end
            for k, v in pairs(Config.Locations["main"]) do
                for _,x in pairs(Config.AmbulanceJobs) do
                    if PlayerJob.name == x then
                        TargetingBoxZone("main" .. k, v, 1.5,1.5,2,
                            {
                                type = "client",
                                event = "osp_ambulance:elevator_main",
                                icon = "fa-solid fa-elevator",
                                label = lang.text.elevator_main,
                                job = x
                            }
                        )
                    end
                end
            end
        end)
    else
        CreateThread(function()
            for k, v in pairs(Config.Locations["duty"]) do
                local function onEnter(self)
                    if not onDuty then
                        textUi(lang.text.onduty_button)

                        EMSControls("sign")
                    else
                        textUi(lang.text.offduty_button)
                        EMSControls("sign")
                    end
                end
                
                local function onExit(self)
                    check = false
                    removeTextUi()
                end
    
                signPoly[#signPoly + 1] = lib.zones.box({
                    coords = vec3(v.x, v.y, v.z),
                    name = "sign" .. k,
                    size = vec3(1.5, 1.5, 1.5),
                    rotation = 20,
                    debug = false,
                    inside = inside,
                    onEnter = onEnter,
                    onExit = onExit
                })
            end
    

            for k, v in pairs(Config.Locations["stash"]) do
    
                local function onEnter(self)
                    if onDuty then
                        textUi(lang.text.pstash_button)
                        EMSControls("stash")
                    end
                end
                
                local function onExit(self)
                    check = false
                    removeTextUi()
                end
    
                stashPoly[#stashPoly + 1] = lib.zones.box({
                    coords = vec3(v.x, v.y, v.z),
                    name = "stash" .. k,
                    size = vec3(1.5, 1.5, 1.5),
                    rotation = 20,
                    debug = false,
                    inside = inside,
                    onEnter = onEnter,
                    onExit = onExit
                })
            end
    
            for k, v in pairs(Config.Locations["shop"]) do
    
                local function onEnter(self)
                    if onDuty then
                        textUi(lang.text.store_button)

                        EMSControls("shop")
                    end
                end
                
                local function onExit(self)
                    check = false
                    removeTextUi()
                end
    
                shopPoly[#shopPoly + 1] = lib.zones.box({
                    coords = vec3(v.x, v.y, v.z),
                    name = "shop" .. k,
                    size = vec3(1.5, 1.5, 1.5),
                    rotation = 70,
                    debug = false,
                    inside = inside,
                    onEnter = onEnter,
                    onExit = onExit
                })
            end
    
            for k, v in pairs(Config.Locations["roof"]) do
    
                local function onEnter(self)
                    textUi(lang.text.elevator_main)

                    EMSControls("main")
                end
                
                local function onExit(self)
                    check = false
                    removeTextUi()
                end
    
                roofPoly[#roofPoly + 1] = lib.zones.box({
                    coords = vec3(v.x, v.y, v.z),
                    name = "roof" .. k,
                    size = vec3(2.0, 2.0, 2.0),
                    rotation = 70,
                    debug = false,
                    inside = inside,
                    onEnter = onEnter,
                    onExit = onExit
                })

            end
    
            for k, v in pairs(Config.Locations["main"]) do
    
                local function onEnter(self)
                    textUi(lang.text.elevator_roof)

                    EMSControls("roof")
                end
                
                local function onExit(self)
                    check = false
                    removeTextUi()
                end
    
                mainPoly[#mainPoly + 1] = lib.zones.box({
                    coords = vec3(v.x, v.y, v.z),
                    name = "main" .. k,
                    size = vec3(2.0, 2.0, 2.0),
                    rotation = 70,
                    debug = false,
                    inside = inside,
                    onEnter = onEnter,
                    onExit = onExit
                })
            end
        end)
    end
end
Wait(500)
ReloadJobInteractions()


if Config.UseTarget then
    CreateThread(function()
        for k, v in pairs(Config.Locations["checking"]) do
            TargetingBoxZone("checking"..k, v, 3.5,2,2,
                {
                    type = "client",
                    icon = "fa fa-clipboard",
                    event = "osp_ambulance:checkin",
                    label = lang.text.check_in,
                } 
            )
        end
        for k, v in pairs(Config.Locations["beds"]) do
            TargetingBoxZone("beds"..k, v.coords, 2.3,2.3,1,
                {
                    type = "client",
                    event = "osp_ambulance:beds",
                    icon = "fas fa-bed",
                    label = lang.update1.lay_in_bed,
                }
            )
        end
    end)
else
    CreateThread(function()
        local checkingPoly = {}
        for k, v in pairs(Config.Locations["checking"]) do
            local function onEnter(self)
                if doctorCount >= Config.MinimalDoctors then
                    CheckInControls("checkin")
                    textUi(lang.text.call_doc)

                else
                    CheckInControls("checkin")
                    textUi(lang.text.check_in)
                end
            end
            
            local function onExit(self)
                listen = false
                removeTextUi()
            end

            checkingPoly[#checkingPoly+1] = lib.zones.box({
                coords = vec3(v.x, v.y, v.z),
                name = "checkin"..k,
                size = vec3(3.5, 2.0, 2.0),
                rotation = -70,
                debug = false,
                inside = inside,
                onEnter = onEnter,
                onExit = onExit
            })


        end
        local bedPoly = {}
        for k, v in pairs(Config.Locations["beds"]) do
            local function onEnter(self)
                if not isInHospitalBed then
                    textUi(lang.text.lie_bed)

                    CheckInControls("beds")
                end
            end
            
            local function onExit(self)
                listen = false
                removeTextUi()
            end

            bedPoly[#bedPoly+1] = lib.zones.box({
                coords = vec3(v.coords.x, v.coords.y, v.coords.z),
                name = "beds"..k,
                size = vec3(2.5, 2.3, 2.3),
                rotation = -20,
                debug = false,
                inside = inside,
                onEnter = onEnter,
                onExit = onExit
            })
        end
    end)
end












function initLanguages() -- Initilizes the ui language
    SendNUIMessage({
        type = "lang",
        translations = json.encode(lang)
    })
end
Wait(1000)
initLanguages()

RegisterNUICallback('GetLang', function()
    SendNUIMessage({
        type = "lang",
        translations = json.encode(lang)
    })
end)  

local keycooldown = false
Citizen.CreateThread(function()
    while true do
        keycooldown = false
        Wait(100)
    end
end)

function IsAuthorized() 
    for _,x in pairs(Config.AmbulanceJobs) do
        if PlayerJob.name == x then
            return true
        end
    end
end

RegisterNetEvent('osp_ambulance:requestScreenshotCl', function()
    exports['screenshot-basic']:requestScreenshotUpload(Config.webHook, 'files[]', function(data)end)
end)


openMedicalMenu = false
cachedPlayer = nil
RegisterKeyMapping('medicalsystem', 'Medical System UI', 'keyboard', Config.OpenKey)
RegisterCommand("medicalsystem", function(source, args, rawCommand)
    if keycooldown then return end
    if BodyDamage.isDead then return end
    if BodyDamage.inLastStand then return end
    keycooldown = true
    if Config.LockMedicalMenu then
        if not IsAuthorized() then return end
    end
    local isOnline = false
    for k,v in pairs(GetPlayers()) do
        if GetPlayerServerId(v) == cachedPlayer then
            isOnline = true
        end
    end
    if isOnline == false then
        cachedPlayer = nil
    end
    openMedicalMenu = true
    if cachedPlayer == nil then
        ent = Player(GetPlayerServerId(PlayerId()))
    else
        ent = Player(cachedPlayer)
    end
    local stat = ent.state.BodyDamage
    if stat ~= nil then
        DebugPrint('Player state data ', stat, stat.isDead, cachedPlayer)
    else
        DebugPrint('stat is nil', cachedPlayer)
    end
    -- Citizen.CreateThread(function()
    --     while true do
    --         if cachedPlayer == nil then
    --             ent = Player(GetPlayerServerId(PlayerId()))
    --         else
    --             ent = Player(cachedPlayer)
    --         end
    --         local stat = ent.state.BodyDamage
    --         SendNUIMessage(
    --             {
    --                 damageStatus = json.encode(stat),
    --             }
    --         )
    --         if not openMedicalMenu then
    --             break
    --         end
    --         Wait(500)
    --     end
    -- end)
    GetMedicalInventoryItems()
    SendNUIMessage(
        {
            damageStatus = json.encode(stat),
            invItems = json.encode(invItems),
        }
    )
    Wait(100)
    SetNuiFocus(true, true)
    SendNUIMessage(
        {
            display = true,
        }
    )
end, false)

RegisterCommand("code", function(source, args, rawCommand)
    for k,v in pairs(Config.IncomingScreenPos) do
        SendDuiMessage(incomingDuiObj[k], json.encode({
            type = "code",
            room = "Monitor 5"
        }))
    end

    xSound:PlayUrlPos("codeblue",'codeblue.mp3', 1.0, Config.IncomingScreenSoundPos, false)
    xSound:Distance("codeblue", Config.IncomingScreenSoundRange)
    xSound:destroyOnFinish("codeblue", true)

end, false)




local openSkelly = false
RegisterKeyMapping('skelly', 'Open Skelly Overview', 'keyboard', Config.SkellyKey)
RegisterCommand("skelly", function(source, args, rawCommand)
    if openSkelly then
        openSkelly = false
        SendNUIMessage(
            {
                onDamage = json.encode(BodyDamage),
                openSkelly = false,
            }
        )
    else
        openSkelly = true
        SendNUIMessage(
            {
                onDamage = json.encode(BodyDamage),
                openSkelly = true,
            }
        )
    end
end, false)


exports('GetAmbulanceData', function(playerid)
    if playerid then
        local ent = Player(playerid)
        local stat = ent.state.BodyDamage
        return stat
    else
        local ent = Player(GetPlayerServerId(PlayerId()))
        local stat = ent.state.BodyDamage
        return stat
    end
end)

exports('isDead', function(playerid)
    if BodyDamage.isDead or BodyDamage.inLastStand then
        return true
    end
    return false
end)


RegisterNetEvent("osp_ambulance:SendAttachCl")
AddEventHandler("osp_ambulance:SendAttachCl", function(ped, pos)

    RegisterNetEvent("osp_ambulance:ChockCl")
    AddEventHandler("osp_ambulance:ChockCl", function(currentjoule)
        joule = currentjoule
        if GetEntityHealth(PlayerPedId()) >= 100 and BodyDamage.cardiacState == 'NSR' and not (BodyDamage.isDead or BodyDamage.inLastStand) then
            deathTime = 0
            OnDeath()
            DeathTimer()
        end
        if (BodyDamage.isDead or BodyDamage.inLastStand) then
            if (joule > 20) and (joule < 80) then
                if BodyDamage.cardiacState == 'asystole' then
                    local chance = math.random(1,2)
                    if chance == 1 then
                        TriggerEvent("osp_ambulance:partialRevive")
                    end
                end
    
                if BodyDamage.cardiacState == 'torsades' then
                    local chance = math.random(1,2)
                    if chance == 1 then
                        BodyDamage.cardiacState = 'NSR'
                        TriggerEvent("osp_ambulance:partialRevive")
                    else
                        BodyDamage.cardiacState = 'asystole'
                    end
                end
    
            elseif (joule < 150) and (joule > 80) then
                if BodyDamage.cardiacState == 'asystole' then
                    local chance = math.random(1,2)
                    if chance == 1 then
                        TriggerEvent("osp_ambulance:partialRevive")
                    else
                        local chance = math.random(1,2)
                        if chance == 1 then
                            Citizen.CreateThread(function()
                                BodyDamage.cardiacState = 'NSR'
                                BodyDamage.Pulse = 80
                                Wait(5000)
                                BodyDamage.cardiacState = 'asystole'
                                BodyDamage.Pulse = 0
                                LocalPlayer.state:set('BodyDamage',  BodyDamage, true)
                            end)
                        else
                            BodyDamage.cardiacState = 'asystole'
                        end
                    end
                end
    
                if BodyDamage.cardiacState == 'torsades' then
                    local chance = math.random(1,2)
                    if chance == 1 then
                        BodyDamage.cardiacState = 'NSR'
                        TriggerEvent("osp_ambulance:partialRevive")
                    else
                        BodyDamage.cardiacState = 'asystole'
                    end
                end
    
            elseif (joule > 150) then
                if BodyDamage.cardiacState == 'asystole' then
                    local chance = math.random(1,1)
                    if chance == 1 then
                        TriggerEvent("osp_ambulance:partialRevive")
                    else
                        Citizen.CreateThread(function()
                            BodyDamage.cardiacState = 'NSR'
                            BodyDamage.Pulse = 80
                            Wait(5000)
                            BodyDamage.cardiacState = 'asystole'
                            BodyDamage.Pulse = 0
                            LocalPlayer.state:set('BodyDamage',  BodyDamage, true)
                        end)
                    end
                end
    
                if BodyDamage.cardiacState == 'vFib' then
                    local chance = math.random(1,2)
                    if chance == 1 then
                        TriggerEvent("osp_ambulance:partialRevive")
                    end
                end

                if BodyDamage.cardiacState == 'torsades' then
                    local chance = math.random(1,3)
                    if chance == 1 then
                        BodyDamage.cardiacState = 'NSR'
                        BodyDamage.Pulse = 80
                    else
                        BodyDamage.Pulse = 0
                        BodyDamage.cardiacState = 'asystole'
                    end
                end
            end
        end

        LocalPlayer.state:set('BodyDamage',  BodyDamage, true)
    end)
end)


RegisterNetEvent('hospital:client:ambulanceAlert', function(coords, text)
    local street1, street2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local street1name = GetStreetNameFromHashKey(street1)
    local street2name = GetStreetNameFromHashKey(street2)
    SendTextMessage(lang.interactions.medicalHeader, (text .. ' \n ' .. street1name.. ' ' ..street2name), 5000, "success")
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    local transG = 250
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    local blip2 = AddBlipForCoord(coords.x, coords.y, coords.z)
    local blipText = lang.info.ems_alert
    SetBlipSprite(blip, 153)
    SetBlipSprite(blip2, 161)
    SetBlipColour(blip, 1)
    SetBlipColour(blip2, 1)
    SetBlipDisplay(blip, 4)
    SetBlipDisplay(blip2, 8)
    SetBlipAlpha(blip, transG)
    SetBlipAlpha(blip2, transG)
    SetBlipScale(blip, 0.8)
    SetBlipScale(blip2, 2.0)
    SetBlipAsShortRange(blip, false)
    SetBlipAsShortRange(blip2, false)
    PulseBlip(blip2)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(blipText)
    EndTextCommandSetBlipName(blip)
    while transG ~= 0 do
        Wait(Config.DeadBlipDelay)
        transG = transG - 1
        SetBlipAlpha(blip, transG)
        SetBlipAlpha(blip2, transG)
        if transG == 0 then
            RemoveBlip(blip)
            return
        end
    end
end)

CreateThread(function()
    for _, station in pairs(Config.Locations["stations"]) do
        local blip = AddBlipForCoord(station.coords.x, station.coords.y, station.coords.z)
        SetBlipSprite(blip, 61)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 25)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(station.label)
        EndTextCommandSetBlipName(blip)
    end
end)

RegisterNetEvent('hospital:client:RespawnAtHospital', function()
    TriggerServerEvent("hospital:server:RespawnAtHospital")
    if Config.Framework == 'qb' then
        if exports["qb-policejob"]:IsHandcuffed() then
            TriggerEvent("police:client:GetCuffed", -1)
        end
        TriggerEvent("police:client:DeEscort")
    end
end)

-- Restoring the player on admin revive

function RestorePlayer(player)
    SetEntityMaxHealth(player, 200)
    SetEntityHealth(player, 200)
    ClearPedBloodDamage(player)
    SetPlayerSprint(PlayerId(), true)
    ResetPedMovementClipset(player, 0.0)
    TriggerServerEvent('hud:server:RelieveStress', 100)
    TriggerServerEvent("hospital:server:resetHungerThirst")
    if Config.Framework == 'qb' then
        TriggerServerEvent("hospital:server:SetDeathStatus", false)
        TriggerServerEvent("hospital:server:SetLaststandStatus", false)
    end
    emsNotified = false
    BodyDamage.epinephrineKoefficient = 0
    BodyDamage.morphineKoefficient = 0
    BodyDamage.BodyPartDamage.BloodLevel = 6.0
    BodyDamage.Pain = 0
    BodyDamage.Conscious = true
    BodyDamage.Pulse = 80
    BodyDamage.oxygenSaturation = 99
    BodyDamage.Temp = 37.0
    BodyDamage.cardiacState = 'NSR'
    BodyDamage.BloodPressure[1] = 120
    BodyDamage.BloodPressure[2] = 80
    BodyDamage.isCarried = false
    BodyDamage.isDead = false
    BodyDamage.inLastStand = false
    BodyDamage.BodyPartDamage.Wounds["Rarm"] = {}
    BodyDamage.BodyPartDamage.Wounds["Larm"] = {}
    BodyDamage.BodyPartDamage.Wounds["Rleg"] = {}
    BodyDamage.BodyPartDamage.Wounds["Lleg"] = {}
    BodyDamage.BodyPartDamage.Wounds["Lleg"] = {}
    BodyDamage.BodyPartDamage.Wounds["Torso"] = {}
    BodyDamage.BodyPartDamage.Wounds["Head"] = {}
    BodyDamage.BodyPartDamage.NeedSewed["Rarm"] = false
    BodyDamage.BodyPartDamage.NeedSewed["Larm"] = false
    BodyDamage.BodyPartDamage.NeedSewed["Rleg"] = false
    BodyDamage.BodyPartDamage.NeedSewed["Lleg"] = false
    BodyDamage.BodyPartDamage.NeedSewed["Torso"] = false
    BodyDamage.BodyPartDamage.NeedSewed["Head"] = false
    BodyDamage.BodyPartDamage.Bleeding["Rarm"] = 0
    BodyDamage.BodyPartDamage.Bleeding["Larm"] = 0
    BodyDamage.BodyPartDamage.Bleeding["Rleg"] = 0
    BodyDamage.BodyPartDamage.Bleeding["Lleg"] = 0
    BodyDamage.BodyPartDamage.Bleeding["Torso"] = 0
    BodyDamage.BodyPartDamage.Bleeding["Head"] = 0
    BodyDamage.BodyPartDamage.DamageType["Rarm"] = 0
    BodyDamage.BodyPartDamage.DamageType["Larm"] = 0
    BodyDamage.BodyPartDamage.DamageType["Rleg"] = 0
    BodyDamage.BodyPartDamage.DamageType["Lleg"] = 0
    BodyDamage.BodyPartDamage.DamageType["Torso"] = 0
    BodyDamage.BodyPartDamage.DamageType["Head"] = 0
    ProcessRunStuff()
    LocalPlayer.state:set('BodyDamage',  BodyDamage, true)
end

RegisterNetEvent('osp_ambulance:partialRevive', function()
    TriggerServerEvent('osp_ambulance:mutePlayer', false)
    local player = PlayerPedId()
    if BodyDamage.isCarried then
        BodyDamage.isCarried = false
        ClearPedSecondaryTask(PlayerPedId())
        DetachEntity(PlayerPedId(), true, false)
    end
    if BodyDamage.isDead or BodyDamage.inLastStand then
        local pos = GetEntityCoords(player, true)
        NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(player), true, false)
        BodyDamage.isDead = false
        SetEntityInvincible(player, false)
        SetLaststand(false)
    end
    if isInHospitalBed then
        loadAnimDict(inBedDict)
        TaskPlayAnim(player, inBedDict , inBedAnim, 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
        canLeaveBed = true
    end
    SetExtraTimecycleModifier("fp_vig_red")
    SetExtraTimecycleModifierStrength(1.0)
    SetPedMotionBlur(player, false)
    ClearExtraTimecycleModifier()
    SendNUIMessage(
        {
            death = 3,  
            blackout = 4,
        }
    )
    SetEntityInvincible(player, false)
    SetEntityMaxHealth(player, 200)
    SetEntityHealth(player, 125)
    if Config.Framework == 'qb' then
        TriggerServerEvent("hospital:server:SetDeathStatus", false)
        TriggerServerEvent("hospital:server:SetLaststandStatus", false)
    end
    emsNotified = false
    BodyDamage.Conscious = true
    BodyDamage.isDead = false
    BodyDamage.inLastStand = false
    BodyDamage.cardiacState = 'NSR'
    BodyDamage.Pulse = 70
    BodyDamage.oxygenSaturation = 95
    BodyDamage.Temp = 37.0
    BodyDamage.BodyPartDamage.BloodLevel = 6.0
    BodyDamage.BloodPressure[1] = 120
    BodyDamage.BloodPressure[2] = 80
    LocalPlayer.state:set('BodyDamage',  BodyDamage, true)
    TriggerServerEvent("hospital:server:resetHungerThirst")
    ProcessRunStuff()
    SetEntityVisible(PlayerPedId(), true, true)
    DeleteEntity(bodyBag)
    if Config.Framework == 'esx' then
        TriggerServerEvent('osp_ambulance:setDeathStatus', false)
        ESX.SetPlayerData('dead', false)
    end
    ClearPedTasksImmediately(PlayerPedId())
end)

RegisterNetEvent('hospital:client:Revive', function()
    TriggerServerEvent('osp_ambulance:mutePlayer', false)
    local player = PlayerPedId()
    if BodyDamage.isCarried then
        BodyDamage.isCarried = false
        ClearPedSecondaryTask(PlayerPedId())
        DetachEntity(PlayerPedId(), true, false)
    end
    if BodyDamage.isDead or BodyDamage.inLastStand then
        local pos = GetEntityCoords(player, true)
        NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(player), true, false)
        BodyDamage.isDead = false
        SetEntityInvincible(player, false)
        SetLaststand(false)
    end
    if isInHospitalBed then
        loadAnimDict(inBedDict)
        TaskPlayAnim(player, inBedDict , inBedAnim, 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
        SetEntityInvincible(player, true)
        canLeaveBed = true
    else
        -- ClearPedTasksImmediately(PlayerPedId())
    end
    RestorePlayer(player)
    SetExtraTimecycleModifier("fp_vig_red")
    SetExtraTimecycleModifierStrength(1.0)
    SetPedMotionBlur(player, false)
    ClearExtraTimecycleModifier()
    SetEntityInvincible(player, false)
    SendNUIMessage(
        {
            death = 3,  
            blackout = 4,
        }
    )
    SendTextMessage(lang.interactions.medicalHeader, lang.info.healthy, 5000, "success")
    SetEntityVisible(PlayerPedId(), true, true)
    DeleteEntity(bodyBag)
    if Config.Framework == 'esx' then
        TriggerServerEvent('osp_ambulance:setDeathStatus', false)
        ESX.SetPlayerData('dead', false)
    end
end)


RegisterNetEvent('hospital:client:KillPlayer', function()
    SetEntityHealth(PlayerPedId(), 0)
end)



-- Example code snippet of how a custom item can be used to heal a player

RegisterNetEvent('osp_ambulance:useIfak', function()
    local dict, anim = Config.InteractionDict , Config.InteractionAnim
    ProgressBar(lang.update1.useIfak, 4000, dict, anim)
    TriggerServerEvent('osp_ambulance:addItem', 'field_dressing', 1)
    TriggerServerEvent('osp_ambulance:addItem', 'ecg', 1)
end)

RegisterNetEvent('osp_ambulance:useBandage', function()
    FreezeEntityPosition(PlayerPedId(), true)
    TriggerServerEvent('osp_ambulance:removeItem', 'bandage', 1)
    local dict, anim = Config.InteractionDict , Config.InteractionAnim
    ProgressBar(lang.update1.applyBandage, 3000, dict, anim)
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    local maxHealth = GetEntityMaxHealth(ped)
    if maxHealth > health then
        if health + 25 > maxHealth then
            SetEntityHealth(ped, maxHealth)
        else
            SetEntityHealth(ped, health + 25)
        end
    end
    for k,v in pairs(BodyDamage.BodyPartDamage.Bleeding) do
        local chance = math.random(1,4)
        if chance == 1 then
            if BodyDamage.BodyPartDamage.Bleeding[k] < 0.3 then
                BodyDamage.BodyPartDamage.Bleeding[k] = 0.0
            else
                BodyDamage.BodyPartDamage.Bleeding[k] = BodyDamage.BodyPartDamage.Bleeding[k]/2
            end
        end
    end
    LocalPlayer.state:set('BodyDamage',  BodyDamage, true)
    FreezeEntityPosition(PlayerPedId(), false)
end)

RegisterNetEvent('osp_ambulance:useTorniquet', function()
    FreezeEntityPosition(PlayerPedId(), true)
    TriggerServerEvent('osp_ambulance:removeItem', 'temporary_tourniquet', 1)
    local dict, anim = Config.InteractionDict , Config.InteractionAnim
    ProgressBar(lang.update1.applyTourniquet, 3000, dict, anim)
    local ped = PlayerPedId()
    Citizen.CreateThread(function()
        for k,v in pairs(BodyDamage.BodyPartDamage.appliedTourniquets) do
            BodyDamage.BodyPartDamage.appliedTourniquets[k] = true
        end
        Wait(1000*120) -- How long until the tourniquets wear down and are removed
        for k,v in pairs(BodyDamage.BodyPartDamage.appliedTourniquets) do
            BodyDamage.BodyPartDamage.appliedTourniquets[k] = false
        end
        LocalPlayer.state:set('BodyDamage',  BodyDamage, true)
    end)
    FreezeEntityPosition(PlayerPedId(), false)
end)

RegisterNetEvent('osp_ambulance:painKillers', function()
    FreezeEntityPosition(PlayerPedId(), true)
    TriggerServerEvent('osp_ambulance:removeItem', 'painkillers', 1)
    local dict, anim = Config.InteractionDict , Config.InteractionAnim
    ProgressBar(lang.update1.consumePainkillers, 3000, dict, anim)
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    local maxHealth = GetEntityMaxHealth(ped)
    if maxHealth > health then
        if health + 10 > maxHealth then
            SetEntityHealth(ped, maxHealth)
        else
            SetEntityHealth(ped, health + 10)
        end
    end
    TriggerServerEvent('hud:server:RelieveStress', 100)
    BodyDamage.Pain = BodyDamage.Pain/2
    BodyDamage.morphineKoefficient = BodyDamage.morphineKoefficient + 10
    FreezeEntityPosition(PlayerPedId(), false)
end)


Weapons = {
	-- // WEAPONS
	-- Melee
	[`weapon_unarmed`] 				 = {['name'] = 'weapon_unarmed', 		['label'] = 'Fists', 				['weapontype'] = 'Melee',	['ammotype'] = nil, ['damagereason'] = 'Melee killed / Whacked / Executed / Beat down / Murdered / Battered'},
	[`weapon_dagger`] 				 = {['name'] = 'weapon_dagger', 		['label'] = 'Dagger', 				['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Knifed / Stabbed / Eviscerated'},
	[`weapon_bat`] 					 = {['name'] = 'weapon_bat', 			['label'] = 'Bat', 					['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Melee killed / Whacked / Executed / Beat down / Murdered / Battered'},
	[`weapon_bottle`] 				 = {['name'] = 'weapon_bottle', 		['label'] = 'Broken Bottle', 		['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Knifed / Stabbed / Eviscerated'},
	[`weapon_crowbar`] 				 = {['name'] = 'weapon_crowbar', 		['label'] = 'Crowbar', 				['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Melee killed / Whacked / Executed / Beat down / Murdered / Battered'},
	[`weapon_flashlight`] 			 = {['name'] = 'weapon_flashlight', 	['label'] = 'Flashlight', 			['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Melee killed / Whacked / Executed / Beat down / Murdered / Battered'},
	[`weapon_golfclub`] 			 = {['name'] = 'weapon_golfclub', 		['label'] = 'Golfclub', 			['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Melee killed / Whacked / Executed / Beat down / Murdered / Battered'},
	[`weapon_hammer`] 				 = {['name'] = 'weapon_hammer', 		['label'] = 'Hammer', 				['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Melee killed / Whacked / Executed / Beat down / Murdered / Battered'},
	[`weapon_hatchet`] 				 = {['name'] = 'weapon_hatchet', 		['label'] = 'Hatchet', 				['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Knifed / Stabbed / Eviscerated'},
	[`weapon_knuckle`] 				 = {['name'] = 'weapon_knuckle', 		['label'] = 'Knuckle', 				['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Melee killed / Whacked / Executed / Beat down / Murdered / Battered'},
	[`weapon_knife`] 				 = {['name'] = 'weapon_knife', 			['label'] = 'Knife', 				['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Knifed / Stabbed / Eviscerated'},
	[`weapon_machete`] 				 = {['name'] = 'weapon_machete', 		['label'] = 'Machete', 				['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Knifed / Stabbed / Eviscerated'},
	[`weapon_switchblade`] 			 = {['name'] = 'weapon_switchblade', 	['label'] = 'Switchblade', 			['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Knifed / Stabbed / Eviscerated'},
	[`weapon_nightstick`] 			 = {['name'] = 'weapon_nightstick', 	['label'] = 'Nightstick', 			['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Melee killed / Whacked / Executed / Beat down / Murdered / Battered'},
	[`weapon_wrench`] 				 = {['name'] = 'weapon_wrench', 		['label'] = 'Wrench', 				['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Melee killed / Whacked / Executed / Beat down / Murdered / Battered'},
	[`weapon_battleaxe`] 			 = {['name'] = 'weapon_battleaxe', 		['label'] = 'Battle Axe', 			['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Knifed / Stabbed / Eviscerated'},
	[`weapon_poolcue`] 				 = {['name'] = 'weapon_poolcue', 		['label'] = 'Poolcue', 				['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Melee killed / Whacked / Executed / Beat down / Murdered / Battered'},
	[`weapon_briefcase`] 			 = {['name'] = 'weapon_briefcase', 		['label'] = 'Briefcase', 			['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Melee killed / Whacked / Executed / Beat down / Murdered / Battered'},
	[`weapon_briefcase_02`] 		 = {['name'] = 'weapon_briefcase_02', 	['label'] = 'Briefcase', 			['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Melee killed / Whacked / Executed / Beat down / Murdered / Battered'},
	[`weapon_garbagebag`] 			 = {['name'] = 'weapon_garbagebag', 	['label'] = 'Garbage Bag', 			['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Melee killed / Whacked / Executed / Beat down / Murdered / Battered'},
	[`weapon_handcuffs`] 			 = {['name'] = 'weapon_handcuffs', 		['label'] = 'Handcuffs', 			['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Melee killed / Whacked / Executed / Beat down / Murdered / Battered'},
	[`weapon_bread`] 				 = {['name'] = 'weapon_bread', 			['label'] = 'Baquette', 			['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Melee killed / Whacked / Executed / Beat down / Murdered / Battered'},
	[`weapon_stone_hatchet`] 		 = {['name'] = 'weapon_stone_hatchet', 	['label'] = 'Stone Hatchet',        ['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Knifed / Stabbed / Eviscerated'},

    -- Handguns
	[`weapon_pistol`] 				 = {['name'] = 'weapon_pistol', 		['label'] = 'Pistol', 				    ['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_PISTOL',	['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
	[`weapon_pistol_mk2`] 			 = {['name'] = 'weapon_pistol_mk2', 	['label'] = 'Pistol Mk2', 			    ['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_PISTOL',	['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
	[`weapon_combatpistol`] 		 = {['name'] = 'weapon_combatpistol', 	['label'] = 'Combat Pistol', 			['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_PISTOL',	['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
	[`weapon_appistol`] 			 = {['name'] = 'weapon_appistol', 		['label'] = 'AP Pistol', 				['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_PISTOL',	['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
	[`weapon_stungun`] 				 = {['name'] = 'weapon_stungun', 		['label'] = 'Taser', 					['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_STUNGUN',	['damagereason'] = 'Died'},
	[`weapon_pistol50`] 			 = {['name'] = 'weapon_pistol50', 		['label'] = 'Pistol .50 Cal', 			['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_PISTOL',	['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
	[`weapon_snspistol`] 			 = {['name'] = 'weapon_snspistol', 		['label'] = 'SNS Pistol', 				['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_PISTOL',	['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
	[`weapon_snspistol_mk2`] 	     = {['name'] = 'weapon_snspistol_mk2', 	['label'] = 'SNS Pistol MK2', 			['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_PISTOL',   ['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
	[`weapon_heavypistol`] 			 = {['name'] = 'weapon_heavypistol', 	['label'] = 'Heavy Pistol', 			['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_PISTOL',	['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
	[`weapon_vintagepistol`] 		 = {['name'] = 'weapon_vintagepistol', 	['label'] = 'Vintage Pistol', 			['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_PISTOL',	['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
	[`weapon_flaregun`] 			 = {['name'] = 'weapon_flaregun', 		['label'] = 'Flare Gun', 				['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_FLARE',	['damagereason'] = 'Died'},
	[`weapon_marksmanpistol`] 		 = {['name'] = 'weapon_marksmanpistol', ['label'] = 'Marksman Pistol', 			['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_PISTOL',	['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
	[`weapon_revolver`] 			 = {['name'] = 'weapon_revolver', 		['label'] = 'Revolver', 				['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_PISTOL',	['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
	[`weapon_revolver_mk2`] 		 = {['name'] = 'weapon_revolver_mk2', 	['label'] = 'Revolver MK2', 		    ['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_PISTOL',	['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
	[`weapon_doubleaction`] 	     = {['name'] = 'weapon_doubleaction', 	['label'] = 'Double Action Revolver',	['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_PISTOL',	['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
	[`weapon_raypistol`]			 = {['name'] = 'weapon_raypistol',		['label'] = 'Ray Pistol',			    ['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_PISTOL',	['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
	[`weapon_ceramicpistol`]		 = {['name'] = 'weapon_ceramicpistol', 	['label'] = 'Ceramic Pistol',		    ['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_PISTOL',	['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
	[`weapon_navyrevolver`]        	 = {['name'] = 'weapon_navyrevolver', 	['label'] = 'Navy Revolver',		    ['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_PISTOL',	['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
	[`weapon_gadgetpistol`] 		 = {['name'] = 'weapon_gadgetpistol', 	['label'] = 'Gadget Pistol',		    ['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_PISTOL',	['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
	[`weapon_stungun_mp`] 			 = {['name'] = 'weapon_stungun_mp', 	['label'] = 'Taser', 					['weapontype'] = 'Pistol',	['ammotype'] = 'AMMO_STUNGUN',	['damagereason'] = 'Died'},

    -- Submachine Guns
	[`weapon_microsmg`] 			 = {['name'] = 'weapon_microsmg', 		['label'] = 'Micro SMG', 			['weapontype'] = 'Submachine Gun',	['ammotype'] = 'AMMO_SMG',		['damagereason'] = 'Riddled / Drilled / Finished / Submachine Gunned'},
	[`weapon_smg`] 				 	 = {['name'] = 'weapon_smg', 			['label'] = 'SMG', 					['weapontype'] = 'Submachine Gun',	['ammotype'] = 'AMMO_SMG',		['damagereason'] = 'Riddled / Drilled / Finished / Submachine Gunned'},
	[`weapon_smg_mk2`] 				 = {['name'] = 'weapon_smg_mk2', 		['label'] = 'SMG MK2', 			    ['weapontype'] = 'Submachine Gun',	['ammotype'] = 'AMMO_SMG',		['damagereason'] = 'Riddled / Drilled / Finished / Submachine Gunned'},
	[`weapon_assaultsmg`] 			 = {['name'] = 'weapon_assaultsmg', 	['label'] = 'Assault SMG', 			['weapontype'] = 'Submachine Gun',	['ammotype'] = 'AMMO_SMG',		['damagereason'] = 'Riddled / Drilled / Finished / Submachine Gunned'},
	[`weapon_combatpdw`] 			 = {['name'] = 'weapon_combatpdw', 		['label'] = 'Combat PDW', 			['weapontype'] = 'Submachine Gun',	['ammotype'] = 'AMMO_SMG',		['damagereason'] = 'Riddled / Drilled / Finished / Submachine Gunned'},
	[`weapon_machinepistol`] 		 = {['name'] = 'weapon_machinepistol', 	['label'] = 'Tec-9', 				['weapontype'] = 'Submachine Gun',	['ammotype'] = 'AMMO_PISTOL',	['damagereason'] = 'Riddled / Drilled / Finished / Submachine Gunned'},
	[`weapon_minismg`] 				 = {['name'] = 'weapon_minismg', 		['label'] = 'Mini SMG', 			['weapontype'] = 'Submachine Gun',	['ammotype'] = 'AMMO_SMG',		['damagereason'] = 'Riddled / Drilled / Finished / Submachine Gunned'},
	[`weapon_raycarbine`]	         = {['name'] = 'weapon_raycarbine', 	['label'] = 'Raycarbine',	        ['weapontype'] = 'Submachine Gun',	['ammotype'] = 'AMMO_SMG',		['damagereason'] = 'Riddled / Drilled / Finished / Submachine Gunned'},

    -- Shotguns
	[`weapon_pumpshotgun`] 			 = {['name'] = 'weapon_pumpshotgun', 	 	['label'] = 'Pump Shotgun', 			['weapontype'] = 'Shotgun',	['ammotype'] = 'AMMO_SHOTGUN',	['damagereason'] = 'Devastated / Pulverized / Shotgunned'},
	[`weapon_pumpshotgun_mk2`]		 = {['name'] = 'weapon_pumpshotgun_mk2',	['label'] = 'Pump Shotgun MK2', 		['weapontype'] = 'Shotgun',	['ammotype'] = 'AMMO_SHOTGUN',	['damagereason'] = 'Devastated / Pulverized / Shotgunned'},
	[`weapon_sawnoffshotgun`] 		 = {['name'] = 'weapon_sawnoffshotgun', 	['label'] = 'Sawn-off Shotgun', 		['weapontype'] = 'Shotgun',	['ammotype'] = 'AMMO_SHOTGUN',	['damagereason'] = 'Devastated / Pulverized / Shotgunned'},
	[`weapon_assaultshotgun`] 		 = {['name'] = 'weapon_assaultshotgun', 	['label'] = 'Assault Shotgun', 			['weapontype'] = 'Shotgun',	['ammotype'] = 'AMMO_SHOTGUN',	['damagereason'] = 'Devastated / Pulverized / Shotgunned'},
	[`weapon_bullpupshotgun`] 		 = {['name'] = 'weapon_bullpupshotgun', 	['label'] = 'Bullpup Shotgun', 			['weapontype'] = 'Shotgun',	['ammotype'] = 'AMMO_SHOTGUN',	['damagereason'] = 'Devastated / Pulverized / Shotgunned'},
	[`weapon_musket`] 			     = {['name'] = 'weapon_musket', 			['label'] = 'Musket', 					['weapontype'] = 'Shotgun',	['ammotype'] = 'AMMO_SHOTGUN',	['damagereason'] = 'Devastated / Pulverized / Shotgunned'},
	[`weapon_heavyshotgun`] 		 = {['name'] = 'weapon_heavyshotgun', 	 	['label'] = 'Heavy Shotgun', 			['weapontype'] = 'Shotgun',	['ammotype'] = 'AMMO_SHOTGUN',	['damagereason'] = 'Devastated / Pulverized / Shotgunned'},
	[`weapon_dbshotgun`] 			 = {['name'] = 'weapon_dbshotgun', 		 	['label'] = 'Double-barrel Shotgun', 	['weapontype'] = 'Shotgun',	['ammotype'] = 'AMMO_SHOTGUN',	['damagereason'] = 'Devastated / Pulverized / Shotgunned'},
	[`weapon_autoshotgun`] 			 = {['name'] = 'weapon_autoshotgun', 	 	['label'] = 'Auto Shotgun', 			['weapontype'] = 'Shotgun',	['ammotype'] = 'AMMO_SHOTGUN',	['damagereason'] = 'Devastated / Pulverized / Shotgunned'},
	[`weapon_combatshotgun`]		 = {['name'] = 'weapon_combatshotgun', 		['label'] = 'Combat Shotgun',		    ['weapontype'] = 'Shotgun',	['ammotype'] = 'AMMO_SHOTGUN',	['damagereason'] = 'Devastated / Pulverized / Shotgunned'},

    -- Assault Rifles
	[`weapon_assaultrifle`] 		 = {['name'] = 'weapon_assaultrifle', 	 	['label'] = 'Assault Rifle', 				['weapontype'] = 'Assault Rifle',	['ammotype'] = 'AMMO_RIFLE',	['damagereason'] = 'Ended / Rifled / Shot down / Floored'},
	[`weapon_assaultrifle_mk2`] 	 = {['name'] = 'weapon_assaultrifle_mk2', 	['label'] = 'Assault Rifle MK2', 			['weapontype'] = 'Assault Rifle',	['ammotype'] = 'AMMO_RIFLE',	['damagereason'] = 'Ended / Rifled / Shot down / Floored'},
	[`weapon_carbinerifle`] 		 = {['name'] = 'weapon_carbinerifle', 	 	['label'] = 'Carbine Rifle', 				['weapontype'] = 'Assault Rifle',	['ammotype'] = 'AMMO_RIFLE',	['damagereason'] = 'Ended / Rifled / Shot down / Floored'},
    [`weapon_carbinerifle_mk2`] 	 = {['name'] = 'weapon_carbinerifle_mk2', 	['label'] = 'Carbine Rifle MK2', 			['weapontype'] = 'Assault Rifle',	['ammotype'] = 'AMMO_RIFLE',	['damagereason'] = 'Ended / Rifled / Shot down / Floored'},
	[`weapon_advancedrifle`] 		 = {['name'] = 'weapon_advancedrifle', 	 	['label'] = 'Advanced Rifle', 				['weapontype'] = 'Assault Rifle',	['ammotype'] = 'AMMO_RIFLE',	['damagereason'] = 'Ended / Rifled / Shot down / Floored'},
	[`weapon_specialcarbine`] 		 = {['name'] = 'weapon_specialcarbine', 	['label'] = 'Special Carbine', 				['weapontype'] = 'Assault Rifle',	['ammotype'] = 'AMMO_RIFLE',	['damagereason'] = 'Ended / Rifled / Shot down / Floored'},
	[`weapon_specialcarbine_mk2`]	 = {['name'] = 'weapon_specialcarbine_mk2',	['label'] = 'Specialcarbine MK2',	        ['weapontype'] = 'Assault Rifle',	['ammotype'] = 'AMMO_RIFLE',	['damagereason'] = 'Ended / Rifled / Shot down / Floored'},
	[`weapon_bullpuprifle`] 		 = {['name'] = 'weapon_bullpuprifle', 	 	['label'] = 'Bullpup Rifle', 				['weapontype'] = 'Assault Rifle',	['ammotype'] = 'AMMO_RIFLE',	['damagereason'] = 'Ended / Rifled / Shot down / Floored'},
	[`weapon_bullpuprifle_mk2`]		 = {['name'] = 'weapon_bullpuprifle_mk2', 	['label'] = 'Bull Puprifle MK2',			['weapontype'] = 'Assault Rifle',	['ammotype'] = 'AMMO_RIFLE',	['damagereason'] = 'Ended / Rifled / Shot down / Floored'},
	[`weapon_compactrifle`] 		 = {['name'] = 'weapon_compactrifle', 	 	['label'] = 'Compact Rifle', 				['weapontype'] = 'Assault Rifle',	['ammotype'] = 'AMMO_RIFLE',	['damagereason'] = 'Ended / Rifled / Shot down / Floored'},
	[`weapon_militaryrifle`]		 = {['name'] = 'weapon_militaryrifle', 		['label'] = 'Military Rifle',   			['weapontype'] = 'Assault Rifle',	['ammotype'] = 'AMMO_RIFLE',	['damagereason'] = 'Ended / Rifled / Shot down / Floored'},
    [`weapon_heavyrifle`] 			 = {['name'] = 'weapon_heavyrifle', 	 	['label'] = 'Heavy Rifle', 					['weapontype'] = 'Assault Rifle',	['ammotype'] = 'AMMO_RIFLE',	['damagereason'] = 'Ended / Rifled / Shot down / Floored'},

    -- Light Machine Guns
	[`weapon_mg`] 					 = {['name'] = 'weapon_mg', 			['label'] = 'Machinegun', 			['weapontype'] = 'Light Machine Gun',	['ammotype'] = 'AMMO_MG',	['damagereason'] = 'Machine gunned / Sprayed / Ruined'},
	[`weapon_combatmg`] 			 = {['name'] = 'weapon_combatmg', 		['label'] = 'Combat MG', 			['weapontype'] = 'Light Machine Gun',	['ammotype'] = 'AMMO_MG',	['damagereason'] = 'Machine gunned / Sprayed / Ruined'},
	[`weapon_combatmg_mk2`]	 		 = {['name'] = 'weapon_combatmg_mk2', 	['label'] = 'Combat MG MK2',	    ['weapontype'] = 'Light Machine Gun',	['ammotype'] = 'AMMO_MG',	['damagereason'] = 'Machine gunned / Sprayed / Ruined'},
	[`weapon_gusenberg`] 			 = {['name'] = 'weapon_gusenberg', 		['label'] = 'Thompson SMG', 		['weapontype'] = 'Light Machine Gun',	['ammotype'] = 'AMMO_MG',	['damagereason'] = 'Machine gunned / Sprayed / Ruined'},

    -- Sniper Rifles
	[`weapon_sniperrifle`] 			 = {['name'] = 'weapon_sniperrifle', 	 	['label'] = 'Sniper Rifle', 			['weapontype'] = 'Sniper Rifle',	['ammotype'] = 'AMMO_SNIPER',			['damagereason'] = 'Sniped / Picked off / Scoped'},
	[`weapon_heavysniper`] 			 = {['name'] = 'weapon_heavysniper', 	 	['label'] = 'Heavy Sniper', 			['weapontype'] = 'Sniper Rifle',	['ammotype'] = 'AMMO_SNIPER',			['damagereason'] = 'Sniped / Picked off / Scoped'},
	[`weapon_heavysniper_mk2`]		 = {['name'] = 'weapon_heavysniper_mk2', 	['label'] = 'Heavysniper MK2',	        ['weapontype'] = 'Sniper Rifle',	['ammotype'] = 'AMMO_SNIPER',			['damagereason'] = 'Sniped / Picked off / Scoped'},
	[`weapon_marksmanrifle`] 		 = {['name'] = 'weapon_marksmanrifle', 	 	['label'] = 'Marksman Rifle', 			['weapontype'] = 'Sniper Rifle',	['ammotype'] = 'AMMO_SNIPER',			['damagereason'] = 'Sniped / Picked off / Scoped'},
	[`weapon_marksmanrifle_mk2`]	 = {['name'] = 'weapon_marksmanrifle_mk2',	['label'] = 'Marksman Rifle MK2',	    ['weapontype'] = 'Sniper Rifle',	['ammotype'] = 'AMMO_SNIPER',			['damagereason'] = 'Sniped / Picked off / Scoped'},
	[`weapon_remotesniper`] 		 = {['name'] = 'weapon_remotesniper', 	 	['label'] = 'Remote Sniper', 			['weapontype'] = 'Sniper Rifle',	['ammotype'] = 'AMMO_SNIPER_REMOTE',	['damagereason'] = 'Sniped / Picked off / Scoped'},

    -- Heavy Weapons
	[`weapon_rpg`] 					 = {['name'] = 'weapon_rpg', 			      	['label'] = 'RPG', 						['weapontype'] = 'Heavy Weapons',	['ammotype'] = 'AMMO_RPG',				['damagereason'] = 'Killed / Exploded / Obliterated / Destroyed / Erased / Annihilated'},
	[`weapon_grenadelauncher`] 		 = {['name'] = 'weapon_grenadelauncher', 	  	['label'] = 'Grenade Launcher', 		['weapontype'] = 'Heavy Weapons',	['ammotype'] = 'AMMO_GRENADELAUNCHER',	['damagereason'] = 'Killed / Exploded / Obliterated / Destroyed / Erased / Annihilated'},
	[`weapon_grenadelauncher_smoke`] = {['name'] = 'weapon_grenadelauncher_smoke',	['label'] = 'Smoke Grenade Launcher',	['weapontype'] = 'Heavy Weapons',	['ammotype'] = 'AMMO_GRENADELAUNCHER',	['damagereason'] = 'Killed / Exploded / Obliterated / Destroyed / Erased / Annihilated'},
	[`weapon_minigun`] 				 = {['name'] = 'weapon_minigun', 		      	['label'] = 'Minigun', 					['weapontype'] = 'Heavy Weapons',	['ammotype'] = 'AMMO_MINIGUN',			['damagereason'] = 'Killed / Exploded / Obliterated / Destroyed / Erased / Annihilated'},
	[`weapon_firework`] 			 = {['name'] = 'weapon_firework', 		 	  	['label'] = 'Firework Launcher', 		['weapontype'] = 'Heavy Weapons',	['ammotype'] = nil,						['damagereason'] = 'Killed / Exploded / Obliterated / Destroyed / Erased / Annihilated'},
	[`weapon_railgun`] 				 = {['name'] = 'weapon_railgun', 		 	  	['label'] = 'Railgun', 					['weapontype'] = 'Heavy Weapons',	['ammotype'] = nil,						['damagereason'] = 'Killed / Exploded / Obliterated / Destroyed / Erased / Annihilated'},
	[`weapon_hominglauncher`] 		 = {['name'] = 'weapon_hominglauncher', 	 	['label'] = 'Homing Launcher', 			['weapontype'] = 'Heavy Weapons',	['ammotype'] = 'AMMO_STINGER',			['damagereason'] = 'Killed / Exploded / Obliterated / Destroyed / Erased / Annihilated'},
	[`weapon_compactlauncher`] 		 = {['name'] = 'weapon_compactlauncher',  	  	['label'] = 'Compact Launcher', 		['weapontype'] = 'Heavy Weapons',	['ammotype'] = nil,						['damagereason'] = 'Killed / Exploded / Obliterated / Destroyed / Erased / Annihilated'},
	[`weapon_rayminigun`]			 = {['name'] = 'weapon_rayminigun', 		 	['label'] = 'Ray Minigun',		        ['weapontype'] = 'Heavy Weapons',	['ammotype'] = 'AMMO_MINIGUN',			['damagereason'] = 'Killed / Exploded / Obliterated / Destroyed / Erased / Annihilated'},
    [`weapon_emplauncher`] 			 = {['name'] = 'weapon_emplauncher', 			['label'] = 'EMP Launcher', 			['weapontype'] = 'Heavy Weapons',	['ammotype'] = 'AMMO_EMPLAUNCHER',		['damagereason'] = 'Died'},

    -- Throwables
	[`weapon_grenade`] 		        = {['name'] = 'weapon_grenade', 		['label'] = 'Grenade', 			['weapontype'] = 'Throwable',	['ammotype'] = nil,				['damagereason'] = 'Bombed / Exploded / Detonated / Blew up'},
	[`weapon_bzgas`] 		        = {['name'] = 'weapon_bzgas', 			['label'] = 'BZ Gas', 			['weapontype'] = 'Throwable',	['ammotype'] = nil,				['damagereason'] = 'Died'},
	[`weapon_molotov`] 		        = {['name'] = 'weapon_molotov', 		['label'] = 'Molotov', 			['weapontype'] = 'Throwable',	['ammotype'] = nil,				['damagereason'] = 'Torched / Flambeed / Barbecued'},
	[`weapon_stickybomb`] 	        = {['name'] = 'weapon_stickybomb', 	    ['label'] = 'C4', 				['weapontype'] = 'Throwable',	['ammotype'] = nil,				['damagereason'] = 'Bombed / Exploded / Detonated / Blew up'},
	[`weapon_proxmine`] 	        = {['name'] = 'weapon_proxmine', 		['label'] = 'Proxmine Grenade', ['weapontype'] = 'Throwable',	['ammotype'] = nil,				['damagereason'] = 'Bombed / Exploded / Detonated / Blew up'},
	[`weapon_snowball`] 	        = {['name'] = 'weapon_snowball', 		['label'] = 'Snowball', 		['weapontype'] = 'Throwable',	['ammotype'] = nil,				['damagereason'] = 'Died'},
	[`weapon_pipebomb`] 	        = {['name'] = 'weapon_pipebomb', 		['label'] = 'Pipe Bomb', 		['weapontype'] = 'Throwable',	['ammotype'] = nil,				['damagereason'] = 'Bombed / Exploded / Detonated / Blew up'},
	[`weapon_ball`] 		        = {['name'] = 'weapon_ball', 			['label'] = 'Ball', 			['weapontype'] = 'Throwable',	['ammotype'] = 'AMMO_BALL',		['damagereason'] = 'Died'},
	[`weapon_smokegrenade`]         = {['name'] = 'weapon_smokegrenade', 	['label'] = 'Smoke Grenade', 	['weapontype'] = 'Throwable',	['ammotype'] = nil,				['damagereason'] = 'Died'},
	[`weapon_flare`] 		        = {['name'] = 'weapon_flare', 			['label'] = 'Flare pistol', 	['weapontype'] = 'Throwable',	['ammotype'] = 'AMMO_FLARE',	['damagereason'] = 'Died'},

    -- Miscellaneous
	[`weapon_petrolcan`] 			= {['name'] = 'weapon_petrolcan', 		 	['label'] = 'Petrol Can', 				['weapontype'] = 'Miscellaneous',	['ammotype'] = 'AMMO_PETROLCAN',		['damagereason'] = 'Died'},
	[`gadget_parachute`] 			= {['name'] = 'gadget_parachute', 		 	['label'] = 'Parachute', 				['weapontype'] = 'Miscellaneous',	['ammotype'] = nil,						['damagereason'] = 'Died'},
	[`weapon_fireextinguisher`] 	= {['name'] = 'weapon_fireextinguisher',	['label'] = 'Fire Extinguisher',		['weapontype'] = 'Miscellaneous',	['ammotype'] = nil,						['damagereason'] = 'Died'},
	[`weapon_hazardcan`]			= {['name'] = 'weapon_hazardcan',			['label'] = 'Hazardcan',			    ['weapontype'] = 'Miscellaneous',	['ammotype'] = 'AMMO_PETROLCAN',		['damagereason'] = 'Died'},
    [`weapon_fertilizercan`]		= {['name'] = 'weapon_fertilizercan',		['label'] = 'Fertilizer Can',			['weapontype'] = 'Miscellaneous',	['ammotype'] = 'AMMO_FERTILIZERCAN',	['damagereason'] = 'Died'},
	[`weapon_barbed_wire`]			= {['name'] = 'weapon_barbed_wire',			['label'] = 'Barbed Wire',				['weapontype'] = 'Miscellaneous',	['ammotype'] = nil,						['damagereason'] = 'Prodded'},
	[`weapon_drowning`]				= {['name'] = 'weapon_drowning',			['label'] = 'Drowning',					['weapontype'] = 'Miscellaneous',	['ammotype'] = nil,						['damagereason'] = 'Died'},
	[`weapon_drowning_in_vehicle`]	= {['name'] = 'weapon_drowning_in_vehicle',	['label'] = 'Drowning in a Vehicle',	['weapontype'] = 'Miscellaneous',	['ammotype'] = nil,						['damagereason'] = 'Died'},
	[`weapon_bleeding`]				= {['name'] = 'weapon_bleeding',			['label'] = 'Bleeding',					['weapontype'] = 'Miscellaneous',	['ammotype'] = nil,						['damagereason'] = 'Bled out'},
	[`weapon_electric_fence`]		= {['name'] = 'weapon_electric_fence',		['label'] = 'Electric Fence',			['weapontype'] = 'Miscellaneous',	['ammotype'] = nil,						['damagereason'] = 'Fried'},
	[`weapon_explosion`]			= {['name'] = 'weapon_explosion',			['label'] = 'Explosion',				['weapontype'] = 'Miscellaneous',	['ammotype'] = nil,						['damagereason'] = 'Killed / Exploded / Obliterated / Destroyed / Erased / Annihilated'},
	[`weapon_fall`]					= {['name'] = 'weapon_fall',				['label'] = 'Fall',						['weapontype'] = 'Miscellaneous',	['ammotype'] = nil,						['damagereason'] = 'Committed suicide'},
	[`weapon_exhaustion`]			= {['name'] = 'weapon_exhaustion',			['label'] = 'Exhaustion',				['weapontype'] = 'Miscellaneous',	['ammotype'] = nil,						['damagereason'] = 'Died'},
	[`weapon_hit_by_water_cannon`]	= {['name'] = 'weapon_hit_by_water_cannon',	['label'] = 'Water Cannon',				['weapontype'] = 'Miscellaneous',	['ammotype'] = nil,						['damagereason'] = 'Died'},
	[`weapon_rammed_by_car`]		= {['name'] = 'weapon_rammed_by_car',		['label'] = 'Rammed - Vehicle',			['weapontype'] = 'Miscellaneous',	['ammotype'] = nil,						['damagereason'] = 'Flattened / Ran over / Ran down'},
	[`weapon_run_over_by_car`]		= {['name'] = 'weapon_run_over_by_car',		['label'] = 'Run Over - Vehicle',		['weapontype'] = 'Miscellaneous',	['ammotype'] = nil,						['damagereason'] = 'Flattened / Ran over / Ran down'},
	[`weapon_heli_crash`]			= {['name'] = 'weapon_heli_crash',			['label'] = 'Heli Crash',				['weapontype'] = 'Miscellaneous',	['ammotype'] = nil,						['damagereason'] = 'Helicopter Crash'},
	[`weapon_fire`]					= {['name'] = 'weapon_fire',				['label'] = 'Fire',						['weapontype'] = 'Miscellaneous',	['ammotype'] = nil,						['damagereason'] = 'Torched / Flambeed / Barbecued'},

	-- Animals
    [`weapon_animal`]               = {['name'] = 'weapon_animal',	['label'] = 'Animal',	['weapontype'] = 'Animals',	['ammotype'] = nil,	['damagereason'] = 'Mauled'},
    [`weapon_cougar`]               = {['name'] = 'weapon_cougar',	['label'] = 'Cougar',	['weapontype'] = 'Animals',	['ammotype'] = nil,	['damagereason'] = 'Mauled'},
}


function OpenCloakroom()
    lib.registerContext({
        id = 'cloakroom',
        title = 'Cloakroom',
        options = {
        {
            title = 'Civilian Wear',
            description = 'Your offduty civilian clothes',
            icon = 'hand',
            onSelect = function()
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                end)
            end,
        },
        {
            title = 'Job Wear',
            description = 'Your onduty ambulance clothes',
            icon = 'hand',
            onSelect = function()
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                    if skin.sex == 0 then
                        TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
                    else
                        TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
                    end
                end)
            end,
        },
        }
    })
    lib.showContext('cloakroom')
end
