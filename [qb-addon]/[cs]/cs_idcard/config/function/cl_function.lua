QBCore = exports['qb-core']:GetCoreObject()

function Notificaton(msg)

    lib.notify({
        title = 'Notification',
        description = msg
    })

    -- Examples --

    -- [CodeStudio Notification] --

    -- exports['cs_notification']:Notify({  -- https://codestudio.tebex.io/package/5680775
    --     type = state,  
    --     title = 'Notification',
    --     description = msg
    -- })

    -- [QBCore Notification] --

    --TriggerEvent('QBCore:Notify', msg, state)
end


function ExecuteAnimation(prop, start)
    if start then
        loadModel(prop)
        loadAnimDict('paper_1_rcm_alt1-8')
        if cardProp then 
			DeleteObject(cardProp)
			DetachEntity(cardProp)
            cardProp = nil
        end
        cardProp = CreateObject(prop, GetEntityCoords(PlayerPedId()), true, true, true)
        AttachEntityToEntity(cardProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.1000, 0.0200, -0.0300, -90.000, 170.000, 78.999, true, true, false, false, 1, true)
        TaskPlayAnim(PlayerPedId(), 'paper_1_rcm_alt1-8', 'player_one_dual-8', 5.0, 5.0, -1, 51, 0, false, false, false)
    else
        if IsEntityPlayingAnim(PlayerPedId(), "paper_1_rcm_alt1-8", "player_one_dual-8", 3) then
            ClearPedTasks(PlayerPedId())
        end
        if cardProp then 
			DeleteObject(cardProp)
			DetachEntity(cardProp)
            cardProp = nil
        end
    end
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict) Wait(5)
    end
end

function loadModel(model) 
    if not HasModelLoaded(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end
    end
end


function canInteractWithJob(job)
    local pData = QBCore.Functions.GetPlayerData().job
    for a, b in pairs(job) do
        if a == pData.name and b <= tonumber(pData.grade.level) then
            return true
        end
    end
end
