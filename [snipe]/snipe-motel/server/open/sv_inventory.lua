RegisterNetEvent("snipe-apartments:server:registerStash", function(stashId, inventory)
    if inventory == "ox" then
        exports.ox_inventory:RegisterStash(stashId, "Motel Stash", Config.StashSlots, Config.StashSize)
    elseif inventory == "mf" then
        -- exports['mf-inventory']:registerInventory(stashId, "Motel Stash", Config.StashSlots, Config.StashSize)
        local result = exports['mf-inventory']:getInventory(stashId)

        if not result then
            exports['mf-inventory']:createInventory(stashId, 'inventory', 'stash', stashId, Config.StashSize, Config.StashSlots)
        end
    end
end)