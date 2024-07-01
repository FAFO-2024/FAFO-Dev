local Locales = {
    ['ele_acr'] = "Access Restricted!",
	['ele_atf'] = "You are already in this floor...",
	['ele_wfe'] = "Waiting for the Elevator...",
	['ele_can'] = "Cancelled",
}



function _U(entry)
	return Locales[entry] 
end

function GetLocales()
	return Locales
end
