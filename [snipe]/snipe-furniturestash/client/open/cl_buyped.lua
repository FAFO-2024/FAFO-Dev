local spawnedEntity = {}


local valueTableForCashBank = {
    {label = "Cash", value = "cash"},
    {label = "Bank", value = "bank"},
}

function BuyItems(name, price, label)

    local input = lib.inputDialog( string.format(Locales["enter_amount_title"], label), {
        { type = 'number', label = "Enter Amount" , min = 1},
        {type = 'select', label = "Pay Type", options = valueTableForCashBank, value = "cash", required = true, default = "cash"}
    })
    if not input then return end
    lib.callback.await("snipe-furniturestash:server:buyItems", false, name, price, input[1], input[2])
end

local function OpenStore(items)
    local options = {}

    for k, v in pairs(items) do
        table.insert(options, {
            title = v.label,
            description = "Price $"..v.price,
            onSelect = function()
                BuyItems(k, v.price, v.label)
            end,
            metadata = {
                {label = "Slot" , value = v.slot},
                {label = "Size" , value = tostring(v.size/1000).."KG"},
            }
        })
        
    end
    
    lib.registerContext({
        id = "buyFurnitureStashes",
        title = "Furniture Stash Store",
        options = options,
    })
    lib.showContext("buyFurnitureStashes")
end


local function SpawnPed(data)
    RequestModel(data.model)
    while not HasModelLoaded(data.model) do
        Wait(0)
    end
    local entity = CreatePed(0, GetHashKey(data.model), data.coords.x, data.coords.y, data.coords.z - 1.0, data.coords.w,  false, false)
    FreezeEntityPosition(entity, true)
    SetEntityInvincible(entity, true)
    SetBlockingOfNonTemporaryEvents(entity, true)
    SetEntityHeading(entity, data.coords.w)
    exports['qb-target']:AddTargetEntity(entity, { 
    options = { 
        { 
            type = "client", 
            action = function ()
                OpenStore(Config.FurnitureStash)
            end,
            icon = 'fas fa-circle',
            label = 'Store',
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
        for k, v in pairs(Config.BuyPed) do
            if #(pos - vector3(v.coords.x, v.coords.y, v.coords.z)) < 50.0 then
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