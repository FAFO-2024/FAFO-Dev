--- GKSPHONE MUSIC APP ---
-- Made by GKSHOP  | https://discord.gg/XUck63E
-- Version: 2.0.0
xSound = exports.xsound
musicData = {}
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
        elseif not musicData[id] and data.action == "musicNext" then
            TriggerServerEvent('gksphone:server:musicListen', data.musicid, volume, "play", 0)
        end
    end
    cb(check)
end)

RegisterNetEvent('gksphone:client:music', function(action, musicid, mvolume, coords, sid, time)
    debugprint("Music event", {action, musicid, mvolume, coords, sid, time})
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
        local playerID = action == "call" and sid:gsub("call", "") or sid
        if type(playerID) == "string" then
            playerID = tonumber(playerID)
            local playerCheck = GetPlayerFromServerId(playerID)
            if playerCheck == -1 then
                debugprint("Player Not Found")
                return
            end
        else
            local playerCheck = GetPlayerFromServerId(playerID)
            if playerCheck == -1 then
                debugprint("Player Not Found")
                return
            end
        end

        xSound:PlayUrlPos(sid, musicid, mvolume, coords, false, {
            onPlayStart = function(event)
                    debugprint("Music started", event)
                    musicData[sid] = {id = musicid, volume = mvolume, coords = coords, time = time, sid = sid}
                    if xSound:soundExists(sid) then
                        xSound:setVolumeMax(sid, mvolume)
                    end
                    if musicData[sid]?.time and xSound:soundExists(sid) then
                        xSound:setTimeStamp(sid, musicData[sid].time)
                    end
                    if sid == currentPlayerId then
                        SendNUIMessage({
                            action = 'updatePlay',
                            isPlay = true
                        })
                    end
                    if action == "call" and xSound:soundExists(sid) then
                        xSound:setSoundLoop(sid, true)
                    end
                    CreateThread(function()
                        local checkPosition = false
                        local WaitTime = 200
                        while true do
                            if not musicData[sid] then
                                if xSound:soundExists(sid) then
                                    xSound:Destroy(sid)
                                    debugprint("Destroying sound", sid)
                                end
                                break
                            end

                            if sid == currentPlayerId and xSound:soundExists(sid) then
                                local duration = xSound:getMaxDuration(sid)
                                local currentTime = xSound:getTimeStamp(sid)
                                local progress = (currentTime / duration) * 100
                                --debugprint("Updating progress", progress, currentTime, duration)
                                SendNUIMessage({
                                    action = 'updateProgress',
                                    progress = progress,
                                    currentTime = currentTime,
                                })
                            end

                            if xSound:soundExists(sid) then
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
                                            xSound:setVolumeMax(sid, musicData[sid].volume)
                                            checkPosition = false
                                            WaitTime = 200
                                        end
                                    else
                                        xSound:setVolumeMax(sid, 0.0)
                                        xSound:Position(sid, pedCoords)
                                        checkPosition = true
                                        WaitTime = 1000
                                    end
                                else
                                    xSound:setVolumeMax(sid, 0.0)
                                    checkPosition = true
                                    WaitTime = 1000
                                end
                            end

                            Wait(WaitTime)
                        end
                    end)
            end,
            onPlayEnd = function(event)
                debugprint("Music ended", event)
                if action ~= "call" and event and not event.paused then
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
            xSound:setVolumeMax(sid, mvolume)
            musicData[sid].volume = mvolume
        end
    elseif action == "pause" then
        if musicData[sid] then
            xSound:Pause(sid)
        end
    elseif action == "resume" then
        if musicData[sid] and xSound:soundExists(sid) then
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
    elseif action == "musicNext" then
        if musicData[sid] and xSound:soundExists(sid) then
            xSound:setSoundURL(sid, musicid)
            xSound:setTimeStamp(sid, 0)
        end
    end
end)

