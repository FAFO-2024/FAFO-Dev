-- EyeTarget | GKSPHONE

if Config.EyeTarget then
    exports[Config.TargetExport]:AddGlobalPlayer({
        options = {
            {
                event = "number",
                icon = "fas fa-hands",
                label = _T(lastItemData?.info?.phoneLang, "PHONE.PHONE_SET_EYETARGET"),
                action = function(entity)-- This is the action it has to perform, this REPLACES the event and this is OPTIONAL
                    if not IsPedAPlayer(entity) then return false end -- This will return false if the entity interacted with is a player and otherwise returns true
                    GiveNumberClosest()
                end,
            },
        },
        distance = 2.5,
    })

    if Config.PhoneBox then
        for k, l in pairs(Config.PhoneBoothModel) do
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

    function GiveNumberClosest()
        local closestPlayer, distance = Config.Core.Functions.GetClosestPlayer()
        debugprint('closestPlayer', closestPlayer, myPhoneNumber)
        if myPhoneNumber then
            TriggerServerEvent('gksphone:gks:addContact:eyetarget', myPhoneNumber, GetPlayerServerId(closestPlayer))
        end
    end
end
