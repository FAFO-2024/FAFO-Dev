Config = {}

Config.Core = "qbcore" -- "esx" or "qbcore"

Config.CoreFolderName = "qb-core"  -- es_extended || qb-core

Config.PlayerLoadedEvent = "QBCore:Client:OnPlayerLoaded" -- esx:playerLoaded || QBCore:Client:OnPlayerLoaded
Config.PlayerUnloadEvent = "QBCore:Client:OnPlayerUnload" -- esx:onPlayerLogout || QBCore:Client:OnPlayerUnload

Config.Inventory = "qb" -- "qb" or "ox" or "qs" (set it as qb for lj-inventory)

Config.Target = "qb-target" -- "qtarget" -- if you ox_target, just select qb-target or qtarget (it has backwards compatibility)

Config.WantNormalShops = true -- if you want normal shops, set this to true (check normalshops.lua for more info). These are unlimited item shops which are different from the owned shops.

Config.OpenAdminCommand = "createshop"

--[[
    for ox = "nui://ox_inventory/web/images/"
    for qs = "nui://qs-inventory/html/images/"
    for qb = "nui://qb-inventory/html/images/"
    for lj = "nui://lj-inventory/html/images/"
]]--
Config.ImagePath = "nui://ps-inventory/html/images/"

Config.AllowedDurability = 50 -- (how much a item durability should be to be able to add it in the store) (only for ox inventory)

-- supports steam/license/fivem/citizenid (for qbcore)/ char1, char2 (for esx)
-- also supports snipe-menu exports ( if you use snipe-menu, it already supports by default)
Config.Permissions = {
    ["license:6d3b6254a50416697dcaa91878e2eb03d9112302"] = true,
    ["fivem:1234"] = true,
    ["steam:1234"] = true,
    ["char1:1234"] = true,
    ["citizenid"] = true,
}

Config.PerHourCost = 0 -- how much it costs per hour to keep the shop open
Config.RemoveMoneyFromAccount = "Bank" -- Bank or Cash

-- where do you want the money to go when owner of shop withdraws the money from the shop
Config.WithdrawType = "Bank" -- "Bank" or "Cash" (make sure you have capital C and B for Cash and Bank)