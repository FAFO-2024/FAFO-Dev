if Config.Options == "drawtext" then
-- creating bank points
    local textShown = false
    local ATMCoords = nil
    local NearbyModel = false
    CreateThread(function()
        for k, v in pairs(Locations) do
            local point = lib.points.new({
                coords = v.coords,
                distance = 2,
            })
            
            function point:onEnter()
                textShown = true
                lib.showTextUI(Locales["open_bank_text"])
            end
            
            function point:onExit()
                textShown = false
                lib.hideTextUI()
            end

            function point:nearby()
                if IsControlJustPressed(0, 38) then
                    DoProgress(true)
                end
                if bankOpen and textShown then
                    lib.hideTextUI()
                    textShown = false
                elseif not bankOpen and not textShown then
                    lib.showTextUI(Locales["open_bank_text"])
                    textShown = true
                end
            end
        end
    end)



    CreateThread(function()
        while true do
            local PlayerCoords = GetEntityCoords(PlayerPedId())
            local modelFound = false
            for k, v in pairs(Config.ATMModels) do
                if type(v) ~= "number" then
                    v = joaat(v)
                end
                ATM = GetClosestObjectOfType(PlayerCoords, 2.0, v, false, false, false)
                if ATM ~= 0 then
                    ATMCoords = GetEntityCoords(ATM)
                    if not ATMOpen then
                        if #(PlayerCoords - ATMCoords) < 2.5 then
                            NearbyModel = true
                            modelFound = true
                        else 
                            NearbyModel = false
                        end 
                    else
                        NearbyModel = false
                    end
                end
            end
            if not modelFound then
                NearbyModel = false
            end
            Wait(500)
        end
    end)

    --- Check for keypresses when nearby a dumpster.
    CreateThread(function()
        while true do
            local WaitTime = 350
            if NearbyModel then
                WaitTime = 0
                if not textShown and not ATMOpen then
                    lib.showTextUI(Locales["open_atm_text"])
                    textShown = true
                end
                if ATMOpen and textShown then
                    lib.hideTextUI()
                    textShown = false
                end
                if IsControlJustReleased(0, 38) and not ATMOpen then
                    DoProgress(false)
                end
            else
                if textShown then
                    lib.hideTextUI()
                    textShown = false
                end
            end
            Wait(WaitTime)
        end
    end)
elseif Config.Options == "target" then
    local spawnedEntity = {}
    local function SpawnPed(v)
        RequestModel(v.model)
        while not HasModelLoaded(v.model) do
            Wait(0)
        end
        local entity = CreatePed(0, GetHashKey(v.model), v.ped.x, v.ped.y, v.ped.z - 1.0, v.ped.w,  false, false)
        FreezeEntityPosition(entity, true)
        SetEntityInvincible(entity, true)
        SetBlockingOfNonTemporaryEvents(entity, true)
        exports['qb-target']:AddTargetEntity(entity, { 
        options = { 
            { 
                type = "client", 
                icon = 'fas fa-building-columns',
                label = Locales["target_label_open_bank"],
                action = function(entity)
                    DoProgress(true)
                end,
            }
        },
            distance = 2.5, 
        })
        return entity
    end
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            local pos = GetEntityCoords(PlayerPedId())
            for k, v in pairs(Locations) do
                if #(pos - vector3(v.ped.x, v.ped.y, v.ped.z)) < 50.0 then
                    if spawnedEntity[k] == nil or not DoesEntityExist(spawnedEntity[k]) then
                        spawnedEntity[k] = SpawnPed(v)
                    end
                else
                    if spawnedEntity[k] ~= nil and DoesEntityExist(spawnedEntity[k]) then
                        DeleteEntity(spawnedEntity[k])
                    end
                end
            end
        end
    end)

    exports["qb-target"]:AddTargetModel(Config.ATMModels, {
        options = {
            {
                type = "client",
                icon = "fas fa-money-bill",
                label = Locales["target_label_open_atm"],
                action = function(entity)
                    DoProgress(false)
                end,
            }
        },
        distance = 1.5
    })


    for k, v in pairs(ATMLocations) do
        exports['qb-target']:AddBoxZone("snipe_bank_atm_" .. k, v, 1, 1, {
            name = "snipe_bank_atm_" .. k,
            debugPoly = false,
            heading = -20,
            minZ = v.z - 2,
            maxZ = v.z + 2,
        }, {
            options = {
                {
                    type = "client",
                    icon = "fas fa-money-bill",
                    label = Locales["target_label_open_atm"],
                    action = function(entity)
                        DoProgress(false)
                    end,
                }
            },
            distance = 1.5
        })
    end
end
