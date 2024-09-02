if CodeStudio.ServerType == "QB" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif CodeStudio.ServerType == "ESX" then
    ESX = exports['es_extended']:getSharedObject()
end


--[SAVE STUDIO IMAGES] If you are using Fivemanage, Fivemerr or Discord then put api key here otherwise put discord webhook  *[PROTECTED]

lib.callback.register('cs:identity:fetchWebhookAPI', function(source)
    local WebhookAPI = 'PUT_YOUR_DISCORD_WEBHOOK_HERE_OR_API'
    return WebhookAPI
end)




function GetPlayer(source)
    if CodeStudio.ServerType == 'QB' then
        local Player = QBCore.Functions.GetPlayer(source)
        return Player
    elseif CodeStudio.ServerType == 'ESX' then
        local Player = ESX.GetPlayerFromId(source)
        return Player
    end
end

function GetIdentifier(source)
    if CodeStudio.ServerType == 'QB' then
        local Player = QBCore.Functions.GetPlayer(source)
        local ident = Player.PlayerData.citizenid
        return ident
    elseif CodeStudio.ServerType == 'ESX' then
        local Player = ESX.GetPlayerFromId(source)
        local ident = Player.identifier
        return ident
    end
end

function GetPlayerName(source)
    if CodeStudio.ServerType == 'QB' then
        local Player = QBCore.Functions.GetPlayer(source)
        local fName = Player.PlayerData.charinfo.firstname
        local lName = Player.PlayerData.charinfo.lastname
        return fName, lName
    elseif CodeStudio.ServerType == 'ESX' then
        local Player = ESX.GetPlayerFromId(source)
        local fName = Player.get('firstName')
        local lName = Player.get('lastName')
        return fName, lName
    end
end

function GetNationality(source)
    if CodeStudio.ServerType == 'QB' then
        local Player = QBCore.Functions.GetPlayer(source)
        local nationality = Player.PlayerData.charinfo.nationality
        return nationality
    elseif CodeStudio.ServerType == 'ESX' then
        local Player = ESX.GetPlayerFromId(source)
        local nationality = 'Roleplay'
        return nationality
    end
end

function GetGender(source)
    if CodeStudio.ServerType == 'QB' then
        local Player = QBCore.Functions.GetPlayer(source)
        local gender = Player.PlayerData.charinfo.gender
        if gender == 0 then
            gender = 'Male'
        else
            gender = 'Female'
        end
        return gender
    elseif CodeStudio.ServerType == 'ESX' then
        local Player = ESX.GetPlayerFromId(source)
        local gender = Player.get('sex')
        if gender == 'm' then
            gender = 'Male'
        else
            gender = 'Female'
        end
        return gender
    end
end

function GetBirthdate(source)
    if CodeStudio.ServerType == 'QB' then
        local Player = QBCore.Functions.GetPlayer(source)
        local birthdate = Player.PlayerData.charinfo.birthdate
        return birthdate
    elseif CodeStudio.ServerType == 'ESX' then
        local Player = ESX.GetPlayerFromId(source)
        local birthdate = Player.get('dateofbirth')
        return birthdate
    end
end

function GetPlayerJob(source)
    if CodeStudio.ServerType == 'QB' then
        local Player = QBCore.Functions.GetPlayer(source)
        local Job = Player.PlayerData.job.name
        local Grade = Player.PlayerData.job.grade.level
        local GradeName = Player.PlayerData.job.grade.name
        return Job, Grade, GradeName
    elseif CodeStudio.ServerType == 'ESX' then
        local Player = ESX.GetPlayerFromId(source)
        local Job = Player.job.name
        local Grade = Player.job.grade
        local GradeName = Player.job.grade_label
        return Job, Grade, GradeName
    end
end

function GetPlayerHeight(source)
    if CodeStudio.ServerType == 'ESX' then
        local Player = ESX.GetPlayerFromId(source)
        local height = Player.get('height')
        return height
    end
end


lib.callback.register('cs:identity:getNearbyPlayer', function(source)
	local PlayerPed = GetPlayerPed(source)
	local players = {}
    
	if CodeStudio.ServerType == 'QB' then
		local pCoords = GetEntityCoords(PlayerPed)
		for _, v in pairs(QBCore.Functions.GetPlayers()) do
			local targetped = GetPlayerPed(v)
			local tCoords = GetEntityCoords(targetped)
			local dist = #(pCoords - tCoords)
			if PlayerPed ~= targetped and dist < 10 then
                local ped = GetPlayer(v)
                players[#players+1] = {
                    id = v,
                    name = ped.PlayerData.charinfo.firstname .. " " .. ped.PlayerData.charinfo.lastname
                }
			end
		end
	elseif CodeStudio.ServerType == 'ESX' then
		local pCoords = GetEntityCoords(PlayerPed)
		for _, v in pairs(ESX.GetPlayers()) do
			local targetped = GetPlayerPed(v)
			local tCoords = GetEntityCoords(targetped)
			local dist = #(pCoords - tCoords)
			if PlayerPed ~= targetped and dist < 10 then
				local ped = GetPlayer(v)
				players[#players+1] = {
					id = v,
					name = ped.getName()
				}
			end
		end
	end
	return players
end)


lib.callback.register('cs:identity:deductMoney', function(source, amount)
    if CodeStudio.ServerType == 'QB' then
        local Player = QBCore.Functions.GetPlayer(source)
        local money = Player.PlayerData.money['cash']
        if money >= amount then
            Player.Functions.RemoveMoney("cash", amount)
            return true
        end
    elseif CodeStudio.ServerType == 'ESX' then
        local Player = ESX.GetPlayerFromId(source)
        local money = Player.getAccount('money').money
        if money >= amount then
            Player.removeAccountMoney('money', amount)
            return true
        end
    end
    return false
end)



function addItem(source, item, metadata)
    if metadata then
        if metadata.firstname or metadata.lastname then
            metadata.description = ('Name: %s'):format(metadata.firstname..' '..metadata.lastname)
        end
    end

    if GetResourceState('ox_inventory') == 'started' then
        exports['ox_inventory']:AddItem(source, item, 1, metadata)
    elseif GetResourceState('qs-inventory') == 'started' then
        exports['qs-inventory']:AddItem(source, item, 1, false, metadata)
    else
        if CodeStudio.ServerType == 'QB' then
            local Player = QBCore.Functions.GetPlayer(source)
            Player.Functions.AddItem(item, 1, nil, metadata)
        elseif CodeStudio.ServerType == 'ESX' then
            local Player = ESX.GetPlayerFromId(source)
            Player.addInventoryItem(item, 1, metadata)
        end
    end
end



function issueLicense(playerSrc, license, issue)  --This Function triggers when license gets issued or revoked
    --Supports qb-core Metadata License update + esx_license support
    if CodeStudio.ServerType == 'QB' then
        local Player = QBCore.Functions.GetPlayer(playerSrc)
        local licenseTable = Player.PlayerData.metadata['licences']
        if issue then
            if licenseTable[license] then
                return
            end
            licenseTable[license] = true
            Player.Functions.SetMetaData('licences', licenseTable)
        else
            if licenseTable[license] then
                licenseTable[license] = false
                Player.Functions.SetMetaData('licences', licenseTable)
            end
        end
    elseif CodeStudio.ServerType == 'ESX' then
        if issue then
            TriggerEvent('esx_license:addLicense', playerSrc, license, function()
                return
            end)
        else  
            local Player = ESX.GetPlayerFromId(playerSrc)
            local identifier = Player.identifier
            MySQL.query.await('DELETE FROM user_licenses WHERE type = ? AND owner = ?', {license, identifier})
        end
    end
end



function createItems()
    -- Register Public Licenses --
    for itemName, v in pairs(allLicense) do
        local function handleCardUse(source, data, itemKey)
            lib.callback('cs:identity:getClosestPlayer', source, function(nearby)
                local itemInfo = {}

                if CodeStudio.IDSettings.useMetaData then
                    itemInfo = (data and data.metadata) or (data and data.info) or {}
                    itemInfo.card = allLicense[itemKey]
                end

                if nearby ~= 0 then
                    if itemInfo.checkCard == 'codestudio' then
                        TriggerClientEvent('cs:identity:useCard', nearby, itemInfo, itemKey, source)
                        TriggerClientEvent('cs:identity:useCard', source, itemInfo, itemKey, source)
                    else
                        useCard(source, nearby, itemKey)
                    end
                else
                    if itemInfo.checkCard == 'codestudio' then
                        TriggerClientEvent('cs:identity:useCard', source, itemInfo, itemKey, source)
                    else
                        useCard(source, source, itemKey)
                    end
                end
            end)
        end

        if CodeStudio.ServerType == "QB" then
            QBCore.Functions.CreateUseableItem(itemName, function(source, item)
                handleCardUse(source, item, itemName)
            end)

            QBCore.Functions.CreateUseableItem('carplay', function(source, item)
                handleCardUse(source, item, 'carplay')
            end)
        elseif CodeStudio.ServerType == "ESX" then
            ESX.RegisterUsableItem(itemName, function(source, item, data)
                if GetResourceState('qs-inventory') == 'started' then
                    handleCardUse(source, item, itemName)
                else
                    handleCardUse(source, data, itemName)
                end
            end)
        end
    end

    -- Register Job Badges Items --
    for job, config in pairs(CodeStudio.Management) do
        if config.JobBadge.Enable and config.JobBadge.ItemName then
            local itemName = config.JobBadge.ItemName

            local function handleBadgeUse(source, data, itemKey)
                lib.callback('cs:identity:getClosestPlayer', source, function(nearby)
                    local itemInfo = {}

                    if CodeStudio.IDSettings.useMetaData then
                        itemInfo = (data and data.metadata) or (data and data.info) or {}
                    end

                    if nearby ~= 0 then
                        if itemInfo.checkCard == 'codestudio' then
                            TriggerClientEvent('cs:identity:useBadge', nearby, itemInfo, itemKey, source)
                            TriggerClientEvent('cs:identity:useBadge', source, itemInfo, itemKey, source)
                        else
                            useBadge(source, nearby, itemKey)
                        end
                    else
                        if itemInfo.checkCard == 'codestudio' then
                            TriggerClientEvent('cs:identity:useBadge', source, itemInfo, itemKey, source)
                        else
                            useBadge(source, source, itemKey)
                        end
                    end
                end)
            end

            if CodeStudio.ServerType == "QB" then
                QBCore.Functions.CreateUseableItem(itemName, function(source, item)
                    handleBadgeUse(source, item, itemName)
                end)
            elseif CodeStudio.ServerType == "ESX" then
                ESX.RegisterUsableItem(itemName, function(source, item, data)
                    if GetResourceState('qs-inventory') == 'started' then
                        handleBadgeUse(source, item, itemName)
                    else
                        handleBadgeUse(source, data, itemName)
                    end
                end)
            end
        end
    end


    for k, config in pairs(CodeStudio.WorkerID) do
        if config.ItemName then
            local itemName = config.ItemName

            local function handleWorkerIDUse(source, data, itemKey)
                if not CodeStudio.IDSettings.useMetaData then return end
                lib.callback('cs:identity:getClosestPlayer', source, function(nearby)
                    local itemInfo = (data and data.metadata) or (data and data.info) or {}
                    if nearby ~= 0 then
                        if itemInfo.checkCard == 'codestudio' then
                            TriggerClientEvent('cs:identity:useWorkerID', nearby, itemInfo, itemKey, source)
                            TriggerClientEvent('cs:identity:useWorkerID', source, itemInfo, itemKey, source)
                        else
                            useWorkerID(source, nearby, itemKey)
                        end
                    else
                        if itemInfo.checkCard == 'codestudio' then
                            TriggerClientEvent('cs:identity:useWorkerID', source, itemInfo, itemKey, source)
                        else
                            useWorkerID(source, source, itemKey)
                        end
                    end
                end)
            end

            if CodeStudio.ServerType == "QB" then
                QBCore.Functions.CreateUseableItem(itemName, function(source, item)
                    handleWorkerIDUse(source, item, itemName)
                end)
            elseif CodeStudio.ServerType == "ESX" then
                ESX.RegisterUsableItem(itemName, function(source, item, data)
                    if GetResourceState('qs-inventory') == 'started' then
                        handleWorkerIDUse(source, item, itemName)
                    else
                        handleWorkerIDUse(source, data, itemName)
                    end
                end)
            end
        end

    end

    
    local function handleForgeIDUse(source, data, itemKey)
        if not CodeStudio.IDSettings.useMetaData then return end
        lib.callback('cs:identity:getClosestPlayer', source, function(nearby)
            local itemInfo = (data and data.metadata) or (data and data.info) or {}
            if nearby ~= 0 then
                if itemInfo.checkCard == 'codestudio' then
                    TriggerClientEvent('cs:identity:useCard', nearby, itemInfo, itemKey, source)
                    TriggerClientEvent('cs:identity:useCard', source, itemInfo, itemKey, source)
                end
            else
                if itemInfo.checkCard == 'codestudio' then
                    TriggerClientEvent('cs:identity:useCard', source, itemInfo, itemKey, source)
                end
            end
        end)
    end

    if CodeStudio.ServerType == "QB" then
        QBCore.Functions.CreateUseableItem(CodeStudio.FakeID.itemName, function(source, item)
            handleForgeIDUse(source, item, CodeStudio.FakeID.itemName)
        end)
    elseif CodeStudio.ServerType == "ESX" then
        ESX.RegisterUsableItem(CodeStudio.FakeID.itemName, function(source, item, data)
            if GetResourceState('qs-inventory') == 'started' then
                handleForgeIDUse(source, item, CodeStudio.FakeID.itemName)
            else
                handleForgeIDUse(source, data, CodeStudio.FakeID.itemName)
            end
        end)
    end

end




lib.addCommand(CodeStudio.LicenseCreator.creatorCommand, {
    help = 'Create Licenses [Restricted]',
}, function(source, args, raw)
    if isPlayerAllowed(source, CodeStudio.LicenseCreator.Restrict) then
        TriggerClientEvent('cs:identity:creatorUI', source)
    end
end)

if CodeStudio.LicenseChecker.Enable then
    lib.addCommand(CodeStudio.LicenseChecker.checkCommand, {
        help = 'Check Licenses [Restricted]',
    }, function(source, args, raw)
        if isPlayerAllowed(source, CodeStudio.LicenseChecker.Restrict) then
            TriggerClientEvent('cs:identity:idCheck', source)
        end
    end)
end


