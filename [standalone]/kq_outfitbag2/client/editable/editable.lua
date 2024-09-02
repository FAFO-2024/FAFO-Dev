-- This function is responsible for creating the text shown on the bottom of the screen
function DrawMissionText(text, time)
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time or 30000, 1)
end

function TextInput(maxLen)
    DisplayOnscreenKeyboard(10, "FMMC_KEY_TIP9N", "", "", "", "", "", maxLen or 16)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(1);
    end
    if (GetOnscreenKeyboardResult()) then
        return GetOnscreenKeyboardResult()
    end
    
    return nil
end

-- This function is responsible for drawing all the 3d texts ('Press [E] to open bag' e.g)
function Draw3DText(x, y, z, textInput, fontId, scaleX, scaleY)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)
    local scale = (1 / dist) * 20
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov
    SetTextScale(scaleX * scale, scaleY * scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

-- Triggered when bag gets opened
function OnBadOpened()

end


-- Triggered when bag gets closed
function OnBagClosed()

end

function OnPlayerApplyOutfit(outfitData, name)
    --
    if Config.clothingSystemSaving and Config.clothingSystemSaving.enabled then
        if Config.clothingSystemSaving.system == 'illenium-appearance' then
            local appearance = exports['illenium-appearance']:getPedAppearance(PlayerPedId())
            
            TriggerServerEvent("illenium-appearance:server:saveAppearance", appearance)
        elseif Config.clothingSystemSaving.system == 'fivem-appearance' then
            local appearance = exports['fivem-appearance']:getPedAppearance(PlayerPedId())
            
            TriggerServerEvent("fivem-appearance:server:saveAppearance", appearance)
        end
    end
end


if Config.debug then
    RegisterCommand('outfit-output', function(source, args)
        TriggerServerEvent('kq_outfitbag2:server:log', GetCurrentOutfitData(), args[1] or GetGameTimer())
    end)
end
