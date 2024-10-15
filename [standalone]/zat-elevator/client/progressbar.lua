local ESX = nil
local QBCore = nil
CreateThread(function ()
    if Config.Framework == 'esx' then
        ESX = exports["es_extended"]:getSharedObject()
    elseif Config.Framework == 'qb' then
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)

function changeFloor(data, currentElevator)
    hideUI()
    local ped = PlayerPedId()
    if Config.Framework == "qb" then
        QBCore.Functions.Progressbar("Call_The_Lift", _U('ele_wfe'), Config.Elevators[currentElevator].waittime, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@apt_trans@elevator",
            anim = "elev_1",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(ped, "anim@apt_trans@elevator", "elev_1", 1.0)
            DoScreenFadeOut(500)
            Wait(1000)
            SetEntityCoords(ped, Config.Elevators[currentElevator].floor[data].playercoords.x, Config.Elevators[currentElevator].floor[data].playercoords.y, Config.Elevators[currentElevator].floor[data].playercoords.z, 0, 0, 0, false)
            SetEntityHeading(ped, Config.Elevators[currentElevator].floor[data].playercoords.w)
            Wait(1000)
            DoScreenFadeIn(600)
        end)
    elseif Config.Framework == "esx" then
        ESX.Progressbar(_U('ele_wfe'), Config.Elevators[currentElevator].waittime, {FreezePlayer = false, animation ={
            type = "anim",
            dict = "anim@apt_trans@elevator", 
            lib ="elev_1" 
            }, onFinish = function()
            StopAnimTask(ped, "anim@apt_trans@elevator", "elev_1", 1.0)
            DoScreenFadeOut(500)
            Wait(1000)
            SetEntityCoords(ped, Config.Elevators[currentElevator].floor[data].playercoords.x, Config.Elevators[currentElevator].floor[data].playercoords.y, Config.Elevators[currentElevator].floor[data].playercoords.z, 0, 0, 0, false)
            SetEntityHeading(ped, Config.Elevators[currentElevator].floor[data].playercoords.w)
            Wait(1000)
            DoScreenFadeIn(600)
        end, onCancel = function()
            ESX.ShowNotification(_U('ele_can')
            , "error")
        end})
    end
end