RegisterNetEvent('gksphone:server:loafhouseTransfer', function(houseData, PhoneNumber)
    local src = source
    local phoneData = GetPhoneDataByNumber(PhoneNumber)
    if phoneData then
        debugprint('loafHouse transfer', houseData, PhoneNumber)
        if phoneData.setup_owner ~= nil then
            local PlayerData = Config.Core.Functions.GetPlayerByCitizenId(phoneData.setup_owner)
            if PlayerData ~= nil then
                TriggerClientEvent('gksphone:client:transferHouse', src, PlayerData.PlayerData.source, houseData.id)
            else
                debugprint('loafHouse transfer fail', houseData, PhoneNumber)
            end
        else
            debugprint('loafHouse transfer fail', houseData, PhoneNumber)
        end
    else
        debugprint('loafHouse transfer fail', houseData, PhoneNumber)
    end
end)

Config.Core.Functions.CreateCallback('gksphone:server:getCizitinIDSource', function(source, cb, data)
    debugprint("gksphone:server:getCizitinIDSource", data)
    local phoneData = GetPhoneDataByNumber(data)
    if phoneData then
        debugprint('House transfer', data)
        if phoneData.setup_owner ~= nil then
            local PlayerData = Config.Core.Functions.GetPlayerByCitizenId(phoneData.setup_owner)
            if PlayerData ~= nil then
                cb(phoneData.setup_owner, PlayerData.PlayerData.source)
            else
                debugprint('House transfer fail 1 ', data)
                cb(nil)
            end
        else
            debugprint('House transfer fail 2', data)
            cb(nil)
        end
    else
        debugprint('House transfer fail 3', data)
        cb(nil)
    end
end)