--FiveM's list of Ped Models can be found here: https://docs.fivem.net/docs/game-references/ped-models/
--A list of all the animations can be found here: https://alexguirre.github.io/animations-list/

Config = {}
Config.Invincible = true --Do you want the peds to be invincible?
Config.Frozen = true --Do you want the peds to be unable to move? It's probably a yes, so leave true in there.
Config.Stoic = false --Do you want the peds to react to what is happening in their surroundings?
Config.Fade = true-- Do you want the peds to fade into/out of existence? It looks better than just *POP* its there.
Config.Distance = 15.0 --The distance you want peds to spawn at


--Does the system you use for grabbing coordinates require subracting from the z axis?
--If so, set this to true. You'll have to adjust the coordinates for defaults down - 1 if you set false.
Config.MinusOne = true

Config.PedList = {
	{
		model = "a_m_m_prolhost_01", --The model name. See above for the URL of the list.
		coords = vector3(-33.4,-1104.16,26.42), --PDM
		heading = 65.98, --Must be a float value. This means it needs a decimal and a number after the decimal.
		gender = "male", --Use male or female
		--animDict = "", --The animation dictionary. Optional. Comment out or delete if not using.
		--animName = "", --The animation name. Optional. Comment out or delete if not using.
	    isRendered = false,
        ped = nil,
    },
	{
		model = "s_f_y_scrubs_01", --The model name. See above for the URL of the list.
		coords = vector3(310.53,-585.88,43.27), --Pillbox Karen
		heading = 78.03, --Must be a float value. This means it needs a decimal and a number after the decimal.
		gender = "female", --Use male or female
		--animDict = "", --The animation dictionary. Optional. Comment out or delete if not using.
		--animName = "", --The animation name. Optional. Comment out or delete if not using.
	    isRendered = false,
        ped = nil,
    },
	----------------------------------------
	---         MECHANIC SHOPS           ---
	----------------------------------------
	--[[ {
		model = "s_m_y_xmech_02",
		coords = vector3(106.11213684082,6627.7666015625,31.787231445312), --PALETO BAY MECHANIC
		heading = 20.0, 
		gender = "male", 
		animDict = "missmechanic", 
		animName = "work_base",
	    isRendered = false,
        ped = nil,
    }, ]]
	
}