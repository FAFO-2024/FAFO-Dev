RegisterCommand('camdash', function()
    TriggerEvent('cs:bodycam:openUI')
end, false)


function Notification(msg)
    lib.notify({
        title = 'Bodycam',
        description = msg
    })

    -- Examples --

    -- [CodeStudio HUD Notification] --
    -- exports['cs_hud']:Alert('Bodycam', msg)

    --TriggerEvent('QBCore:Notify', msg)
    --TriggerEvent('esx:showNotification', msg)
end

if CodeStudio.Recording.Enable then
    RegisterCommand('recording', function()
        TriggerEvent('cs:bodycam:openRecord')
    end, false)
end

if CodeStudio.BodyCam.Use.WithCommand then
    RegisterCommand(CodeStudio.BodyCam.Use.CommandName, function()
        TriggerEvent('cs:bodycam:useBodyCam')
    end, false)
end

if CodeStudio.DashCam.Use.WithCommand then
    RegisterCommand(CodeStudio.DashCam.Use.CommandName, function()
        TriggerEvent('cs:bodycam:useDashCam')
    end, false)
end


function insideZone(data)
    if IsControlJustPressed(0, 38) then
        TriggerEvent('cs:bodycam:openUI')
    end
end

function onEnterZone(data)
    lib.showTextUI('[E] Open Dashboard')
end

function onExitZone()
    lib.hideTextUI()
end

function createTarget(coords)
    if CodeStudio.UseTarget then
        local optionLoc = {}
        if CodeStudio.UseTarget == 'ox_target' then
            table.insert(optionLoc, createTargetOption(true))
            exports[CodeStudio.UseTarget]:addBoxZone({
                coords = vec3(coords.x, coords.y, coords.z),
                size = vec3(2, 2, 2),
                rotation = 45,
                debug = CodeStudio.Debug,
                options = optionLoc,
            })
        else
            table.insert(optionLoc, createTargetOption(false))
            exports[CodeStudio.UseTarget]:AddBoxZone(
                "csBodyCamMenu"..coords,
                coords, 2, 2,
                { name="csBodyCamMenu"..coords, debugPoly = CodeStudio.Debug },
                { options = optionLoc, distance = 2.5 }
            )
        end
    end
end

function createTargetOption(onSelect)
    local targetOption = {}
    targetOption.label = "Dashboard"
    targetOption.icon = 'fa-solid fa-circle'
    if onSelect then
        targetOption.onSelect = function()
            TriggerEvent('cs:bodycam:openUI')
        end
    else
        targetOption.action = function()
            TriggerEvent('cs:bodycam:openUI')
        end
    end
    return targetOption
end


function BodyCamActive(active)
    --Trigger's When Player Equip/Unequip Bodycam
    attachBodyCam(active)
end

function dashboardOpen(toggle)
    --Function Triggers when you open/close dashboard 
end

RegisterNetEvent('cs:bodycam:toggleRecording', function() -- Use this event to start/stop recording useful if you want to integrate this in other script
    SendNUIMessage({
        action = "toggleRecording"
    })
end)


local bodyCamPos = {  -- Change prop position according to your needs.
    male = {
        bone = 24818,
        pos = vector3(0.16683200771922, 0.11320925137666, 0.11986595654326),
        rot = vector3(-14.502323044318, 82.191095946679, -164.22066869048),
    },
    female = {
        bone = 24818,
        pos = vector3(0.16683200771922, 0.11320925137666, 0.11986595654326),
        rot = vector3(-14.502323044318, 82.191095946679, -164.22066869048),
    },
}

function attachBodyCam(state)
    local gender = nil
    local coords = nil
    local rotation = nil
    local boneId = nil
    local propName = "rj_bodycam"
    local gender = IsPedModel(cache.ped, "mp_m_freemode_01")

    if gender then --Male
        coords = bodyCamPos.male.pos
        rotation = bodyCamPos.male.rot
        boneId = bodyCamPos.male.bone
    else --Female
        coords = bodyCamPos.female.pos
        rotation = bodyCamPos.female.rot
        boneId = bodyCamPos.female.bone
    end
    if state then
        if not propNetID or not DoesEntityExist(NetworkGetEntityFromNetworkId(propNetID)) then
            RequestModel(propName)
            while not HasModelLoaded(propName) do
                Wait(1)
            end
            local propEntity = CreateObject(GetHashKey(propName), 0.0, 0.0, 0.0, true, true, true)
            AttachEntityToEntity(propEntity, cache.ped, GetPedBoneIndex(cache.ped, boneId), coords.x, coords.y, coords.z, rotation.x, rotation.y, rotation.z, true, true, false, true, 1, true)
            propNetID = NetworkGetNetworkIdFromEntity(propEntity)
            SetNetworkIdExistsOnAllMachines(propNetID, true)
        end
    else
        if propNetID and DoesEntityExist(NetworkGetEntityFromNetworkId(propNetID)) then
            local propEntity = NetworkGetEntityFromNetworkId(propNetID)
            DeleteEntity(propEntity)
            propNetID = nil
        end
    end
end


if CodeStudio.BodyCam.Use.DisconnectOnNo_BodyCam and CodeStudio.BodyCam.Use.WithItem then
    if GetResourceState('ox_inventory') == 'started' or GetResourceState('qs-inventory') == 'started' then
        return
    end
    if CodeStudio.ServerType == 'QB' then
        CreateThread(function()
            while true do
                Wait(2000)
                if LocalPlayer.state.isLoggedIn then
                    local hasItem = QBCore.Functions.HasItem(CodeStudio.BodyCam.Use.ItemName, 1)
                    if not hasItem then
                        TriggerEvent('cs:bodycam:forceStop')
                    end
                end
            end
        end)
    elseif CodeStudio.ServerType == 'ESX' then
        CreateThread(function()
            while true do
                Wait(2000)
                local hasItem = ESX.SearchInventory(CodeStudio.BodyCam.Use.ItemName, 1)
                if not hasItem then
                    TriggerEvent('cs:bodycam:forceStop')
                end
            end
        end)
    end
end
