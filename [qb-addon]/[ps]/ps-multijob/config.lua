Config = Config or {}

-- Side of the screen where you want the ui to be on. Can either be "left" or "right"
Config.Side = "right"

Config.MaxJobs = 3
Config.IgnoredJobs = {
	["unemployed"] = true,
}

Config.DenyDuty = {
	["ambulance"] = true,
	["police"] = true,
	["sasp"] = true,
	["sheriff"] = true,
	["firefighter"] = true,
}

Config.WhitelistJobs = {
	["police"] = true,
	["sasp"] = true,
	["sheriff"] = true,
	["firefighter"] = true,
	["ambulance"] = true,
	["mechanic"] = true,
	["judge"] = true,
	["lawyer"] = true,
}

Config.Descriptions = {
	["police"] = "Shoot some criminals or maybe be a good cop and arrest them",
	["sasp"] = "Shoot some criminals or maybe be a good cop and arrest them",
	["sheriff"] = "Shoot some criminals or maybe be a good cop and arrest them",
	["firefighter"] = "Put out the fires",
	["ambulance"] = "Fix the bullet holes",
	["mechanic"] = "Fix the bullet holes",
	["tow"] = "Pickup the tow truck and steal some vehicles",
}

-- Change the icons to any free font awesome icon, also add other jobs your server might have to the list
-- List: https://fontawesome.com/search?o=r&s=solid
Config.FontAwesomeIcons = {
	["police"] = "fa-solid fa-handcuffs",
	["sasp"] = "fa-solid fa-handcuffs",
	["sheriff"] = "fa-solid fa-handcuffs",
	["firefighter"] = "fa-solid fa-fire-extinguisher",
	["ambulance"] = "fa-solid fa-user-doctor",
	["mechanic"] = "fa-solid fa-wrench",
	["tow"] = "fa-solid fa-truck-tow",
}
