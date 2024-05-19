
if Config.Framework ~= "other" then
    
    FrameworkObj = nil
    if Config.Framework == "qb" then
        FrameworkObj = exports["qb-core"]:GetCoreObject()
    elseif Config.Framework == "esx" then
        FrameworkObj = exports["es_extended"]:getSharedObject()
    end

    RegisterNetEvent(Config.FrameworkTriggers[Config.Framework].PlayerLoaded, function()
        PlayerLoaded()
        Wait(5000)
        if not spawnedInsideApartment then
            local isInRoom = lib.callback.await("snipe-apartments:server:checkIsInRoom", false)
            if isInRoom and inApartmentRoom then
                DoScreenFadeIn(500)
                Wait(1000)
                SetEntityCoords(PlayerPedId(), Config.LobbyCoords.x, Config.LobbyCoords.y, Config.LobbyCoords.z)
                SetEntityHeading(PlayerPedId(), Config.LobbyCoords.w)
                DoScreenFadeIn(500)
            end
        end
    end)


    RegisterNetEvent(Config.FrameworkTriggers[Config.Framework].PlayerUnload, function()
        lib.callback.await("snipe-motel:server:playerUnloaded", false)
        CompleteCleanup()

    end)
    if Config.Framework ~= "ox" then
        RegisterNetEvent(Config.FrameworkTriggers[Config.Framework].JobUpdate, function(jobInfo)
            PlayerJob = jobInfo
        end)
    elseif Config.Framework == "ox" then
        RegisterNetEvent(Config.FrameworkTriggers[Config.Framework].JobUpdate, function(name, grade)
            PlayerJob.name  = name
            PlayerJob.grade = grade
        end)
    end
end

if Config.Framework == "other" then
    CreateThread(function()
        while true do
            Wait(0)
            if NetworkIsSessionStarted() then
                PlayerLoaded()

                local isInRoom = lib.callback.await("snipe-apartments:server:checkIsInRoom", false)
                if isInRoom then
                    DoScreenFadeIn(500)
                    Wait(1000)
                    SetEntityCoords(PlayerPedId(), Config.LobbyCoords.x, Config.LobbyCoords.y, Config.LobbyCoords.z)
                    SetEntityHeading(PlayerPedId(), Config.LobbyCoords.w)
                    DoScreenFadeIn(500)
                end
                break
            end
        end
    end)
end

function GetPlayerJob()
    if Config.Framework == "qb" then
        return FrameworkObj.Functions.GetPlayerData().job
    elseif Config.Framework == "esx" then
        return FrameworkObj.GetPlayerData().job
    elseif Config.Framework == "ox" then
        return Ox.GetPlayerData().groups
    end
end
