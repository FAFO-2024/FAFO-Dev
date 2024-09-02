-- EyeTarget | GKSPHONE

if Config.EyeTarget then
    if Config.TargetExport == 'ox_target' then
        exports[Config.TargetExport]:addGlobalPlayer({
            {
                event = "number",
                icon = "fas fa-hands",
                label = _T(lastItemData?.info?.phoneLang, "PHONE.PHONE_SET_EYETARGET"),
                distance = 2.5,
                onSelect = function(entity)-- This is the action it has to perform, this REPLACES the event and this is OPTIONAL
                    if not IsPedAPlayer(entity) then return false end -- This will return false if the entity interacted with is a player and otherwise returns true
                    GiveNumberClosest()
                end,
                
            },
        })
    else
        exports[Config.TargetExport]:AddGlobalPlayer({
            options = {
                {
                    event = "number",
                    icon = "fas fa-hands",
                    label = _T(lastItemData?.info?.phoneLang, "PHONE.PHONE_SET_EYETARGET"),
                    action = function(entity)                             -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL
                        if not IsPedAPlayer(entity) then return false end -- This will return false if the entity interacted with is a player and otherwise returns true
                        GiveNumberClosest()
                    end,
                },
            },
            distance = 2.5,
        })
    end

    if Config.PhoneBox then
        for k, l in pairs(Config.PhoneBoothModel) do
            if Config.TargetExport == 'ox_target' then
                exports[Config.TargetExport]:addModel(k, {
                    {
                        icon = "fa-solid fa-phone",
                        distance = 2.5,
                        label = _T(lastItemData?.info?.phoneLang, "PHONE.PHONE_PHONEBOX"),
                        onSelect = function()
                            Bootphoneopen()
                        end
                    },
                })
            else
                exports[Config.TargetExport]:AddTargetModel(k, {
                    options = {
                        {
                            icon = "fa-solid fa-phone",
                            label = _T(lastItemData?.info?.phoneLang, "PHONE.PHONE_PHONEBOX"),
                            action = function()
                                Bootphoneopen()
                            end
                        },
                    },
                    distance = 2.5,
                })
            end
        end
    end

    if ChargeEyeTarget then
        if Config.TargetExport == 'ox_target' then
            --- Normal Charging
            exports[Config.TargetExport]:addModel(GetHashKey(NormalChargingPropName), {
                    {
                        icon = "fa fa-mobile",
                        distance = 2.5,
                        label = _T(lastItemData?.info?.phoneLang, "Charge.APP_CHARGE_NORMAL_CHARGE"),
                        onSelect = function()
                            NormalChargePhone()
                        end
                    },
                    {
                        icon = "fa fa-bolt",
                        distance = 2.5,
                        label = _T(lastItemData?.info?.phoneLang, "Charge.APP_CHARGE_CANCEL"),
                        onSelect = function()
                            CancelCharge()
                        end
                    },
            })

            --- Fast Charging
            exports[Config.TargetExport]:addModel(GetHashKey(FastChargingPropName), {
                    {
                        icon = "fa fa-mobile",
                        distance = 2.5,
                        label = _T(lastItemData?.info?.phoneLang, "Charge.APP_CHARGE_FAST_CHARGE"),
                        action = function()
                            FastChargePhone()
                        end
                    },
                    {
                        icon = "fa fa-bolt",
                        distance = 2.5,
                        label = _T(lastItemData?.info?.phoneLang, "Charge.APP_CHARGE_CANCEL"),
                        action = function()
                            CancelCharge()
                        end
                    },
            })
        else
            --- Normal Charging
            exports[Config.TargetExport]:AddTargetModel(GetHashKey(NormalChargingPropName), {
                options = {
                    {
                        icon = "fa fa-mobile",
                        label = _T(lastItemData?.info?.phoneLang, "Charge.APP_CHARGE_NORMAL_CHARGE"),
                        action = function()
                            NormalChargePhone()
                        end
                    },
                    {
                        icon = "fa fa-bolt",
                        label = _T(lastItemData?.info?.phoneLang, "Charge.APP_CHARGE_CANCEL"),
                        action = function()
                            CancelCharge()
                        end
                    },
                },
                distance = 2.5,
            })

            --- Fast Charging
            exports[Config.TargetExport]:AddTargetModel(GetHashKey(FastChargingPropName), {
                options = {
                    {
                        icon = "fa fa-mobile",
                        label = _T(lastItemData?.info?.phoneLang, "Charge.APP_CHARGE_FAST_CHARGE"),
                        action = function()
                            FastChargePhone()
                        end
                    },
                    {
                        icon = "fa fa-bolt",
                        label = _T(lastItemData?.info?.phoneLang, "Charge.APP_CHARGE_CANCEL"),
                        action = function()
                            CancelCharge()
                        end
                    },
                },
                distance = 2.5,
            })

        end
    end

    function GiveNumberClosest()
        local closestPlayer, distance = Config.Core.Functions.GetClosestPlayer()
        debugprint('closestPlayer', closestPlayer, myPhoneNumber)
        if myPhoneNumber then
            TriggerServerEvent('gksphone:gks:addContact:eyetarget', myPhoneNumber, GetPlayerServerId(closestPlayer))
        end
    end
end
