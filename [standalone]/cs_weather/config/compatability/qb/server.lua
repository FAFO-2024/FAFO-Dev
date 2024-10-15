local globalState = GlobalState

local function exportHandler(exportName, func)
    AddEventHandler(('__cfx_export_qb-weathersync_%s'):format(exportName), function(setCB)
        setCB(func)
    end)
end

exportHandler('nextWeatherStage', function()
    return print("CS WEATHER - THIS EXPORT IS NOT SUPPORTED (nextWeatherStage)")
end)

exportHandler('setDynamicWeather', function(active)
    setDynamicWeather(active)
end)


exportHandler('setWeather', function(weather)
    setWeatherNew(weather)
end)

exportHandler('setTime', function(hour, minute)
    setTime(hour, minute)
end)

exportHandler('setBlackout', function(state)
    setBlackout(state)
end)

exportHandler('setTimeFreeze', function(state)
    globalState.freezeTime = state
end)

exportHandler('getBlackoutState', function()
    return WeatherData.Blackout
end)

exportHandler('getTimeFreezeState', function()
    return WeatherData.FreezeTime
end)

exportHandler('getDynamicWeather', function()
    return WeatherData.FreezeWeather
end)

exportHandler('getWeatherState', function()
    return WeatherData.CurrentWeather
end)

exportHandler('getTime', function()
    local currentTime = globalState.currentTime

    return currentTime.hour, currentTime.minute
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
    setTime(hour, minute)
end)
