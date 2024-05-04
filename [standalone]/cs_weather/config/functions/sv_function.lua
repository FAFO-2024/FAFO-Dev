function isPlayerAllowed(src)
    local playerIdentifiers = GetPlayerIdentifiers(src)
    local check = CodeStudio.Authorized
    local callbackValue = false

    for _, acePerm in ipairs(check) do
        if IsPlayerAceAllowed(src, acePerm) then
            callbackValue =  true
        end
    end

    for _, identifier in ipairs(playerIdentifiers) do
        if tableContains(check, identifier) then
            callbackValue = true
        end
    end
    return callbackValue
end

lib.callback.register('cs:weather:fetchPerms', function(source)
	return isPlayerAllowed(source)
end)



RegisterCommand('weather_panel', function(source)
    TriggerClientEvent('cs:weather:openUI', source)
end)



RegisterCommand('freezeweather', function(source, args)
    if source ~= 0 then
        if isPlayerAllowed(source) then
            WeatherData.FreezeWeather = not WeatherData.FreezeWeather
            if not WeatherData.FreezeWeather then
                setDynamicWeather(false)
            else
                setDynamicWeather(true)
            end
        else
            print("NOT ALLOWED")
        end
    end
end)

RegisterCommand('weather', function(source, args)
    if source ~= 0 then
        if isPlayerAllowed(source) then
            local validWeatherType = false
            if args[1] == nil then
                print("INVALID SYNTAX")
            else
                for _, weatherType in pairs(CodeStudio.WeatherTypes) do
                    if weatherType.type == string.upper(args[1]) then
                        validWeatherType = true
                    end
                end
                if validWeatherType then
                    setWeatherNew(string.upper(args[1]))
                else
                    print("INVALID WEATHER")
                end
            end
        else
            print("NOT ALLOWED")
        end
    end
end)

RegisterCommand('blackout', function(source)
    if source ~= 0 then
        if isPlayerAllowed(source) then
            WeatherData.Blackout = not WeatherData.Blackout
            setBlackout(WeatherData.Blackout)
        end
    end
end)

RegisterCommand('morning', function(source)
    if isPlayerAllowed(source) then
        TriggerEvent('cs:weather:server:setTime', {hour = 9, minute = 0})
    end
end)

RegisterCommand('noon', function(source)
    if isPlayerAllowed(source) then
        TriggerEvent('cs:weather:server:setTime', {hour = 12, minute = 0})
    end
end)

RegisterCommand('evening', function(source)
    if isPlayerAllowed(source) then
        TriggerEvent('cs:weather:server:setTime', {hour = 18, minute = 0})
    end
end)

RegisterCommand('night', function(source)
    if isPlayerAllowed(source) then
        TriggerEvent('cs:weather:server:setTime', {hour = 23, minute = 0})
    end
end)

RegisterCommand('time', function(source, args, rawCommand)
    if source ~= 0 then
        if isPlayerAllowed(source) then
            if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
                local argh = tonumber(args[1])
                local argm = tonumber(args[2])
                setTimeNew(argh, argm)
            else
                print('INVALID TIME')
            end
        else
            print("NOT ALLOWED")
        end
    end
end)



exports('setWeather', setWeatherNew)
exports('setTime', setTimeNew)
exports('setBlackout', setBlackout)
exports('setTimeFreeze', setTimeFreeze)
exports('setDynamicWeather', setDynamicWeather)
exports('getBlackoutState', function() return WeatherData.Blackout end)
exports('getTimeFreezeState', function() return WeatherData.FreezeTime end)
exports('getWeatherState', function() return WeatherData.CurrentWeather end)
exports('getDynamicWeather', function() return WeatherData.FreezeWeather end)

exports('getTime', function()
    local hour = math.floor(((baseTime+timeOffset)/60)%24)
    local minute = math.floor((baseTime+timeOffset)%60)

    return hour,minute
end)



--- compatibilty support for other weather system's ---

-- [qb-weathersync]
RegisterNetEvent('qb-weathersync:server:RequestStateSync', function()
    TriggerEvent('cs:weather:server:RequestStateSync')
end)

RegisterNetEvent('qb-weathersync:server:setWeather', function(weather)
    if not isPlayerAllowed(source) then
        return
    end
    setWeatherNew(weather)
end)

RegisterNetEvent('qb-weathersync:server:setTime', function(hour, minute)
    if not isPlayerAllowed(source) then
        return
    end
    setTimeNew(hour, minute)
end)


-- [vSync]
RegisterNetEvent('vSync:requestSync', function()
    TriggerEvent('cs:weather:server:RequestStateSync')
end)




