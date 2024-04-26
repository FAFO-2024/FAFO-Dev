-- Before configuring, we recommend reading our documentation found at:
-- htttps://docs.londonstudios.net

main = {
	blipsEnabled = false, -- Only shows blips nearby on minimap
	shortRangeBlips = true,
	disablePublicDefibs = false,
	maximumEMSToStopDefibUse = 1, -- When set to 0, players can always use defib, when set to 1, players can only use defib if there is less than 1 EMS online. Only available for frameworks.
	onDutyCheck = true,-- This is to check if EMS are on duty for the maximumEMSToStopDefibUse function. Please head to the sv_utils.lua and fill in the isPlayerOnDuty function
	defibDensity = 4, -- Increase this number to reduce the amount of defibs around the map. We recommend a number between 3-5
	chanceOfResurrection = 60, -- Out of 100%, this is the chance of a shock being advised and successful, or not advised
	timerToResetDefib = 300, -- Put this in seconds. This resets the no shock advised so that you can use the defib on a player who was no shock advised

	defibVolumeRadius = 30, -- The sound distance
	defibVolume = 1.0, -- The sound volume. Maximum 1.0
	usageDistance = 1.0, -- Distance away from a defib case to open or close it.

	openOrCloseDefibKey = {0, 23}, -- Find this at https://docs.fivem.net/docs/game-references/controls/ (F by default)
	openOrCloseDefibKeyHelp = "INPUT_ENTER", -- For the on screen help message, found at the above documentation next to the control
	putDownOrPickupDefibKey = {0, 58}, -- Find this at https://docs.fivem.net/docs/game-references/controls/ (F by default)
	putDownOrPickupDefibKeyHelp = "INPUT_THROW_GRENADE", -- For the on screen help message, found at the above documentation next to the control
	pushToShockKey = {0, 51}, -- Find this at https://docs.fivem.net/docs/game-references/controls/ (E by default)
	pushToShockHelp = "INPUT_CONTEXT", -- For the on screen help message, found at the above documentation next to the control
	
	defibCommandName = "defib",

	resetDefibEnabled = true,
	resetDefib = 600, -- This number is in seconds.
	okokTextUI = false,
	okokTextUIResourceName = "okokTextUI", -- Doesn't matter if okokTextUI is set to false
	okokTextColor = "darkblue", -- https://docs.okokscripts.io/scripts/okoktextui <-- Find all colors there, using an invalid one will probably break the script.
}

-- In this section you can translate the resource to another language
translations = {
	press = "Press",
	openDefib = "to use this ~b~defibrillator",
	enterThePin = "Enter the pin: (",
	closeBracketPin = ")",
	closeDefib = "to return this ~b~defibrillator",
	putDownDefib = "to put down this ~b~defibrillator",
	incorrectPin = "You entered the pin incorrectly",
	ShockPlayer = "to shock the player",
	ShockReasoning = "You have been ~r~shocked~w~ for being too close",
	noDefibInInv = "You didn't have a defib in your inventory",
	incorrectGroup = "You are not in the correct field of work to use the defib",
	alreadyDefibInHand = "You have a defib in your hand already",
	howToUseDefib = "to use it on a player"
}

commandTranslations = { -- Also used to pickup the defib
	defibDown = "putdefibdown",
	defibDownHelp = "Put the defib on the floor",
	defibDownKey = "G",
	removeFromCase = "retrievedefib",
	removeFromCaseHelp = "Retrieves defib from the case",
	removeFromCaseKey = "F",
	defibShock = "shockplayer",
	defibShockHelp = "Zaps the player",
	defibShockKey = "E"

}

framework = {
	itemEnabled = false, -- If true, item can be set in the framework option to have a defib on the go
	standalone = true, -- Set this to false if using the revival systems below
	oxInventory = false,
	quasarInventory = false, -- Enable QB/ESX below aswell
	coreInventory = true, -- Enable QB/ESX below aswell
	customDeathScript = false, -- If you set this to true, head to cl_utils.lua to fill in the required functions.
	standaloneExtras = { -- This is for people who use revival systems for standalone
		Badssentials = false, -- https://github.com/JaredScar/Badssentials
		deathscript = false, -- https://github.com/ItsAmmarB/DeathScript  -- You will need to add code into the DeathScript resource if you enable this option. See our documentation at https://docs.londonstudios.net for more info
		faxrevive = false, -- https://github.com/FAXES/fax-revive -- You will need to add code into the FAXRevive resource if you enable this option. See our documentation at https://docs.londonstudios.net for more info
		cadOJRPCPR = false,
		otherScript = {
			enabled = false,
			eventToRunWhenDead = "LS:SetPlayerDead", -- Set this to nil if you're not using it.#
			eventToRunToRevive = "LS:RevivePlayer"
		},
		deathscriptv2 =  {
			enabled = false, -- This is the newer version of DeathScript which uses JS instead of Lua
			resourceName = "deathscript" -- Resource name of DeathScript (Needed for exports)
		},
	},
	QBCore = {
		enabled = true,
		itemName = 'defib',
		groupCheck = {
			enabled = true,
			groupsToCheck = {"ambulance", "police", "FireFighter"}
		},
	},
	vRP = {
		enabled = false,
		itemName = "defib",
		groupCheck = {
			enabled = false,
			groupsToCheck = {"EMS", "FireFighter"}
		},
	},
	ESX = { -- This is default ESX.
		enabled = false, -- If ESXv2 is enabled, set this to false
		ESXv2 = false, -- https://github.com/Leon485/esx_ambulancejob <-- Enable this part if you use this script
		itemName = "defib",
		groupCheck = {
			enabled = false,
			groupsToCheck = {"ambulance", "police"}
		},
	},
}

if framework.ESX.enabled or framework.vRP.enabled or framework.QBCore.enabled or framework.ESX.ESXv2 or framework.standaloneExtras.deathscript or framework.standaloneExtras.Badssentials or framework.standaloneExtras.faxrevive then
    framework.standalone = true
end

-- These are the models used by the resource. 
--We do not recommend editing this section.
model = {
    closed = `prop_defib_closed`,
    open = `prop_defib_open`,
    defib = `prop_defib`,
}

-- These are offSets used for different traffic lights in the resource.
-- We do not recommend editing this section.
modelOffSet = {
	["prop_traffic_01d"] = 0.30,
	["prop_traffic_01b"] = 0.30,
	["prop_traffic_01a"] = 0.30,
	["prop_traffic_03a"] = 0.18,
	["prop_traffic_03b"] = 0.18,
}