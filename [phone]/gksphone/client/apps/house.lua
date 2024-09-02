--- GKSPHONE HOUSE APP ---
-- Made by GKSHOP  | https://discord.gg/XUck63E
-- Version: 2.0.0

RegisterNuiCallback("gksphone:home:fetchHouseData", function (data, cb)
    if Config.loafHouse then
        local ownedHouses = exports.loaf_housing:GetOwnedHouses()
        debugprint('loafHouse ownedHouses', ownedHouses)
        cb(ownedHouses)
    elseif Config.bcs_housing then
        local ownedHouses = exports.bcs_housing:GetOwnedHomes()
        debugprint('bcs_housing ownedHouses', ownedHouses)
        cb(ownedHouses)
    elseif Config.QsHousing then
        Config.Core.Functions.TriggerCallback('qb-phone:server:GetPlayerHouses', function(result)
            debugprint('get house qs-housing', result)
            for i = 1, #result do
                result[i].transfer = false
            end
            cb(result)
        end)
    else
        Config.Core.Functions.TriggerCallback('qb-phone:server:GetPlayerHouses', function(result)
            debugprint('qb-phone:server:GetPlayerHouses', result)
            cb(result)
        end)
    end
end)

RegisterNUICallback('gksphone:home:fetchKeysData', function(data, cb)
    if Config.loafHouse then
        local keys = exports.loaf_keysystem:GetKeys()
        local properties = {}
        for _, v in pairs(keys) do
            local _, _, propertyId = v.key_id:find("housing_key_(.*)_")
            if propertyId then
                properties[tonumber(propertyId)] = {HouseData = {adress = v.key_data.name}, id = tonumber(propertyId)}
            end
        end
        debugprint('loafHouse properties', properties)
        cb(properties)
    elseif Config.bcs_housing then
        local houses = exports.bcs_housing:GetOwnedHomeKeys()
        debugprint('bcs_housing houses', houses)
        local keys = {}
        for i = 1, #houses do
            houses[i].label = houses[i].properties.name
            houses[i].name = houses[i].identifier
            houses[i].tier = 1
            houses[i].coords = houses[i].entry
            houses[i].keyholders = exports.bcs_housing:GetKeyHolders(houses[i].identifier)
            keys[#keys + 1] = {
                HouseData = houses[i]
            }
        end
        debugprint('bcs_housing keys', keys)
        cb(keys)
    elseif Config.QsHousing then
        Config.Core.Functions.TriggerCallback('qb-phone:server:GetHouseKeys', function(result)
            debugprint('get key qs-housing', result)
            cb(result)
        end)
    else
        Config.Core.Functions.TriggerCallback('qb-phone:server:GetHouseKeys', function(result)
            debugprint('qb-phone:server:GetHouseKeys', result)
            cb(result)
        end)
    end
end)

RegisterNUICallback('gksphone:home:transferHouse', function(data, cb)
    if Config.loafHouse then
        debugprint('loafHouse transfer', data)
        TriggerServerEvent('gksphone:server:loafhouseTransfer', data.house, data.phoneNumber)
    elseif Config.bcs_housing then
        debugprint('bcs_housing transfer', data)
        Config.Core.Functions.TriggerCallback('gksphone:server:getCizitinIDSource', function(citizenid, source)
            if citizenid and source then
                local srcid = source
                TriggerServerEvent('Housing:server:TransferOwner', data.house.identifier, tonumber(srcid))
            end
        end, data.phoneNumber)
    elseif Config.QsHousing then
        cb(false)
        return
    else
        debugprint('qb-phone:server:TransferHouse', data)
        Config.Core.Functions.TriggerCallback('gksphone:server:getCizitinIDSource', function(citizenid)
            debugprint("TransferHouse Qb-Core",citizenid )
            if citizenid then
                local TransferedCid = citizenid
                CreateThread(function()
                    Config.Core.Functions.TriggerCallback('qb-phone:server:TransferCid', function(transfer)
                        if transfer then
                            local notify = {
                                title = _T(lastItemData?.info?.phoneLang, "HouseAPP.APP_HOUSE_TITLE"), -- The title of the notification
                                message = _T(lastItemData?.info?.phoneLang, "HouseAPP.APP_HOME_TRANSFERSUCCESS"), -- The message of the notification
                                icon = "/html/img/icons/house.png", -- The icon to be displayed with the notification
                            }

                            exports["gksphone"]:Notification(notify)
                        end
                    end, TransferedCid, data.house)
                end)
            end
        end, data.phoneNumber)
    end
    cb('ok')
end)

RegisterNetEvent('gksphone:client:transferHouse', function (HouseID)
    debugprint('gksphone:client:transferHouse', HouseID)
    exports.loaf_housing:TransferProperty(proptyid, plyaerid)
    -- Notification (Ev saihibi)
    local notify = {
        title = _T(lastItemData?.info?.phoneLang, "HouseAPP.APP_HOUSE_TITLE"), -- The title of the notification
        message = _T(lastItemData?.info?.phoneLang, "HouseAPP.APP_HOME_TRANSFERSUCCESS"), -- The message of the notification
        icon = "/html/img/icons/house.png", -- The icon to be displayed with the notification
    }

    exports["gksphone"]:Notification(notify)
end)

RegisterNUICallback('gksphone:home:houseLocation', function(data, cb)
    if Config.loafHouse then
        exports.loaf_housing:MarkProperty(data.id)
        local notify = {
            title = _T(lastItemData?.info?.phoneLang, "HouseAPP.APP_HOUSE_TITLE"), -- The title of the notification
            message = _T(lastItemData?.info?.phoneLang, "HouseAPP.APP_HOUSE_SETGPS"), -- The message of the notification
            icon = "/html/img/icons/house.png", -- The icon to be displayed with the notification
        }

        -- Trigger the notification using the gksphone exports
        exports["gksphone"]:Notification(notify)

        debugprint('Set waypoint for LOAF House')
    elseif Config.bcs_housing then
        exports.bcs_housing:SetWaypoint(data.HouseData.name)
        local notify = {
            title = _T(lastItemData?.info?.phoneLang, "HouseAPP.APP_HOUSE_TITLE"), -- The title of the notification
            message = _T(lastItemData?.info?.phoneLang, "HouseAPP.APP_HOUSE_SETGPS"), -- The message of the notification
            icon = "/html/img/icons/house.png", -- The icon to be displayed with the notification
        }

        -- Trigger the notification using the gksphone exports
        exports["gksphone"]:Notification(notify)
        debugprint('Set waypoint for BCS House')
    else
        SetNewWaypoint(data.HouseData.coords.enter.x, data.HouseData.coords.enter.y)
        local notify = {
            title = _T(lastItemData?.info?.phoneLang, "HouseAPP.APP_HOUSE_TITLE"), -- The title of the notification
            message = _T(lastItemData?.info?.phoneLang, "HouseAPP.APP_HOUSE_SETGPS"), -- The message of the notification
            icon = "/html/img/icons/house.png", -- The icon to be displayed with the notification
        }

        -- Trigger the notification using the gksphone exports
        exports["gksphone"]:Notification(notify)
        debugprint('Set waypoint for other house')
    end
    cb('ok')
end)