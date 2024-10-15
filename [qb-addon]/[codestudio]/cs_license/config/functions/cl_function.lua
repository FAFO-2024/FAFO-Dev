function Notification(msg)
    lib.notify({
        title = 'Notification',
        description = msg
    })

    -- Examples --

    -- [CodeStudio HUD Notification] --
    -- exports['cs_hud']:Alert('Notification', msg)

    --TriggerEvent('QBCore:Notify', msg)
    --TriggerEvent('esx:showNotification', msg)
end


function ExecuteAnimation(start)
    ClearPedTasks(cache.ped)

    for k, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(cache.ped, v) then
            DeleteObject(v)
            DetachEntity(v, 0, 0)
            SetEntityAsMissionEntity(v, true, true)
            Wait(100)
            DeleteEntity(v)
        end
    end
    
    if start then
        local prop = `prop_franklin_dl`
        loadModel(prop)
        loadAnimDict('paper_1_rcm_alt1-8')
        if cardProp then 
			DeleteObject(cardProp)
			DetachEntity(cardProp)
            cardProp = nil
        end
        cardProp = CreateObject(prop, GetEntityCoords(cache.ped), true, true, true)
        AttachEntityToEntity(cardProp, cache.ped, GetPedBoneIndex(cache.ped, 57005), 0.1000, 0.0200, -0.0300, -90.000, 170.000, 78.999, true, true, false, false, 1, true)
        TaskPlayAnim(cache.ped, 'paper_1_rcm_alt1-8', 'player_one_dual-8', 5.0, 5.0, -1, 51, 0, false, false, false)
    else
        if IsEntityPlayingAnim(cache.ped, "paper_1_rcm_alt1-8", "player_one_dual-8", 3) then
            ClearPedTasks(cache.ped)
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

function onEnterZone()
    lib.showTextUI('[E] Open')
end

function onExitZone()
    lib.hideTextUI()
end



lib.callback.register('cs:identity:getClosestPlayer', function()
    local nearPly = {}
    local nearby = lib.getNearbyPlayers(GetEntityCoords(cache.ped), 2.0, true)
    if #nearby == 0 then return end
    for _, v in pairs(nearby) do
        table.insert(nearPly, GetPlayerServerId(v.id))
    end
    return nearPly
end)



function capturePic(callback)
    local WebhookAPI = lib.callback.await('cs:identity:fetchWebhookAPI', false)
    if CodeStudio.IDPhotoMode.Save_Method == 'discord' then
        exports['screenshot-basic']:requestScreenshotUpload(WebhookAPI, "files[]", function(uploadData)
            local image = json.decode(uploadData)
            callback(json.encode(image.attachments[1].proxy_url))
        end)
    elseif CodeStudio.IDPhotoMode.Save_Method == 'fivemanage' then
        exports['screenshot-basic']:requestScreenshotUpload('https://api.fivemanage.com/api/image', 'image', {
            headers = {
                Authorization = WebhookAPI
            }
        }, function(data)
            local resp = json.decode(data)
            if resp then
                callback(resp.url)
            end
        end)
    elseif CodeStudio.IDPhotoMode.Save_Method == 'fivemerr' then
        exports['screenshot-basic']:requestScreenshotUpload('https://api.fivemerr.com/v1/media/images', 'file', {
            headers = {
                Authorization = WebhookAPI
            },
            encoding = 'png'
        }, function(data)
            local resp = json.decode(data)
            local link = (resp and resp.url) or 'invalid_url'
            callback(link)
        end)
    end
end



CreateThread(function()
    for _, coords in pairs(CodeStudio.FakeID.location) do
        if CodeStudio.LocationSettings.useTextUI.Enable then
            lib.zones.sphere({
                coords = coords,
                radius = 2.5,
                debug = CodeStudio.Debug,
                type = 'fakeID',
                inside = insideZone,
                onEnter = onEnterZone,
                onExit = onExitZone
            })
        end
        if CodeStudio.LocationSettings.useTarget.Enable then
            if CodeStudio.LocationSettings.useTarget.Target == 'ox_target' then
                exports.ox_target:addBoxZone({
                    name = "ultFakeMenu".._,
                    coords = coords,
                    size = vector3(2.0, 2.0, 2.0),
                    rotation = 45.0,
                    debug = CodeStudio.Debug,
                    options = {
                        {
                            onSelect = function()
                                openFakeIDCreator()
                            end,
                            icon = "fas fa-gear",
                            label = CodeStudio.Language.fake_id_menu
                        }
                    }
                })
            else
                exports[CodeStudio.LocationSettings.useTarget.Target]:AddBoxZone("ultFakeMenu".._, coords, 2.0, 2.0, {
                    name = "ultFakeMenu".._,
                    debugPoly = CodeStudio.Debug,
                }, {
                    options = {
                        {
                            action = function()
                                openFakeIDCreator()
                            end,
                            icon = "fas fa-gear",
                            label = CodeStudio.Language.fake_id_menu
                        },
                    },
                    distance = 2.5
                })
            end
        end
    end
end)


function openFakeIDCreator()
    TriggerEvent('cs:identity:fakeCreator')
end


--Used in Green Screen Studio --
function DisableWeatherSync(disable) -- Add your weathersync events here 
    if disable then --Disable
        if GetResourceState('cs_weather') == 'started' then
            TriggerEvent('cs:weather:client:DisableSync')
            return
        end
        TriggerEvent('qb-weathersync:client:DisableSync')
    else --Enable
        if GetResourceState('cs_weather') == 'started' then
            TriggerEvent('cs:weather:client:DisableSync')
            return
        end
        TriggerEvent('qb-weathersync:client:EnableSync')
    end
end