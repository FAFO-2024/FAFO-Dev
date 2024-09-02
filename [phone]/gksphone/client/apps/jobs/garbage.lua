local TaskId = 1
local TaskList = {}
local GarbageJobDetails = {}
local jobName = ""
local searching = false
local searched = {}
local blip = nil
local localtionCheck = false
local checkLocation = false
local garbageObjects = {
    -1096777189,
    -58485588,
    682791951,
    666561306,
    1437508529,
    218085040,
    -228596739,
    -1426008804,
    1143474856,
    1329570871,
    651101403,
    
    
}
local garbageObject = nil

function LoadAnim(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(10) end
end

RegisterNetEvent("gksphone:client:JobStartTask", function (jobInfoName, Tasks)
    jobName = jobInfoName
    if jobInfoName == "sanitation" then
        TaskList = Tasks
        searched = {}
        if GetResourceState("ox_target") == "started" then
            local ox_options = {
                {
                    name = 'SearchGarbageBin',
                    icon = 'fas fa-trash',
                    onSelect = function()
                        if not searching then
                            if not exports["gksphone"]:IsTaskStatus(3) then
                                ThirdEyeGarbageSearch(3)
                            elseif not exports["gksphone"]:IsTaskStatus(5) then
                                ThirdEyeGarbageSearch(5)
                            end
                        end
                    end,
                    label = "Garbage Bin Search",
                    canInteract = function(entity)
                        if not entity then return false end
                        if not localtionCheck then return false end
                        if garbageObject then return false end
                        if exports["gksphone"]:IsTaskStatus(3) and exports["gksphone"]:IsTaskStatus(5) then
                            return false
                        end
                        if searching then return false else
                            return not searched[entity]
                        end
                    end,
                },
            }
            exports.ox_target:addModel(garbageObjects, ox_options)

            exports.ox_target:addGlobalVehicle({
                {
                    name = "oxPlaceGarbage",
                    label = 'Place Garbage Bag',
                    icon = 'fas fa-trash',
                    bones = 'boot',
                    distance = 2.0,
                    onSelect = function(data)
                        if garbageObject then
                            local ped = PlayerPedId()
                            FreezeEntityPosition(ped, true)
                            LoadAnim("anim@heists@narcotics@trash")
                            TaskPlayAnim(PlayerPedId(), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
                            Citizen.Wait(700)
                            FreezeEntityPosition(ped, false)
                            ClearPedTasks(ped)
                            DeleteEntity(garbageObject)
                            garbageObject = nil
                            exports["gksphone"]:TaskUpdate(TaskId, false, 1)
                        end
                    end,
                    canInteract = function (entity)
                        if garbageObject == nil then return false end
                        local car = NetworkGetEntityFromNetworkId(GarbageJobDetails.carNetworkID)
                        if (car == entity) then return true end
                    end
                }
            })
        end
    end
end)

RegisterNetEvent("gksphone:client:JobNextTask", function (NewTaskID)
    if jobName == "sanitation" then
        TaskId = NewTaskID
        if NewTaskID == 2 then
            SetNewWaypoint(GarbageJobDetails.garbageLocations.x, GarbageJobDetails.garbageLocations.y)
            StartGotoLocation(2)
        elseif NewTaskID == 3 then
            CheckLocationArrival(GarbageJobDetails.garbageLocations, true)
        elseif NewTaskID == 4 then
            CheckLocationArrival(GarbageJobDetails.garbageLocations, false)
            local isLeader = exports["gksphone"]:IsGroupLeader()
            if isLeader then
                TriggerServerEvent("gksphone:server:garbageNewLocation", GarbageJobDetails.groupID)
            end
        elseif NewTaskID == 5 then
            CheckLocationArrival(GarbageJobDetails.garbageLocations, true)
        elseif NewTaskID == 6 then
            if blip then
                RemoveBlip(blip)
            end
            CheckLocationArrival(GarbageJobDetails.garbageLocations, false)
            StartGotoLocation(6, GarbageJobDetails.carlocation)
        end
    end
end)

RegisterNetEvent("gksphone:client:jobStartLeader", function (jobname)
    if jobname == "sanitation" then
        local model = GetHashKey("trash")
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end
    end
end)

RegisterNetEvent("gksphone:client:jobStartMember", function (jobInfo)
    if jobInfo and jobInfo.jobName == "sanitation" then
        GarbageJobDetails = jobInfo
        jobName = jobInfo.jobName
        local ped = PlayerPedId()
        SetNewWaypoint(jobInfo.carlocation.x, jobInfo.carlocation.y)
        while not NetworkDoesEntityExistWithNetworkId(jobInfo.carNetworkID) do
            Citizen.Wait(300)
        end
        local car = NetworkGetEntityFromNetworkId(jobInfo.carNetworkID)
        GiveKeyCar(car)
        SetFuel(car, 100)

        while not IsPedInVehicle(ped, car, false) do
            Wait(200)
            local taskStatus = exports["gksphone"]:IsTaskStatus(1)
            if taskStatus then
                break
            end
            if IsPedInVehicle(ped, car, false) then
                exports["gksphone"]:TaskUpdate(1, true, 0)
                break
            end
        end

    end
end)

RegisterNetEvent("gksphone:client:garbageGotoNewLocation", function (jobInfo)
    GarbageJobDetails = jobInfo
    jobName = jobInfo.jobName
    SetNewWaypoint(GarbageJobDetails.garbageLocations.x, GarbageJobDetails.garbageLocations.y)
    StartGotoLocation(4)
end)

RegisterNetEvent("gksphone:client:garbageDisband", function (jobname)
    if jobname == "sanitation" then
        CheckLocationArrival(GarbageJobDetails.garbageLocations, false)
        if blip then
            RemoveBlip(blip)
        end
        if GetResourceState("ox_target") == "started" then
            exports.ox_target:removeGlobalVehicle("oxPlaceGarbage")
            exports.ox_target:removeModel("SearchGarbageBin")
        end
    end
end)

RegisterNetEvent("gksphone:client:memberKick", function (jobname)
    if jobname == "sanitation" then
        CheckLocationArrival(GarbageJobDetails.garbageLocations, false)
        if blip then
            RemoveBlip(blip)
        end
        if GetResourceState("ox_target") == "started" then
            exports.ox_target:removeGlobalVehicle("oxPlaceGarbage")
            exports.ox_target:removeModel("SearchGarbageBin")
        end
    end
end)

function StartGotoLocation(TaskID, carpos)
    local arrived = false
    local pos = carpos or GarbageJobDetails.garbageLocations
    local carID = NetworkGetEntityFromNetworkId(GarbageJobDetails.carNetworkID)
    if TaskID ~= 6 then
        if blip then
            RemoveBlip(blip)
        end
        blip = AddBlipForRadius(GarbageJobDetails.garbageLocations.x, GarbageJobDetails.garbageLocations.y, GarbageJobDetails.garbageLocations.z , 100.0)
        SetBlipHighDetail(blip, true)
        SetBlipColour(blip, 1)
        SetBlipAlpha (blip, 128)
    else
        blip = AddBlipForCoord(GarbageJobDetails.carlocation.x, GarbageJobDetails.carlocation.y, GarbageJobDetails.carlocation.z)
        SetBlipHighDetail(blip, true)
        SetBlipColour(blip, 1)
        SetBlipAlpha (blip, 128)
        SetNewWaypoint(GarbageJobDetails.carlocation.x, GarbageJobDetails.carlocation.y)

        if GetResourceState("ox_target") == "started" then
            exports.ox_target:removeGlobalVehicle("oxPlaceGarbage")
            exports.ox_target:removeModel("SearchGarbageBin")
        end
    end
    Citizen.CreateThread(function()
        while not arrived do
            --local dist = #(GetEntityCoords(PlayerPedId()) - pos)
            local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), pos.x, pos.y, pos.z, true)
            if dist < 100 and TaskID ~= 6 then
                local taskStatus = exports["gksphone"]:IsTaskStatus(TaskID)
                if taskStatus then
                    arrived = true
                    break
                end

                exports["gksphone"]:TaskUpdate(TaskID, true, 0)
                arrived = true
                break
            elseif dist < 10 and TaskID == 6 then
                local taskStatus = exports["gksphone"]:IsTaskStatus(TaskID)
                if taskStatus then
                    arrived = true
                    break
                end
                if IsVehicleSeatFree(carID, -1) then
                    exports["gksphone"]:TaskUpdate(TaskID, true, 0)
                    arrived = true
                    if blip then
                        RemoveBlip(blip)
                    end
                    TriggerServerEvent("gksphone:server:garbageReturnVehicle", GarbageJobDetails.groupID)
                    break
                end
            end
            Wait(1000)
        end
    end)
end

function ThirdEyeGarbageSearch(taskID)
    local pos = GetEntityCoords(PlayerPedId())
    for i=1, #garbageObjects do
        local garbage = GetClosestObjectOfType(pos, 10.5, garbageObjects[i], false, false, false)
        if not searched[garbage] then
            searched[garbage] = true
            searching = true
            SearchGarbage(taskID)
            break
        end
    end
end

function SearchGarbage(taskID)
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, true)
    LoadAnim('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
    TaskPlayAnim(ped,"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer",1.0, -1.0, -1, 49, 0, 0, 0, 0)
    Wait(math.random(1000,5000))
    FreezeEntityPosition(ped, false)
    ClearPedTasks(ped)
    RemoveAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
    Wait(1000)
    searching = false
    garbageObject = CreateObject(`prop_cs_rub_binbag_01`, 0, 0, 0, true, true, true)
    AttachEntityToEntity(garbageObject, ped, GetPedBoneIndex(ped, 57005), 0.12, 0.0, -0.05, 220.0, 120.0, 0.0, true, true, false, true, 1, true)
end

function CheckLocationArrival(pos, arr)
    checkLocation = arr
    localtionCheck = false
    Citizen.CreateThread(function()
        while checkLocation do
            if not checkLocation then
                break
            end
            local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), pos.x, pos.y, pos.z, true)
            if dist > 100 then
                localtionCheck = false
            else
                localtionCheck = true
            end
            Wait(1000)
        end
    end)
end