function getid(source,parametre2)

    local identifier = {}
    local identifiers = {}
 
    identifiers = GetPlayerIdentifiers(source)
  
    for i = 1, #identifiers do
        if string.match(identifiers[i], "discord:") then
            identifier["discord"] = string.sub(identifiers[i], 9)
            identifier["discord"] = "<@"..identifier["discord"]..">"
        end
        if parametre2 == 'esx' then
        if string.match(identifiers[i], "steam:") then
            identifier["license"] = identifiers[i]
        end
        else
            if string.match(identifiers[i], "license:") then
                identifier["license"] = identifiers[i]
            end
            
        end
    end
    if identifier["discord"] == nil then
        identifier["discord"] = "Bilinmiyor"
    end
    return identifier
 end
 
 function dclog(webhook, title, text, target)
    local ts = os.time()
    local time = os.date('%Y-%m-%d %H:%M:%S', ts)
    local connect = {
        {
            ["color"] = 3092790,
            ["title"] = title,
            ["description"] = text,
            ["footer"] = {
                ["text"] = "CodeM Store      " ..time,
                ["icon_url"] = Config.IconURL,
            },
        }
    }
    PerformHttpRequest(Config.PlayerWebhook, function(err, text, headers) end, 'POST', json.encode({username = Config.Botname, embeds = connect, avatar_url = Config.Logo}), { ['Content-Type'] = 'application/json' })
 end

 Citizen.CreateThread(function()
    local resource_name = 'codem_taxijob'
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