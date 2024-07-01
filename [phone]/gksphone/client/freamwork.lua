-- GKSPHONE | @GKSHOPTeam | discord.gg/XUck63E

PlayerData = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(data)
    debugprint('QBCore:Client:OnPlayerLoaded')
    local PlayerData = Config.Core.Functions.GetPlayerData()
    if PlayerData ~= nil then
        if PlayerData.job ~= nil then
            jobInfo.job = PlayerData.job.name
            jobInfo.job_grade = PlayerData.job.grade.level and PlayerData.job.grade.level or PlayerData.job.grade
            jobInfo.job_label = PlayerData.job.label
            jobInfo.job_grade_label = PlayerData.job.grade.name and PlayerData.job.grade.name or PlayerData.job.grade
            JobUpdate()
        end
    end
    if Config.OxInvetory then
        exports.ox_inventory:displayMetadata({eSIMNumber = 'Phone Number'})
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    if JobInfo ~= nil then
        jobInfo.job = JobInfo.name
        jobInfo.job_grade = PlayerData.job.grade.level and PlayerData.job.grade.level or PlayerData.job.grade
        jobInfo.job_label = PlayerData.job.label
        jobInfo.job_grade_label = PlayerData.job.grade.name and PlayerData.job.grade.name or PlayerData.job.grade
        JobUpdate()
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    debugprint('QBCore:Client:OnPlayerUnload')
    PlayerData = {}
    jobInfo = {
        job = "",
        job_grade = 0,
        job_label = "",
        job_grade_label = ""
    }
    TriggerServerEvent("gksphone:server:playerDropped")
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
    debugprint('QBCore:Player:SetPlayerData', PlayerData)
    if GetResourceState('qb-inventory') == 'started' or Config.CoreInventory or Config.qsInvetory then
        PlayerItemFind()
    end

    if PlayerData.metadata["ishandcuffed"] or PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"] then
        if PhoneOpen == true then
            OpenPhone()
        end
        phoneOpenBlock = true
        phoneBlockReason = "You can't use the phone while dead, handcuffed or in last stand."
    else
        phoneOpenBlock = false
        phoneBlockReason = ""
    end
end)

if Config.OxInvetory then
    AddEventHandler('ox_inventory:itemCount', function(itemName, totalCount)
        debugprint('ox_inventory:itemCount ', itemName, totalCount)
        if Config.ItemName[itemName] then
            PlayerItemFind()
        end
    end)
end

-- This event handler is triggered when a resource starts.
-- It checks if the current resource is the same as the one being started.
-- If it is, it retrieves the player's data and updates the job information on the phone.
-- Finally, it triggers a server event to restart the phone.
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        local PlayerData = Config.Core.Functions.GetPlayerData()
        if PlayerData ~= nil then
            if PlayerData.job ~= nil then
                jobInfo.job = PlayerData.job.name
                jobInfo.job_grade = PlayerData.job.grade.level and PlayerData.job.grade.level or PlayerData.job.grade
                jobInfo.job_label = PlayerData.job.label
                jobInfo.job_grade_label = PlayerData.job.grade.name and PlayerData.job.grade.name or PlayerData.job.grade
                Wait(5000)
                JobUpdate()
            end
        end
        TriggerServerEvent("gksphone:server:restartphone")
    end
end)