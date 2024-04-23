if Config.WantNormalShops then
    CreateThread(function()
        while true do
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            for k,v in pairs(Config.NormalShops) do
                for index, locationData in pairs(v.locations) do
                    local dist = #(pos - vec3(locationData.coords.x, locationData.coords.y, locationData.coords.z-1.0))
                    if dist <= 150.0 then
                        if locationData.obj == nil then
                            RequestModel(locationData.ped)
                            while not HasModelLoaded(locationData.ped) do
                                Citizen.Wait(1)
                            end
                            local ped = CreatePed(4, GetHashKey(locationData.ped), vec3(locationData.coords.x, locationData.coords.y, locationData.coords.z-1.0), locationData.coords.w, false, false)
                            FreezeEntityPosition(ped, true)
                            SetEntityInvincible(ped, true)
                            SetBlockingOfNonTemporaryEvents(ped, true)
                            SetEntityHeading(ped, locationData.coords.w)
                            TaskStartScenarioInPlace(ped, locationData.scenario, 0, true)
                            locationData.obj = ped
                            SetTargetExportsForNormalShops(locationData.obj, v)
                        end
                    else
                        if locationData.obj then
                            DeleteEntity(locationData.obj)
                            locationData.obj = nil
                        end
                    end
                end
            end
            Wait(1000)
        end
    end)

    CreateThread(function()
        for k, v in pairs(Config.NormalShops) do
            if v.blip then
                for index, locationData in pairs(v.locations) do
                    local blip = AddBlipForCoord(locationData.coords.x, locationData.coords.y, locationData.coords.z)
                    SetBlipSprite(blip, v.blip.id)
                    SetBlipDisplay(blip, 4)
                    SetBlipScale(blip, v.blip.scale)
                    SetBlipColour(blip, v.blip.colour)
                    SetBlipAsShortRange(blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.name)
                    EndTextCommandSetBlipName(blip)
                end
            end
        end
    end)
end

function SetTargetExportsForNormalShops(entity, data)
    if data.job then
        exports["qb-target"]:AddTargetEntity(entity, {
            options = {
                {
                    event = "snipe-ownedshops:client:canOpenShop",
                    icon = "fas fa-shopping-cart",
                    label = "Shop",
                    shopData = data,
                    job = data.job,
                },
            },
            distance = 1.5
        })
    else
        exports["qb-target"]:AddTargetEntity(entity, {
            options = {
                {
                    event = "snipe-ownedshops:client:canOpenShop",
                    icon = "fas fa-shopping-cart",
                    label = "Shop",
                    shopData = data,
                },
            },
            distance = 1.5
        })
    end
end

-- CreateBlip


RegisterNetEvent("snipe-ownedshops:client:canOpenShop", function(data)
    if data.shopData.License and Config.Core == "qbcore" then
        local p = promise.new()
        TriggerCallback("getLicenseStatus", function(result)
            p:resolve(result)
        end)

        local result = Citizen.Await(p)
        local hasLicense, hasLicenseItem = result[1], result[2]
        if hasLicense and hasLicenseItem then
            TriggerEvent("snipe-ownedshops:client:openNormalShop", data)
        else
            -- QBCore.Functions.Notify("You don't have a license to open this shop", "error")
            local returnData = data
            for k, v in pairs(returnData.shopData.items) do
                if v.needsLicense then
                    returnData.shopData.items[k] = nil
                end
            end
            TriggerEvent("snipe-ownedshops:client:openNormalShop", returnData)
        end
    else
        TriggerEvent("snipe-ownedshops:client:openNormalShop", data)
    end
end)