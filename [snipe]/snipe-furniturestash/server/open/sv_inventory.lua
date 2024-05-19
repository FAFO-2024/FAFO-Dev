local function placeStash(_, data, inv, x, y)
    if CanPlace(inv.id) then
        TriggerClientEvent("snipe-furniturestash:client:placeStash", inv.id, data.name, inv.items[x].metadata.stash_id or nil, x)
    end
end

exports("placeStash", placeStash)

CreateThread(function()
    if Config.Inventory == "qb" then
        for k, v in pairs(Config.FurnitureStash) do
            QBCore.Functions.CreateUseableItem(k, function(source, item)
                if CanPlace(source) then
                    local stash_id = nil
                    if item.info and item.info.stash_id then
                        stash_id = item.info.stash_id
                    end
                    TriggerClientEvent("snipe-furniturestash:client:placeStash", source, k, stash_id, item.slot)
                end
            end)
        end

    elseif Config.Inventory == "qsv2" then
        for k, v in pairs(Config.FurnitureStash) do
            exports['qs-inventory']:CreateUsableItem(k, function(source, item)
                if CanPlace(source) then
                    local stash_id = nil
                    if item.info and item.info.stash_id then
                        stash_id = item.info.stash_id
                    end
                    TriggerClientEvent("snipe-furniturestash:client:placeStash", source, k, stash_id, item.slot)
                end
            end)
        end
    end
end)

function RemoveItem(source, item, slot)
    local amount = 1
    if Config.Inventory == "ox" then
        if exports.ox_inventory:RemoveItem(source, item, amount, nil,  slot) then
            return true
        else
            return false
        end
    elseif Config.Framework == "qb" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer.Functions.RemoveItem(item, amount, slot) then
            return true
        else
            return false
        end
    elseif Config.Framework == "esx" and Config.Inventory == "qsv2" then
        if exports['qs-inventory']:RemoveItem(source, item, amount, slot) then
            return true
        else
            return false
        end
    end
end

function AddItem(source, item, metadata)
    if Config.Inventory == "ox" then
        if exports.ox_inventory:AddItem(source, item, 1, metadata) then
            return true
        else
            return false
        end
    elseif Config.Framework == "qb" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer.Functions.AddItem(item, 1, false, metadata) then
            return true
        else
            return false
        end
    elseif Config.Framework == "esx" and Config.Inventory == "qsv2" then
        if exports['qs-inventory']:CanCarryItem(source, item, 1) then
            if exports['qs-inventory']:AddItem(source, item, 1, nil, metadata) then
                return true
            else
                return false
            end
        else
            return false
        end
    end
end

function AddItemWithoutMetadata(source, item, amount)
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player.Functions.AddItem(item, amount) then
            return true
        else
            return false
        end
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.canCarryItem(item, amount) then
            xPlayer.addInventoryItem(item, amount)
            return true
        else
            return false
        end
    end
end


function CheckHasItemsInStash(stash_id)
    if Config.Inventory == "ox" then
        local items = exports.ox_inventory:GetInventoryItems("furniture_stash_"..stash_id)
        print(json.encode(items))
        if next(items) then
            return true
        else
            return false
        end
    elseif Config.Framework == "qb" then
        local items = MySQL.scalar.await('SELECT items FROM stashitems WHERE stash = ?', { "furniture_stash_"..stash_id })
        if items and next(json.decode(items)) then
            return true
        else
            return false
        end
    elseif Config.Inventory == "qsv2" then
        local items = exports['qs-inventory']:GetStashItems("furniture_stash_"..stash_id )
        if items and next(items) then
            return true
        else
            return false
        end
    end
end