local vehicleAirbags = {}
local prop1 = 0
local prop2 = 0
Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        local ped2 = GetPedInVehicleSeat(vehicle, -1)

        if vehicle ~= 0 and GetVehicleEngineHealth(vehicle) <= main.damageLevel and vehicleAirbags[vehicle] == nil then
            local class = GetVehicleClass(vehicle)
            local model = GetEntityModel(vehicle)
            local allowed = true
            for k, v in pairs(main.exemptVehicleClasses) do
                if class == main.exemptVehicleClasses[k] then
                    allowed = false
                end
            end
            for k, v in pairs(main.exemptVehicleModels) do
                if model == main.exemptVehicleModels[k] then
                    allowed = false
                end
            end
            if allowed then
                vehicleAirbags[vehicle] = vehicle
                if ped2 == ped then
                    createAirbags(vehicle, true) 
                end
                TriggerEvent("airbagSound")
            end
        end
        Wait(1000)
    end
end)

function loadModel(modelName)
    RequestModel(modelName)
    while not HasModelLoaded(modelName) do
        Wait(0)
    end
end

function showIcon()
    DrawSprite('AirbagWarning', 'Warning', 0.93398439884186, 0.10763888806105, 0.10585937649012, 0.17708334326744, 0.0, 255, 255, 255, 255)
end