
function InitNPCInteraction()
    WaitCore()
    if Config.InteractionHandler == 'ox_target'  then
        exports.ox_target:addBoxZone({
            name = 'miner-npc',
            coords = vector3(Config.MinerMenu.coords.x, Config.MinerMenu.coords.y, Config.MinerMenu.coords.z),
            size = vec3(3.6, 3.6, 3.6),
            drawSprite = true,
            options =  {
                {
                    name = 'miner-npc',
                    event = 'codem-minerjob:OpenMinerMenu',
                    icon = 'fas fa-gears',
                    label = "Open Menu",
                }
            }
        })
    end
    if Config.InteractionHandler == 'qb_target'  then
    
        exports['qb-target']:AddBoxZone('miner-npc', vector3(Config.MinerMenu.coords.x, Config.MinerMenu.coords.y, Config.MinerMenu.coords.z), 1.5, 1.6,
            {
                name = 'tailor-npc',
                heading = 12.0,
                debugPoly = false,
                minZ =  Config.MinerMenu.coords.z - 2,
                maxZ =  Config.MinerMenu.coords.z + 2,
            }, 
            {
            options = {
                {
                    num = 1,
                    type = "client",
                    icon = 'fas fa-gears',
                    label = "Open Menu",
                    targeticon = 'fas fa-gears',
                    action = function()
                        TriggerEvent("codem-minerjob:OpenMinerMenu")
                    end
                }
            },
            distance = 3.5,
        })
    end
     if Config.InteractionHandler == 'codem-textui' then
        local isTextUiOpen = false
        CreateThread(function()
            while true do
                local cd = 1500
                local plyCoords = GetEntityCoords(PlayerPedId())
                local vec = vector3(Config.MinerMenu.coords.x, Config.MinerMenu.coords.y, Config.MinerMenu.coords.z+1)
                local dist = #(vec - plyCoords)
                local isInZone = false
                local menuOpen = false
                if not menuOpen then
                    if dist < 2.0  then
                        isInZone = true
                        cd = 0
                        if not isTextUiOpen and not menuOpen then
                                isTextUiOpen = true
                                exports["codem-textui"]:OpenTextUI("OPEN MENU", "E", "thema-6")
                        end
                        if IsControlJustPressed(0, 38) then
                            TriggerEvent("codem-minerjob:OpenMinerMenu")
                            menuOpen = true
                        end
                    end
                end
                if menuOpen then
                    exports["codem-textui"]:CloseTextUI()
                end
            
                if isTextUiOpen and not isInZone then
                    exports["codem-textui"]:CloseTextUI()
                    isTextUiOpen = false
                    menuOpen = false
                end
                Wait(cd)
            end
        end)
    end 
    if Config.InteractionHandler == 'qb_textui' or Config.InteractionHandler == 'esx_textui' or Config.InteractionHandler == 'drawtext' then
        CreateThread(function()
            local show = false
            while true do
                local cd = 1500
                local plyCoords = GetEntityCoords(PlayerPedId())
                local vec = vector3(Config.MinerMenu.coords.x, Config.MinerMenu.coords.y, Config.MinerMenu.coords.z+1)
                local dist = #(vec - plyCoords)
                if dist < 5.0  then
                    cd = 0
                    if not show then
                        if Config.InteractionHandler == 'esx_textui' then
                            Core.TextUI("PRESS E TO OPEN MENU")
                            show = true
                        end
                        if Config.InteractionHandler == 'qb_textui' then
                            TriggerEvent("qb-core:client:DrawText", "PRESS E TO OPEN MENU")
                            show = true
                        end
                    end
                    if Config.InteractionHandler == 'drawtext' then
                        DrawMarker(2, vec, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, false,
                            true, false, false, false)
                        DrawText3D(vec.x, vec.y, vec.z, "PRESS E TO OPEN MENU")
                    end
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent("codem-minerjob:OpenMinerMenu")
                    end
                else
                    if show then
                        show = false
                        if Config.InteractionHandler == 'esx_textui' then
                            Core.HideUI()
                        end
                        if Config.InteractionHandler == 'qb_textui' then
                            TriggerEvent("qb-core:client:HideText")
                        end
                    end
                end
                Wait(cd)
            end
        end)
    end 
end

function CreateBlip()
    local blipConfig = Config.MinerMenu.blip
    if blipConfig.show then
        local blip = AddBlipForCoord(vector3(Config.MinerMenu.coords.x, Config.MinerMenu.coords.y, Config.MinerMenu.coords.z))
        SetBlipSprite(blip, blipConfig.sprite)
        SetBlipColour(blip, blipConfig.color)
        SetBlipScale(blip, blipConfig.scale)
        SetBlipAsShortRange(blip, true)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blipConfig.name)
        EndTextCommandSetBlipName(blip)
    end
end

CreateThread(function()
    InitNPCInteraction()
    CreateBlip()
end)