
function RegisterCallback(name, cbFunc)
    WaitCore()
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        Core.RegisterServerCallback(name, function(source, cb, data)
            cbFunc(source, cb, data)
        end)
    else
        Core.Functions.CreateCallback(name, function(source, cb, data)
            cbFunc(source, cb, data)
        end)
    end
end

function ExecuteSql(query, parameters)
    local IsBusy = true
    local result = nil
    if Config.SQL == "oxmysql" then
        if parameters then
            exports.oxmysql:execute(query, parameters, function(data)
                result = data
                IsBusy = false
            end)
        else
            exports.oxmysql:execute(query, function(data)
                result = data
                IsBusy = false
            end)
        end
    elseif Config.SQL == "ghmattimysql" then
        if parameters then
            exports.ghmattimysql:execute(query, parameters, function(data)
                result = data
                IsBusy = false
            end)
        else
            exports.ghmattimysql:execute(query, {}, function(data)
                result = data
                IsBusy = false
            end)
        end
    elseif Config.SQL == "mysql-async" then
        if parameters then
            MySQL.Async.fetchAll(query, parameters, function(data)
                result = data
                IsBusy = false
            end)
        else
            MySQL.Async.fetchAll(query, {}, function(data)
                result = data
                IsBusy = false
            end)
        end
    end
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end

local Avatars = {}

local FormattedToken = "Bot " .. botToken
function DiscordRequest(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/" .. endpoint, function(errorCode, resultData, resultHeaders)
            data = { data = resultData, code = errorCode, headers = resultHeaders }
        end, method, #jsondata > 0 and json.encode(jsondata) or "",
        { ["Content-Type"] = "application/json", ["Authorization"] = FormattedToken })

    while data == nil do
        Citizen.Wait(0)
    end

    return data
end

function GetPlayerInventory(source)
    local data = {}
    local Player = GetPlayer(source)
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        for _, v in pairs(Player.getInventory()) do
            local amount = v.count or v.amount
            if v and tonumber(amount) > 0 then
                local formattedData = v
                formattedData.name = string.lower(v.name)
                formattedData.label = v.label
                formattedData.amount = amount
                formattedData.image = v.image or (string.lower(v.name) .. '.png')
                table.insert(data, formattedData)
            end
        end
    else
        for _, v in pairs(Player.PlayerData.items) do
            if v then
                local amount = v.count or v.amount
                if tonumber(amount) > 0 then
                    local formattedData = v
                    formattedData.name = string.lower(v.name)
                    formattedData.label = v.label
                    formattedData.amount = amount
                    formattedData.image = v.image or (string.lower(v.name) .. '.png')
                    table.insert(data, formattedData)
                end
            end
        end
    end
    return data
end

function GetDiscordAvatar(user)
    local discordId = nil
    local imgURL = nil;
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
    end
    if discordId then
        if Avatars[discordId] == nil then
            local endpoint = ("users/%s"):format(discordId)
            local member = DiscordRequest("GET", endpoint, {})

            if member.code == 200 then
                local data = json.decode(member.data)
                if data ~= nil and data.avatar ~= nil then
                    if (data.avatar:sub(1, 1) and data.avatar:sub(2, 2) == "_") then
                        imgURL = "https://media.discordapp.net/avatars/" .. discordId .. "/" .. data.avatar .. ".gif";
                    else
                        imgURL = "https://media.discordapp.net/avatars/" .. discordId .. "/" .. data.avatar .. ".png"
                    end
                end
            else
                return Config.DefaultImage 
            end
            Avatars[discordId] = imgURL;
        else
            imgURL = Avatars[discordId];
        end   
    end
    if imgURL == nil or imgURL == false then
        imgURL = Config.DefaultImage 
    end
    return imgURL;
end

function GetIdentifier(src)
    local Player = GetPlayer(src)
    local identifier = false

    if Player then
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            identifier = Player.getIdentifier()
        else
            identifier = Player.PlayerData.citizenid
        end
    end 
    return identifier
end

function WaitCore()
    while Core == nil do
        Wait(0)
    end
end

function GetPlayer(source)
    local Player = false
    WaitCore()
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        Player = Core.GetPlayerFromId(source)
    else
        Player = Core.Functions.GetPlayer(source)
    end
    return Player
end

function GetPlayerRPName(source)
    if Config.Framework == "oldesx" or Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(tonumber(source))
        if xPlayer then
            return xPlayer.getName()
        end
    elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
        local Player = Core.Functions.GetPlayer(tonumber(source))
        if Player then
            return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        end
    end
    return GetPlayerName(source)
end

function GetPlayerSourceByIdentifier(identifier)
    while Core == nil do
        Wait(0)
    end
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        if Core.GetPlayerFromIdentifier(identifier) then
            return Core.GetPlayerFromIdentifier(identifier).source
        end
    else
        if Core.Functions.GetPlayerByCitizenId(identifier) then
            return Core.Functions.GetPlayerByCitizenId(identifier).PlayerData.source
        end
    end
end

function AddInventoryItem(src, item, amount)
    local Player = GetPlayer(src)
    amount = tonumber(amount)
    if Player then
        if Config.Inventory == "qb_inventory" then
            Player.Functions.AddItem(item, amount)
        elseif Config.Inventory == "esx_inventory" then
            Player.addInventoryItem(item, amount)
        elseif Config.Inventory == "ox_inventory" then
            if exports.ox_inventory:CanCarryItem(src, item, amount) then
                exports.ox_inventory:AddItem(src, item, amount)
            else
                TriggerClientEvent("codem-minerjob:Notify", src, "Inventory Full")
            end
        elseif Config.Inventory == "codem-inventory" then
            exports["codem-inventory"]:AddItem(src, item, amount)
        elseif Config.Inventory == "qs_inventory" then
            exports['qs-inventory']:AddItem(src, item, amount)
        end
    end
end

function RemoveItem(src, item, amount)
    local Player = GetPlayer(src)
    amount = tonumber(amount)

    if Player then
        if Config.Inventory == "qb_inventory" then
            Player.Functions.RemoveItem(item, amount)
        elseif Config.Inventory == "esx_inventory" then
            Player.removeInventoryItem(item, amount)
        elseif Config.Inventory == "ox_inventory" then
            exports.ox_inventory:RemoveItem(src, item, amount)
        elseif Config.Inventory == "codem-inventory" then
            exports["codem-inventory"]:RemoveItem(src, item, amount)
        elseif Config.Inventory == "qs_inventory" then
            exports['qs-inventory']:RemoveItem(src, item, amount)
        end
    end
end

function GetPlayerMoney(source, value)
    local Player = GetPlayer(source)
    if Player then
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            if value == 'bank' then
                return Player.getAccount('bank').money
            end
            if value == 'cash' then
                return Player.getMoney()
            end
        elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
            if value == 'bank' then
                return Player.PlayerData.money['bank']
            end
            if value == 'cash' then
                return Player.PlayerData.money['cash']
            end
        end
    end
end

function HasItem(source, item)
    local Player = GetPlayer(source)
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        if Config.Inventory == 'codem-inventory' then
            local item = exports["codem-inventory"]:CheckItemValid(source, item.name, tonumber(item.amount))
            return item
        elseif Config.Inventory == 'qs_inventory' then
            local itemCount = exports['qs-inventory']:GetItemTotalAmount(source, item.name)
            if itemCount == 0 or itemCount == nil then
                return false
            end
            return true
        else
            local playerItem = Player.getInventoryItem(item.name)
            if not playerItem then
                return false
            end
            local amount = playerItem.count or playerItem.amount
            if tonumber(amount) >= tonumber(item.amount) then
                return true
            end
        end
    else
        if Config.Inventory == 'codem-inventory' then
            local item = exports["codem-inventory"]:CheckItemValid(source, item.name, tonumber(item.amount))
            return item
        elseif Config.Inventory == 'qs_inventory' then
            local itemCount = exports['qs-inventory']:GetItemTotalAmount(source, item.name)
            if itemCount == 0 or itemCount == nil then
                return false
            end
            return true
        else
            return  Core.Functions.HasItem(source, item.name, tonumber(item.amount))
        end
    end
    return false
end


Citizen.CreateThread(function()
    local resource_name = 'codem_minerjob'
    local current_version = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
    PerformHttpRequest('https://raw.githubusercontent.com/Aiakos232/versionchecker/main/version.json',
        function(error, result, headers)
            if not result then
                print('^1Version check disabled because github is down.^0')
                return
            end
            local result = json.decode(result)
            if tonumber(result[resource_name]) ~= nil then
                if tonumber(result[resource_name]) > tonumber(current_version) then
                    print('\n')
                    print('^1======================================================================^0')
                    print('^1' .. resource_name ..
                        ' is outdated, new version is available: ' .. result[resource_name] .. '^0')
                    print('^1======================================================================^0')
                    print('\n')
                elseif tonumber(result[resource_name]) == tonumber(current_version) then
                    print('^2' .. resource_name .. ' is up to date! -  ^4 Thanks for choose CodeM ^4 ^0')
                elseif tonumber(result[resource_name]) < tonumber(current_version) then
                    print('^3' .. resource_name .. ' is a higher version than the official version!^0')
                end
            else
                print('^1' .. resource_name .. ' is not in the version database^0')
            end
        end, 'GET')
end)