
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

RegisterNetEvent('routingbucket:SetRoutingBucket', function()
    local src = source
    SetBucketToUse(src)
end)

RegisterNetEvent('routingbucket:ClearRoutingBucket', function()
local src = source
ReturnToGameDefaultBucket(src)
end)

-- Default value will always return as 0
function SelectBucketToUse()
   return GetResourceKvpInt('BucketsInUse')
end

-- Checks the internal game storage for the value in the function above, and if it exists
-- It adds one to it. The idea being if 5 players are at the same screen they'll be in 5 
-- different routing buckets
function SetBucketToUse(PlayerId)
    local bucketid = SelectBucketToUse()
    local newid = bucketid + 1
    SetPlayerRoutingBucket(PlayerId, newid)
    SetResourceKvpInt('BucketsInUse', newid)
end

-- Function that returns the player to the default bucket, then removes the value of the kvp data by 1
function ReturnToGameDefaultBucket(PlayerId)
    local bucketid = SelectBucketToUse()
    local newid = bucketid - 1
    SetPlayerRoutingBucket(PlayerId, 0)
    SetResourceKvpInt('BucketsInUse', newid)
end