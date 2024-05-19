local spawnedEntity = {}

local function CanOpenMotelMenu()
    -- here if you want to lock it to a job/gang/etc that they can access this menu, you can add that here.
    --  (NO SUPPORT WILL BE GIVEN TO INCORPORATE OTHER PAID SCRIPTS!!!)
    return true
end

local function onNearbyPed(point)
    if point.isClosest then
        SetDrawOrigin(point.coords.x, point.coords.y, point.coords.z + 0.4)
        DrawSprite(Sprites["select"].textDict, Sprites["select"].textName, 0, 0, Sprites["select"].width, Sprites["select"].height, 0, 255, 255,255, 500)
        ClearDrawOrigin()
        if IsControlJustPressed(0, 38) then
            if not CanOpenMotelMenu() then return end
            OpenMotelMenu()
        end
    end
end

if not Config.TargetOrInteract then
    for k,v in pairs(Config.PedLocations) do
        local point = lib.points.new({
            coords = v.coords,
            distance = 5.0,
            nearby = onNearbyPed
        })
    end
end

local function SpawnPed(data)
    while not HasStreamedTextureDictLoaded("motel") do
        RequestStreamedTextureDict("motel", false)
        Wait(0)
    end
    RequestModel(data.model)
    while not HasModelLoaded(data.model) do
        Wait(0)
    end
    local entity = CreatePed(0, GetHashKey(data.model), data.coords.x, data.coords.y, data.coords.z - 1.0, data.coords.w,  false, false)
    FreezeEntityPosition(entity, true)
    SetEntityInvincible(entity, true)
    SetBlockingOfNonTemporaryEvents(entity, true)
    SetEntityHeading(entity, data.coords.w)
    if Config.TargetOrInteract and GetResourceState("interact") == "started" then
        data.interaction = exports.interact:AddLocalEntityInteraction({
            entity = entity,
            offset = vector3(0.0, 0.0, 0.2),
            label = "Moonshine",
            distance  = 6.0,
            interactDst = 2.0, -- optional
            ignoreLos = true, -- optional
            options = {
                {
                    label = "Open Motel Menu",
                    action = function()
                        OpenMotelMenu()
                    end,
                    canInteract = function()
                        return CanOpenMotelMenu()
                    end
                },
            }
        })
    else
        exports["qb-target"]:AddTargetEntity(entity, {
            options = {
                {
                    action = OpenMotelMenu,
                    icon = "fas fa-door-open",
                    label = "Open Motel Menu",
                    canInteract = function()
                        return CanOpenMotelMenu()
                    end
                }
            },
            distance = 1.5
        })
    end
    return entity
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local pos = GetEntityCoords(PlayerPedId())
        for k, v in pairs(Config.PedLocations) do
            if #(pos - vector3(v.coords.x, v.coords.y, v.coords.z)) < 50.0 then
                if spawnedEntity[k] == nil or not DoesEntityExist(spawnedEntity[k]) then
                    spawnedEntity[k] = SpawnPed(v)
                end
            else
                if spawnedEntity[k] ~= nil and DoesEntityExist(spawnedEntity[k]) then
                    if v.interaction ~= nil then
                        exports.interact:RemoveInteraction(v.interaction)
                    end
                    DeleteEntity(spawnedEntity[k])
                end
            end
        end
    end
end)

