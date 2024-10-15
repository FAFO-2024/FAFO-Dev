local function tableContains(table, element)
    if not element or #element == 0 then
        return false
    end
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

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


lib.addCommand('weather_panel', {
    help = 'Open Weather Management',
}, function(source, _)
    if isPlayerAllowed(source) then
        TriggerClientEvent('cs:weather:openUI', source)
    end
end)

lib.addCommand('freezeweather', {
    help = 'Toggle dynamic weather',
}, function(source, _)
    if isPlayerAllowed(source) then
        WeatherData.FreezeWeather = not WeatherData.FreezeWeather
        if not WeatherData.FreezeWeather then
            setDynamicWeather(false)
        else
            setDynamicWeather(true)
        end
    end
end)


lib.addCommand('weather', {
    help = 'Change the weather',
    params = {
        {
            name = 'type',
            type = 'text',
            help = 'Available types: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween',
        },
    },
}, function(source, args)
    if isPlayerAllowed(source) then
        local validWeatherType = false
        for _, weatherType in pairs(CodeStudio.WeatherTypes) do
            if weatherType.type == string.upper(args.type) then
                validWeatherType = true
            end
        end
        if validWeatherType then
            setWeatherNew(string.upper(args.type))
        else
            print("INVALID WEATHER")
        end
    end
end)

lib.addCommand('blackout', {
    help = 'Toggle blackout mode',
}, function(source, _)
    if isPlayerAllowed(source) then
        WeatherData.Blackout = not WeatherData.Blackout
        setBlackout(WeatherData.Blackout)
    end
end)

lib.addCommand('freezetime', {
    help = 'Freeze / unfreeze time',
    params = {
        {
            name = 'time',
            type = 'number',
            help = 'Freeze time? (1 = yes, 0 = no)',
        },
    },
}, function(source, args)
    if isPlayerAllowed(source) then
        local newFreeze = args.time == 1 and true or false
        GlobalState.freezeTime = newFreeze
    end
end)


lib.addCommand('morning', {
    help = 'Set the current time to morning (9:00)',
}, function(source, _)
    if isPlayerAllowed(source) then
        setTime(9, 0)
    end
end)

lib.addCommand('noon', {
    help = 'Set the current time to noon (12:00)',
}, function(source, _)
    if isPlayerAllowed(source) then
        setTime(12, 0)
    end
end)

lib.addCommand('evening', {
    help = 'Set the current time to evening (18:00)',
}, function(source, _)
    if isPlayerAllowed(source) then
        setTime(18, 0)
    end
end)

lib.addCommand('night', {
    help = 'Set the current time to night (23:00)',
}, function(source, _)
    if isPlayerAllowed(source) then
        setTime(23, 0)
    end
end)

lib.addCommand('time', {
    help = 'Set the current time',
    params = {
        {
            name = 'hour',
            type = 'number',
            help = 'set the Hour',
        },
        {
            name = 'minute',
            type = 'number',
            help = 'set the Minute',
            optional = true
        },
    },
}, function(source, args) -- source, args
    local newHours, newMinutes = args.hour, args.minute or 0
    if isPlayerAllowed(source) then
        local newHours, newMinutes = args.hour, args.minute or 0
        setTime(newHours, newMinutes)
    end
end)




exports('setWeather', setWeatherNew)
exports('setTime', setTime)
exports('setTimeFreeze', function(state) 
    GlobalState.freezeTime = state
end)
exports('setBlackout', setBlackout)
exports('setDynamicWeather', setDynamicWeather)
exports('getBlackoutState', function() return WeatherData.Blackout end)
exports('getTimeFreezeState', function() return WeatherData.FreezeTime end)
exports('getWeatherState', function() return WeatherData.CurrentWeather end)
exports('getDynamicWeather', function() return WeatherData.FreezeWeather end)

exports('getTime', function()
    local hour = GlobalState.currentTime.hour
    local minute = GlobalState.currentTime.minute

    return hour, minute
end)

