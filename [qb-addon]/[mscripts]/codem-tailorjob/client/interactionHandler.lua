function InitSewingMachines()
    WaitCore()
    if Config.InteractionHandler == 'ox_target'  then
        for _,v in pairs(Config.SewingMachines) do
            exports.ox_target:addBoxZone({
                name = 'tailor-sewing-machine'.._,
                coords = vector3(v.coords.x, v.coords.y, v.coords.z),
                size = vec3(3.6, 3.6, 3.6),
                drawSprite = true,
                options =  {
                    {
                        name = 'tailor-sewing-machine'.._,
                        onSelect = function()
                            TriggerEvent('codem-tailorjob:OpenSewingMachine', _)
                        end,
                        icon = 'fas fa-gears',
                        label = locales.open_menu,
                    }
                }
            })
        end
    end
    if Config.InteractionHandler == 'qb_target'  then
        for _,v in pairs(Config.SewingMachines) do

            exports['qb-target']:AddBoxZone('tailor-sewing-machine'.._, vector3(v.coords.x, v.coords.y, v.coords.z), 1.5, 1.6,
                {
                    name = 'tailor-sewing-machine'.._,
                    heading = 12.0,
                    debugPoly = false,
                    minZ =  v.coords.z - 1,
                    maxZ =  v.coords.z + 1,
                }, 
                {
                options = {
                    {
                        num = 1,
                        type = "client",
                        icon = 'fas fa-gears',
                        label =  locales.open_menu,
                        targeticon = 'fas fa-gears',
                        action = function()
                            TriggerEvent('codem-tailorjob:OpenSewingMachine', _)
                        end
                    }
                },
                distance = 2.5,
            })
        end
    end
  if Config.InteractionHandler == 'qb_textui' or Config.InteractionHandler == 'esx_textui' or Config.InteractionHandler == 'drawtext' then
        CreateThread(function()
            local show = false
            
            while true do
                local cd = 1500
                local plyCoords = GetEntityCoords(PlayerPedId())
                for _,v in pairs(Config.SewingMachines) do
                    local vec = vector3(v.coords.x, v.coords.y, v.coords.z)
                    local dist = #(vec - plyCoords)
                    if dist < 1.25  then
                        cd = 0
                        if not show then
                            if Config.InteractionHandler == 'esx_textui' then
                                Core.TextUI(locales.press_to_open_menu)
                                show = true
                            end

                            if Config.InteractionHandler == 'qb_textui' then
                                TriggerEvent("qb-core:client:DrawText", locales.press_to_open_menu)
                                show = true
                            end
                        end
                        if Config.InteractionHandler == 'drawtext' then
                            DrawMarker(2, vec, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, false,
                                true, false, false, false)
                            DrawText3D(vec.x, vec.y, vec.z, locales.press_to_open_menu)
                        end
                        if IsControlJustPressed(0, Config.MenuKey) then
                            OpenMenu("job", _)
                        end                       
                    end
                end
                 if show and cd > 0 then
                    show = false
                    if  Config.InteractionHandler == 'esx_textui' then
                        Core.HideUI()
                    end
                    if Config.InteractionHandler == 'qb_textui' then
                        TriggerEvent("qb-core:client:HideText")
                    end
                end
                Wait(cd)
            end
        end)
    end     
end

function InitInventoryInteraction()
WaitCore()
    if Config.InteractionHandler == 'ox_target'  then
        exports.ox_target:addBoxZone({
            name = 'tailor-inventory',
            coords = vector3(Config.Inventory.coords.x, Config.Inventory.coords.y, Config.Inventory.coords.z),
            size = vec3(3.6, 3.6, 3.6),
            drawSprite = true,
            options =  {
                {
                    name = 'tailor-inventory',
                    event = 'codem-tailorjob:OpenInventory',
                    icon = 'fas fa-gears',
                    label = locales.open_menu,
                }
            }
        })
    end
    if Config.InteractionHandler == 'qb_target'  then
    
        exports['qb-target']:AddBoxZone('tailor-inventory', vector3(Config.Inventory.coords.x, Config.Inventory.coords.y, Config.Inventory.coords.z), 1.5, 1.6,
            {
                name = 'tailor-inventory',
                heading = 12.0,
                debugPoly = false,
                minZ =  Config.Inventory.coords.z - 1,
                maxZ =  Config.Inventory.coords.z + 1,
            }, 
            {
            options = {
                {
                    num = 1,
                    type = "client",
                    icon = 'fas fa-gears',
                    label = locales.open_menu,
                    targeticon = 'fas fa-gears',
                    action = function()
                        TriggerEvent("codem-tailorjob:OpenInventory")
                    end
                }
            },
            distance = 4.5,
        })
    end
    if Config.InteractionHandler == 'qb_textui' or Config.InteractionHandler == 'esx_textui' or Config.InteractionHandler == 'drawtext' then
        CreateThread(function()
            local show = false
            while true do
                local cd = 1500
                local plyCoords = GetEntityCoords(PlayerPedId())
                local vec = vector3(Config.Inventory.coords.x, Config.Inventory.coords.y, Config.Inventory.coords.z)
                local dist = #(vec - plyCoords)
                if dist < 2.0  then
                    cd = 0
                    if not show then
                        if Config.InteractionHandler == 'esx_textui' then
                            Core.TextUI(locales.press_to_open_menu)
                            show = true
                        end
                        if Config.InteractionHandler == 'qb_textui' then
                            TriggerEvent("qb-core:client:DrawText", locales.press_to_open_menu)
                            show = true
                        end
                    end
                    if Config.InteractionHandler == 'drawtext' then
                        DrawMarker(2, vec, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, false,
                            true, false, false, false)
                        DrawText3D(vec.x, vec.y, vec.z, locales.press_to_open_menu)
                    end
                    if IsControlJustPressed(0, Config.MenuKey) then
                        OpenMenu("inventory")
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

function InitLaptopInteraction()
    WaitCore()
    if Config.InteractionHandler == 'ox_target'  then
        exports.ox_target:addBoxZone({
            name = 'tailor-laptop',
            coords = vector3(Config.Laptop.coords.x, Config.Laptop.coords.y, Config.Laptop.coords.z),
            size = vec3(3.6, 3.6, 3.6),
            drawSprite = true,
            options =  {
                {
                    name = 'tailor-laptop',
                    event = 'codem-tailorjob:OpenLaptop',
                    icon = 'fas fa-gears',
                    label = locales.open_menu,
                }
            }
        })
    end
    if Config.InteractionHandler == 'qb_target'  then
    
        exports['qb-target']:AddBoxZone('tailor-laptop', vector3(Config.Laptop.coords.x, Config.Laptop.coords.y, Config.Laptop.coords.z), 1.5, 1.6,
            {
                name = 'tailor-laptop',
                heading = 12.0,
                debugPoly = false,
                minZ =  Config.Laptop.coords.z - 2,
                maxZ =  Config.Laptop.coords.z + 2,
            }, 
            {
            options = {
                {
                    num = 1,
                    type = "client",
                    icon = 'fas fa-gears',
                    label = locales.open_menu,
                    targeticon = 'fas fa-gears',
                    action = function()
                        TriggerEvent("codem-tailorjob:OpenLaptop")
                    end
                }
            },
            distance = 4.5,
        })
    end
    if Config.InteractionHandler == 'qb_textui' or Config.InteractionHandler == 'esx_textui' or Config.InteractionHandler == 'drawtext' then
        CreateThread(function()
            local show = false
            while true do
                local cd = 1500
                local plyCoords = GetEntityCoords(PlayerPedId())
                local vec = vector3(Config.Laptop.coords.x, Config.Laptop.coords.y, Config.Laptop.coords.z)
                local dist = #(vec - plyCoords)
                if dist < 2.0  then
                    cd = 0
                    if not show then
                        if Config.InteractionHandler == 'esx_textui' then
                            Core.TextUI(locales.press_to_open_menu)
                            show = true
                        end
                        if Config.InteractionHandler == 'qb_textui' then
                            TriggerEvent("qb-core:client:DrawText", locales.press_to_open_menu)
                            show = true
                        end
                    end
                    if Config.InteractionHandler == 'drawtext' then
                        DrawMarker(2, vec, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, false,
                            true, false, false, false)
                        DrawText3D(vec.x, vec.y, vec.z, locales.press_to_open_menu)
                    end
                    if IsControlJustPressed(0, Config.MenuKey) then
                        OpenMenu("laptop")
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


function InitNPCInteraction()
    WaitCore()
    if Config.InteractionHandler == 'ox_target'  then
        exports.ox_target:addBoxZone({
            name = 'tailor-npc',
            coords = vector3(Config.JobStart.coords.x, Config.JobStart.coords.y, Config.JobStart.coords.z),
            size = vec3(3.6, 3.6, 3.6),
            drawSprite = true,
            options =  {
                {
                    name = 'tailor-npc',
                    event = 'codem-tailorjob:StartJob',
                    icon = 'fas fa-gears',
                    label = locales.open_menu,
                }
            }
        })
    end
    if Config.InteractionHandler == 'qb_target'  then
    
        exports['qb-target']:AddBoxZone('tailor-npc', vector3(Config.JobStart.coords.x, Config.JobStart.coords.y, Config.JobStart.coords.z), 1.5, 1.6,
            {
                name = 'tailor-npc',
                heading = 12.0,
                debugPoly = false,
                minZ =  Config.JobStart.coords.z - 2,
                maxZ =  Config.JobStart.coords.z + 2,
            }, 
            {
            options = {
                {
                    num = 1,
                    type = "client",
                    icon = 'fas fa-gears',
                    label = locales.open_menu,
                    targeticon = 'fas fa-gears',
                    action = function()
                        TriggerEvent("codem-tailorjob:StartJob")
                    end
                }
            },
            distance = 3.5,
        })
    end
    if Config.InteractionHandler == 'qb_textui' or Config.InteractionHandler == 'esx_textui' or Config.InteractionHandler == 'drawtext' then
        CreateThread(function()
            local show = false
            while true do
                local cd = 1500
                local plyCoords = GetEntityCoords(PlayerPedId())
                local vec = vector3(Config.JobStart.coords.x, Config.JobStart.coords.y, Config.JobStart.coords.z+1)
                local dist = #(vec - plyCoords)
                if dist < 5.0  then
                    cd = 0
                    if not show then
                        if Config.InteractionHandler == 'esx_textui' then
                            Core.TextUI(locales.press_to_open_menu)
                            show = true
                        end
                        if Config.InteractionHandler == 'qb_textui' then
                            TriggerEvent("qb-core:client:DrawText", locales.press_to_open_menu)
                            show = true
                        end
                    end
                    if Config.InteractionHandler == 'drawtext' then
                        DrawMarker(2, vec, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, false,
                            true, false, false, false)
                        DrawText3D(vec.x, vec.y, vec.z, locales.press_to_open_menu)
                    end
                    if IsControlJustPressed(0, Config.MenuKey) then
                        OpenMenu("start")
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
    local blipConfig = Config.Blip
    if blipConfig.show then
        local blip = AddBlipForCoord(blipConfig.coords)
    
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
    InitLaptopInteraction()
    InitSewingMachines()
    InitInventoryInteraction()
    CreateBlip()
end)