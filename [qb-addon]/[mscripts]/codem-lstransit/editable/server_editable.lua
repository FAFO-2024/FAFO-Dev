bot_Token = "MTIzNzgxNDQ0ODEzMTkzNjM0OQ.Ga35Zq.OAY8nZWCnMVYverj_EnBuK0HYDspohM_S-JCtI"
bot_logo = "https://cdn.discordapp.com/attachments/1025789416456867961/1106324039808594011/512x512_Logo.png"
bot_name = "Codem Store"


discord_webhook = {
    ['jobfinish'] = "",
}

local key = nil
Citizen.CreateThread(function()
    key = "CODEM" .. math.random(10000, 999999999) .. "saas" .. math.random(10000, 999999999) .. "KEY"
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while Core == nil do
        Citizen.Wait(0)
    end
    RegisterCallback('codem-busjob:getKey', function(source, cb)
        cb(key)
    end)
end)




RegisterServerEvent('codem-busjob:finishJob', function(clientkey, money, npccount, stopname)
    local src = source
    if key ~= clientkey then
        DropPlayer(src, 'Codem Busjob Event Trigger.')
        return
    end
    for k, v in pairs(Config.BusjobSettings['busRouteSettings']) do
        if v.name == stopname then
            local data = playerJobData[GetIdentifier(src)]
            if not data then
                return
            end
            AddMoney(src, 'cash', tonumber(money))
            AddXPBusJob(src, tonumber(v.xp))
            data.profiledata.completejobs = data.profiledata.completejobs + 1
            data.profiledata.totalearnings = data.profiledata.totalearnings + tonumber(money)
            data.profiledata.passenger = data.profiledata.passenger + tonumber(npccount)
            local historyData = {
                ['routename'] = v.label,
                ['abbreviation'] = v.abbreviation,
                ['passenger'] = npccount,
                ['money'] = money,
                ['time'] = os.date("%m-%d-%Y %H:%M")
            }
            table.insert(data.historydata, historyData)
            local discordlog = discordloghistoryData(src, historyData)
            sendDiscordLogHistory(discordlog)
            local function updateDailyMission(missionType, increment)
                for _, missionConfig in pairs(Config.BusjobSettings['dailyMission']) do
                    if missionConfig.name == missionType and not data.dailymission[missionType].complete then
                        data.dailymission[missionType].count = data.dailymission[missionType].count + increment
                        if data.dailymission[missionType].count >= missionConfig.count then
                            data.dailymission[missionType].complete = true
                            AddXPBusJob(src, tonumber(missionConfig.xp))
                            Config.Notification(
                                string.format(Config.NotificationText['completedailymission'].text, missionConfig.xp),
                                Config.NotificationText['completedailymission'].type, true, src)
                        end
                    end
                end
            end

            for missionType, _ in pairs(data.dailymission) do
                if missionType == 'transportpassenger' then
                    updateDailyMission(missionType, npccount)
                elseif missionType == 'completeoneroute' then
                    updateDailyMission(missionType, 1)
                elseif missionType == 'earninoneroute' then
                    updateDailyMission(missionType, money)
                end
            end

            savePlayerData(src)
        end
    end
end)

function discordloghistoryData(source, data)
    local src = source
    local identifier = GetIdentifier(src)
    local dataInfo = {
        identifier = identifier,
        avatar = GetDiscordAvatar(src) or Config.ExampleProfilePicture,
        name = GetName(src),
        id = src,
        routename = data.routename,
        abbreviation = data.abbreviation,
        passenger = data.passenger,
        money = data.money,
    }
    return dataInfo
end

function sendDiscordLogHistory(data)
    local message = {
        username = bot_name,
        embeds = {
            {
                title = botname,
                color = 0xFFA500,
                author = {
                    name = 'Codem LSTRANSIT - JOB FINISH',
                },
                thumbnail = {
                    url = data.avatar
                },
                fields = {
                    { name = "Player Name", value = data.name or false, inline = true },
                    { name = "Player ID",   value = data.id or false,   inline = true },
                    {
                        name = "──────────Job Information──────────",
                        value = "",
                        inline = false
                    },
                    { name = "Route Name",   value = data.routename or false,                 inline = true },
                    { name = "Abbreviation", value = data.abbreviation or 'undefined',        inline = true },
                    { name = "Passenger",    value = tonumber(data.passenger) or 'undefined', inline = true },
                    { name = "Job Price",    value = tonumber(data.money) or 'undefined',     inline = true },

                },
                footer = {
                    text = "Codem Store - https://discord.gg/zj3QsUfxWs",
                    icon_url =
                    "https://cdn.discordapp.com/attachments/1025789416456867961/1106324039808594011/512x512_Logo.png"
                },

                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }
        },
        avatar_url = bot_logo
    }

    PerformHttpRequest(discord_webhook['jobfinish'], function(err, text, headers) end,
        "POST",
        json.encode(message),
        { ["Content-Type"] = "application/json" })
end



Citizen.CreateThread(function()
    local resource_name = 'codem_lstransit'
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