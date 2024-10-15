CreateThread(function()
    for k, v in pairs(Config.Elevators) do
        for i, j in pairs(v.floor) do
            if Config.Target == 'qb' then
                exports['qb-target']:AddBoxZone(v.name..i, vector3(j.targetcoords.x, j.targetcoords.y, j.targetcoords.z) , j.width, j.length, {
                    name = v.name..i,
                    heading = j.targetcoords.w,
                    debugPoly = Config.Debug,
                    minZ = j.targetcoords.z - 1.0,
                    maxZ = j.targetcoords.z + 1.0,
                }, {
                    options = {
                        {
                        type = "client",
                        action = function(entity) 
                            TriggerEvent('zat-elevator:client:OpenUi', k)
                        end,
                        icon = "fas fa-chevron-circle-up",
                        label = "Elevator",
                        },
                    },
                    distance = 5.0
                })
            elseif Config.Target == 'ox' then
                exports.ox_target:addBoxZone(
                {
                    coords      = vector3(j.targetcoords.x, j.targetcoords.y, j.targetcoords.z), 
                    size        = vector3(2.0, 2.0, 2.0),
                    rotation    = j.targetcoords.w,
                    debug       = Config.Debug,
                    drawSprite  = false,
                    options     = {
                        {
                            type = "client",
                            onSelect = function(entity) 
                                TriggerEvent('zat-elevator:client:OpenUi', k)
                            end,
                            icon = "fas fa-chevron-circle-up",
                            label = "Elevator",
                        },
                    },
                    distance = 5.0
                })
            end
        end
    end
end)