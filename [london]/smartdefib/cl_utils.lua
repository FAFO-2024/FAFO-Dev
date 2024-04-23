local shown = false

function displayHelpText(message)
	SetTextComponentFormat('STRING')
	AddTextComponentString(message)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function tableHas(table, key)
    for k, v in pairs(table) do
        if k == key then
            return true
        end
    end
    return false
end

RegisterNetEvent("CustomDeath:RevivePlayer", function() -- Add code here to revive the player.
	if GetEntityHealth(PlayerPedId()) == 0 then
		SetEntityHealth(PlayerPedId(), 200)
	end
end)

function isPlayerAlive() -- This is a required function if framework.customDeathScript is enabled. The code below is just an example. You must return true if they're dead, and false if they're alive.
	if GetEntityHealth(PlayerPedId()) == 0 then
		return true
	else
		return false
	end
end

function loadAnimDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Wait(0)
	end
end

function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do 
        Wait(0) 
    end
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Wait(500)
		blockinput = false
		return result
	else
		Wait(500)
		blockinput = false
		return nil
	end
end