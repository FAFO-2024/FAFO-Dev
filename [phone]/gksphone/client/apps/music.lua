--- GKSPHONE MUSIC APP ---
-- Made by GKSHOP  | https://discord.gg/XUck63E
-- Version: 2.0.0
xSound = exports.xsound
local musicData = {}
local volume = 0.2

RegisterNUICallback('gksphone:musicListen', function(data, cb)
    debugprint("Listening to music", data)
    if GetResourceState('xsound') == 'started' then
        if data.type == "music" then
            TriggerServerEvent('gksphone:server:musicListen', data.musicid, volume, "play", data.time)
        elseif data.type == "call" then
            TriggerServerEvent('gksphone:server:musicListen', data.musicid, data.volume, data.type)
        end
    end
    cb('ok')
end)

RegisterNUICallback('gksphone:client:playMusic', function(data, cb)
    debugprint("Playing music", data)
    local check = 'ok'
    if data.action == "volume" then
        volume = data.volume
    end
    if GetResourceState('xsound') == 'started' then
        local id = currentPlayerId
        if data.action == "stopcall" then
            id = "call" .. currentPlayerId
        end
        if musicData[id] then
            if data.action == "stop" then
                local getTime = xSound:getTimeStamp(currentPlayerId)
                check = {time = getTime}
            end
            TriggerServerEvent('gksphone:server:musicListen', data.musicid, data.action == "volume" and data.volume or nil, data.action, data.action == "seek" and data.seekTime or nil)
        end
    end
    cb(check)
end)

RegisterNetEvent('gksphone:client:music', function(action, musicid, mvolume, coords, sid, time)
    debugprint("Music event", action, musicid, mvolume, coords, sid, time)
    if action == "play" or action == "call" then
        if action == "call" then
            sid = "call" .. sid
        end
        if musicData[sid] then
            exports["xsound"]:Destroy(sid)
            musicData[sid] = nil
        end
        if not coords then
            debugprint("No coords")
            return
        end

        xSound:PlayUrlPos(sid, musicid, mvolume, coords, action == "call" and true or false, {
            onPlayStart = function(event)
                    debugprint("Music started", event)
                    musicData[sid] = {id = musicid, volume = mvolume, coords = coords, time = time, sid = sid}
                    
                    xSound:setVolume(sid, mvolume)
                    if musicData[sid]?.time then
                        xSound:setTimeStamp(sid, musicData[sid].time)
                    end
                    if sid == currentPlayerId then
                        SendNUIMessage({
                            action = 'updatePlay',
                            isPlay = true
                        })
                    end
                    if action == "call" then
                        xSound:setSoundLoop(sid, true)
                    end
                    CreateThread(function()
                        local checkPosition = false
                        while true do
                            if not musicData[sid] then
                                if xSound:soundExists(sid) then
                                    xSound:Destroy(sid)
                                    debugprint("Destroying sound", sid)
                                end
                                break
                            end
                            if sid == currentPlayerId and xSound:isPlaying(sid) then
                                local duration = xSound:getMaxDuration(sid)
                                local currentTime = xSound:getTimeStamp(sid)
                                local progress = (currentTime / duration) * 100
                                debugprint("Updating progress", progress, currentTime, duration)
                                SendNUIMessage({
                                    action = 'updateProgress',
                                    progress = progress,
                                    currentTime = currentTime,
                                })
                            end

                            if xSound:isPlaying(sid) then
                                local playerID = action == "call" and sid:gsub("call", "") or sid
                                if type(playerID) == "string" then
                                    playerID = tonumber(playerID)
                                end
                                local player = GetPlayerFromServerId(playerID)
                                if player ~= -1 then
                                    local ped = GetPlayerPed(player)
                                    local pedCoords = GetEntityCoords(ped)

                                    local playerPed = PlayerPedId()
                                    local playerPos = GetEntityCoords(playerPed)

                                    local distance = #(playerPos - pedCoords)

                                    if distance < 200 then
                                        xSound:Position(sid, pedCoords)
                                        if IsPedInAnyVehicle(ped, true) == 1 then
                                            local vehicle = GetVehiclePedIsIn(ped, false)
                                            if GetEntitySpeed(vehicle) * 3.6 > 60.0 then
                                                xSound:Distance(sid, 20)
                                            elseif GetEntitySpeed(vehicle) * 3.6 > 120.0 then
                                                xSound:Distance(sid, 50)
                                            elseif GetEntitySpeed(vehicle) * 3.6 == 0.0 then
                                                xSound:Distance(sid, 8)
                                            end
                                        end

                                        if checkPosition then
                                            xSound:setVolume(sid, musicData[sid].volume)
                                            checkPosition = false
                                        end
                                    else
                                        xSound:setVolume(sid, 0.0)
                                        xSound:Position(sid, pedCoords)
                                        checkPosition = true
                                    end
                                else
                                    xSound:setVolume(sid, 0.0)
                                    checkPosition = true
                                end
                            end

                            Wait(200)
                        end
                    end)
            end,
            onPlayEnd = function(event)
                musicData[sid] = nil
                debugprint("Music ended", event)
                if musicData[sid] and action == "call" then
                    xSound:repeatSound(sid)
                else
                    musicData[sid] = nil
                    debugprint("Music ended", event)
                    if sid == currentPlayerId then
                        SendNUIMessage({
                            action = 'updatePlay',
                            isPlay = false,
                            isEnd = true
                        })
                    end
                end
            end,
            onLoading = function(event)
                debugprint("Loading music...", event)
            end,
            onPlayPause = function(event)
                debugprint("Music paused", event)
                if sid == currentPlayerId then
                    SendNUIMessage({
                        action = 'updatePlay',
                        isPlay = false
                    })
                end
            end,
            onPlayResume = function(event)
                debugprint("Music resumed", event)
                if sid == currentPlayerId then
                    SendNUIMessage({
                        action = 'updatePlay',
                        isPlay = true
                    })
                end
            end
        })
        
    elseif action == "volume" then
        if musicData[sid] then
            xSound:setVolume(sid, mvolume)
            musicData[sid].volume = mvolume
        end
    elseif action == "pause" then
        if musicData[sid] then
            xSound:Pause(sid)
        end
    elseif action == "resume" then
        if musicData[sid] then
            xSound:Resume(sid)
        end
    elseif action == "seek" then
        if musicData[sid] then
            if time then
                xSound:setTimeStamp(sid, time)
            end
        end
    elseif action == "stop" or action == "stopcall" then
        if action == "stopcall" then
            sid = "call" .. sid
        end
        if musicData[sid] and xSound:soundExists(sid) then
            exports["xsound"]:Destroy(sid)
            musicData[sid] = nil
        end
    end
end)

