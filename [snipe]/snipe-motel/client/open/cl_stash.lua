function OpenStash(stash_id)
    if Config.Inventory == "qb" or Config.Inventory == "qs" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "motel_stash_"..stash_id, {
            maxweight = Config.StashSize,
            slots = Config.StashSlots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", "motel_stash_"..stash_id)
    elseif Config.Inventory == "ox" then
        TriggerServerEvent("snipe-apartments:server:registerStash", "motel_stash_"..stash_id, "ox")
        exports.ox_inventory:openInventory("stash", "motel_stash_"..stash_id)
    elseif Config.Inventory == "mf" then
        TriggerServerEvent("snipe-apartments:server:registerStash", "motel_stash_"..stash_id, "mf")
        exports['mf-inventory']:openOtherInventory("motel_stash_"..stash_id)
    elseif Config.Inventory == "codem" then
        TriggerServerEvent('codem-inventory:server:openstash', 'motelstash'..stash_id, Config.StashSlots ,Config.StashSize, 'STASH')
    end
    -- elseif Config.Inventory == "esx" then
    --     TriggerEvent("esx_inventoryhud:openStash", "apartment-" .. tostring(roomNumber))
    -- end
end