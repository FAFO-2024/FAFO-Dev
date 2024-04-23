function checkAllPermissions(source, permissionSets)
    local setsAllowed = {}
    if permissionSets == nil then
        permissionSets = {}
    end
    for _, v in ipairs(permissionSets) do
        if userHasPermission(source, v) then
            table.insert(setsAllowed, v)
        end
    end
    return setsAllowed
end

function userHasPermission(source, permissionSetName)

    local permission = false
    local permissionSet = config.permissionSets[permissionSetName]

    if permissionSet.permissions.acePermissions.enabled then
        for _, perm in pairs(permissionSet.permissions.acePermissions.permissions) do
            if IsPlayerAceAllowed(source, perm) then
                return true
            end
        end
    end
    -- ESX Permissions
    if permissionSet.permissions.ESX.enabled then

        if ESX == nil then
            ESX = exports["es_extended"]:getSharedObject()
        end

        local xPlayer = ESX.GetPlayerFromId(source)
        if permissionSet.permissions.ESX.checkJob.enabled then
            for k, v in pairs(permissionSet.permissions.ESX.checkJob.jobs) do
                if xPlayer.job.name == v then
                    return true
                end
            end
        end
    end

    -- vRP Permission
    if permissionSet.permissions.vRP.enabled then
        if vRP == nil then
            Proxy = module("vrp", "lib/Proxy")
            vRP = Proxy.getInterface("vRP")
        end
        if permissionSet.permissions.vRP.checkPermission.enabled then
            for k, v in pairs(permissionSet.permissions.vRP.checkPermission.permissions) do
                if vRP.hasPermission({vRP.getUserId({source}),v}) then
                    return true
                end
            end
        end

        if permissionSet.permissions.vRP.checkGroup.enabled then
            for k, v in pairs(permissionSet.permissions.vRP.checkGroup.groups) do
                if vRP.hasGroup({vRP.getUserId({source}),v}) then
                    return true
                end
            end
        end
    end

    -- QBCore Permission
    if permissionSet.permissions.QBCore.enabled then

        if QBCore == nil then
            QBCore = exports["qb-core"]:GetCoreObject()
        end

        local player = QBCore.Functions.GetPlayer(source)
        if permissionSet.permissions.QBCore.checkJob.enabled then
            for k, v in pairs(permissionSet.permissions.QBCore.checkJob.jobs) do
                if player.PlayerData.job.name == v then
                    return true
                end
            end
        end
        if permissionSet.permissions.QBCore.checkPermission.enabled then
            for k, v in pairs(permissionSet.permissions.QBCore.checkPermission.permissions) do
                if QBCore.Functions.HasPermission(source, v) then
                    return true
                end
            end
        end
    end

    return permission
end