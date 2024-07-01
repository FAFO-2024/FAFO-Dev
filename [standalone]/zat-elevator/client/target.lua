CreateThread(function()
    for k, v in pairs(Config.Elevators) do
        for i, j in pairs(v.floor) do
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
        end
    end
end)