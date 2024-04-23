local function openInput(name, amount, shopId, slot)
    Wait(100)
    local input = lib.inputDialog(Locales["add_amount"]..' '..itemTable[name].label, {
        {type = 'number', label = itemTable[name].label, description = 'Maximum: '..amount, min = 1, max = amount,},
    })
    if input then
        TriggerServerEvent("snipe-ownedshops:server:addItems", shopId, name, input[1], slot)
    end
end

local function GetPlayerInventory()
    local returnData = {}
    if Config.Inventory == "ox" then
        local playerItems = exports.ox_inventory:GetPlayerItems()
        for k, v in pairs(playerItems) do
            Wait(10)
            local p = promise.new()
            TriggerCallback("snipe-ownedshops:server:isDegradeValid", function(result)
                p:resolve(result)
            end, v.slot)
            
            local canAdd = Citizen.Await(p)
            if canAdd then
                returnData[#returnData + 1] = {
                    label = v.label,
                    count = v.count,
                    name = v.name,
                    image = GetImagePath(v.name),
                    slot = v.slot,
                }
            end
        end
        return returnData
    elseif Config.Core == "esx" then
        if Config.Inventory == "qs" then
            local playerItems = exports['qs-inventory']:getUserInventory()
            for k, v in pairs(playerItems) do
                returnData[v.name] = {
                    label = v.label,
                    count = v.amount,
                    name = v.name,
                    image = GetImagePath(v.name),
                    slot = v.slot,
                }
            end
            return returnData
        end
    elseif Config.Core == "qbcore" then
        local playerItem = QBCore.Functions.GetPlayerData().items
        for k, v in pairs(playerItem) do
            returnData[v.name] = {
                label = v.label,
                count = v.amount,
                name = v.name,
                image = GetImagePath(v.name),
                slot = v.slot,
            }
        end
        return returnData
    end
end

RegisterNetEvent("snipe-ownedshops:client:addItems", function(data)
    currentShopId = data.shopData.id
    
    local shopData = GetShopDataById(currentShopId)
    local p = promise.new()
    TriggerCallback("snipe-ownedshops:server:canAddItems", function(result)
        p:resolve(result)
    end, shopData.owner, shopData.access)
    local canAddItems = Citizen.Await(p)
    if not canAddItems then
        ShowNotification(Locales["no_perms_to_add"], "error")
        return
    end    
    local playerInventory = {}
    local allowAll = shopData.allowAll or false
    local whitelistedItems = shopData.whitelistedItems or {}
    local options = {}
    local playerInventory = GetPlayerInventory()
    for k, v in pairs(playerInventory) do
        if (not allowAll and whitelistedItems[v.name]) or (allowAll) then
            options[#options + 1] = {
                image = Config.ImagePath..""..v.name..".png",
                title = v.label,
                description = "Available "..v.count.. " | Slot: "..v.slot,
                icon = 'hand',
                onSelect = function()
                    openInput(v.name, v.count, data.shopData.id, v.slot)
                end
            }
        end
    end

    lib.registerContext({
        id = 'shop_add_item_menu',
        title = Locales["add_item_title"],
        options = options,
    })
    lib.showContext('shop_add_item_menu')
end)


function GetImagePath(name)
    if Config.Inventory == "ox" then
        return Config.ImagePath..""..name..".png"
    elseif Config.Inventory == "qs" then
        return Config.ImagePath..""..itemTable[name].image
    elseif Config.Inventory == "qb" then
        return Config.ImagePath..""..itemTable[name].image
    end
end
