-- VALE --
--- GKSPHONE VALET APP (server) ---
-- Made by GKSHOP  | https://discord.gg/XUck63E
-- Version: 2.0.0

function IsVehicleOut(plate)
    local vehicles = GetAllVehicles()
    for _, vehicle in pairs(vehicles) do
        if DoesEntityExist(vehicle) then
            if Config.Core.Shared.Trim(GetVehicleNumberPlateText(vehicle)) == plate then
                return true, vehicle
            end
        end
    end
    return false
end

Config.Core.Functions.CreateCallback('gksphone:server:vale:getVehicles', function(source, cb)
    local xPlayer = Config.Core.Functions.GetPlayer(source)
    if not xPlayer then return; end
    local citizenid = xPlayer.PlayerData.citizenid
    MySQL.Async.fetchAll("SELECT * FROM `player_vehicles` WHERE `citizenid`=@citizenid", {
        ["@citizenid"] = citizenid
    }, function(vehicles)
        debugprint("gksphone:server:vale:getVehicles | Total vehicles: " .. #vehicles .. " | CitizenID: " .. citizenid)
        for _, v in pairs(vehicles) do
            local props = json.decode(v.mods)
            if not props then
                props = {}
            end
            props.plate = v.plate

            local vehicleData = Config.Core.Shared.Vehicles[v.vehicle]
            if vehicleData then
                v.type = vehicleData.categoryLabel
                props.model = v.vehicle
                v.model = vehicleData.name
                props.hash = vehicleData.hash
            else
                debugprint("Vehicle not found in qb-core/shared/vehicles.lua: " .. v.vehicle)
                props.model = v.vehicle
                props.hash = tonumber(v.hash)
                v.type = v.type or "Car"
                v.model = string.upper(v.vehicle) or "Unknown"
            end


            if Config.qbGarages and Config.Garages and v.garage ~= nil then
                if vehicleData and (Config.Garages[v.garage] ~= nil) then
                    if v.state == 1 then
                        v.garage = Config.Garages[v.garage]["label"]
                    else
                        v.garage = "Impounded"
                    end
                else
                    if v.state == 2 or v.state == 0 then
                        v.garage = "Impounded"
                    end
                end
            elseif Config.cdGarages and v.garage ~= nil then
                v.garage = v.garage_id
                if not v.in_garage then
                    v.garage = "On The Street"
                end
                if v.impound ~= 0 then
                    v.garage = "Impounded"
                end
            elseif Config.loafGarages and v.garage ~= nil then
                v.garage = v.garage
                if v.state == 0 then
                    v.garage = "On The Street"
                elseif v.state == 2 then
                    v.garage = "Impounded"
                end
            elseif v.garage == nil then
                v.garage = "Unknown"
            end
            v.vehicle = props
        end
        cb(vehicles)
    end)

end)

Config.Core.Functions.CreateCallback("gksphone:server:vale:vehichlepoint", function(source, cb, plate)
    local check, vehicle = IsVehicleOut(plate)
    if check and vehicle then
        local vehicleCoords = GetEntityCoords(vehicle)
        cb(true, vehicleCoords)
    else
        cb(false)
    end
end)

Config.Core.Functions.CreateCallback("gksphone:server:vale:vehiclebring", function(source, cb, plate, coords, modelType)
    local vehicle = IsVehicleOut(plate)
    if (vehicle == false) then
        modelType = modelType or "automobile"
        local xPlayer = Config.Core.Functions.GetPlayer(source)
        if not xPlayer then cb(false) end
        local citizenid = xPlayer.PlayerData.citizenid
        local BankMoney = xPlayer.PlayerData.money.bank
        local price = Config.ValePrice
        if price > BankMoney then
            debugprint("gksphone:server:vale:vehiclebring | Not enough money | CitizenID: " .. citizenid)
            cb("nomoney")
            return
        end
        MySQL.Async.fetchAll("SELECT * FROM `player_vehicles` WHERE citizenid= ? AND plate = ? ", {
            citizenid, plate
        }, function(vehicles)

            if not vehicles[1] then
                debugprint("gksphone:server:vale:vehiclebring | Vehicle not found | CitizenID: " .. citizenid .. " | Plate: " .. plate)
                cb("carnotfound")
                return
            end

            vehicles = vehicles[1]
            vehicles.mods = json.decode(vehicles.mods)
            if Config.ImpoundVale then
                if Config.cdGarages then
                    if vehicles.impound ~= 0 then
                        debugprint("gksphone:server:vale:vehiclebring | Vehicle is impounded | CitizenID: " .. citizenid .. " | Plate: " .. plate)
                        cb("carimpounded")
                        return
                    elseif not vehicles.in_garage then
                        debugprint("gksphone:server:vale:vehiclebring | Vehicle is not in garage | CitizenID: " .. citizenid .. " | Plate: " .. plate)
                        cb("carnotingarage")
                        return
                    end
                else
                    if tonumber(vehicles.state) ~= 1 then
                        debugprint("gksphone:server:vale:vehiclebring | Vehicle is impounded | CitizenID: " .. citizenid .. " | Plate: " .. plate)
                        cb("carimpounded")
                        return
                    end
                end
            end

            if xPlayer.Functions.RemoveMoney('bank', Config.ValePrice, "vale") then
                local phoneData = exports["gksphone"]:GetPhoneDataByCitizenID(citizenid)
                if phoneData then
                    local BankHistorySave = exports["gksphone"]:bankHistorySave(phoneData.phone_number, 1, Config.ValePrice, "Vale Kullanım", phoneData.unique_id)
                    if BankHistorySave then
                        debugprint("gksphone:server:vale:vehiclebring | Vehicle bringing fee | CitizenID: " .. citizenid .. " | Plate: " .. plate .. " | Price: " .. Config.ValePrice)
                    end
                end

                local model = GetHashKey(vehicles.vehicle)
                model = type(model) == 'string' and joaat(model) or model

                local heading = coords.w and coords.w or 0.0
                local vehicleBring = VehicleSpawn(source, model, coords, heading, modelType)
                Wait(1000)
                debugprint("vehicleBring", vehicleBring, model, coords, heading, modelType)
                if not vehicleBring  or not DoesEntityExist(vehicleBring) then
                    debugprint("gksphone:server:vale:vehiclebring | Vehicle not spawned | CitizenID: " .. citizenid .. " | Plate: " .. plate)
                    xPlayer.Functions.AddMoney('bank', Config.ValePrice, "vale")
                    cb("error")
                    return
                end

                local oxyNetId = NetworkGetNetworkIdFromEntity(vehicleBring)

                if Config.cdGarages then
                    MySQL.Async.execute('UPDATE player_vehicles SET  `in_garage` = @in_garage WHERE `plate` = @plate', {
                        ['@plate'] = plate,
                        ['@in_garage'] = 0,
                    })
                    debugprint("gksphone:server:vale:vehiclebring | CD Vehicle Vehicle state changed | CitizenID: " .. citizenid .. " | Plate: " .. plate .. " | in_garage: 0")
                else
                    MySQL.Async.execute('UPDATE player_vehicles SET `state` = @state WHERE `plate` = @plate', {
                        ['@plate'] = plate,
                        ['@state'] = 0,
                    })
                    debugprint("gksphone:server:vale:vehiclebring | Qb Vehicle state changed | CitizenID: " .. citizenid .. " | Plate: " .. plate .. " | State: 0")
                end
                
                debugprint("gksphone:server:vale:vehiclebring | Vehicle spawned | CitizenID: " .. citizenid .. " | Plate: " .. plate)
                debugprint("Test", {vehicleBring, vehicles})
                cb(oxyNetId, vehicles)
            else
                debugprint("gksphone:server:vale:vehiclebring | Not enough money | CitizenID: " .. citizenid .. " | Plate: " .. plate)
                cb("nomoney")
                return
            end
        end)

    else
        debugprint("Car Out | source: " .. source .. " | Plate: " .. plate)
        cb("carout")
    end
end)

function VehicleSpawn(source, model, coords, heading, modelType)
    debugprint("VehicleSpawn | Model: " .. model .. " | Coords: " .. json.encode(coords) .. " | Heading: " .. heading .. " | ModelType: " .. modelType)
    local createdVehicle = CreateVehicleServerSetter(model, modelType, coords.x, coords.y, coords.z, heading)
    Wait(1000)
    if not DoesEntityExist(createdVehicle) then
        return print("[^1GKSPHONE ERROR^7] Unfortunately, this vehicle has not spawned")
    end
    return createdVehicle
end