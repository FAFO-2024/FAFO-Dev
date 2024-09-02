

if CodeStudio.OpenUI.useCommand then
    RegisterCommand(CodeStudio.OpenUI.Command_Name, function()
        TriggerEvent('cs:drunk:openUI')
    end)
end


----Notifications Customization----

function Notificaton(msg)

    SetNotificationTextEntry('STRING')
    AddTextComponentString(msg)
    DrawNotification(0,1)

    -- Examples --

    -- [CodeStudio Notification] --

    -- exports['cs_notification']:Notify({  -- https://codestudio.tebex.io/package/5680775
    --     type = state,  
    --     title = 'Documents',
    --     description = msg
    -- })

    -- [QBCore Notification] --

    --TriggerEvent('QBCore:Notify', msg, state)

    -- [ESX Notification] --

    --TriggerEvent('esx:showNotification', msg, state)

    -- [OX] --

    -- lib.notify({
    --     title = 'Documents',
    --     description = msg
    -- })
end
