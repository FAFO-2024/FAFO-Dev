
--[[
    label = is the name of the sound (this will be shown on the UI)
    soundName = is the name of the sound file. (the sound file should be in the interact-sound/client/html/sounds folder without the .ogg)
]]--
Config.Sounds = {
    [1] = {label = "Air Wrench", soundName = "airwrench" },
    [2] = {label = "Door bell", soundName = "doorbell"},
    [3] = {label = "Purge", soundName = "purge"},
    [4] = {label = "Cat Fight", soundName = "CAT_FIGHT"},
    [5] = {label = "Scary", soundName = "SCARY_AMBIENCE"},
    [6] = {label = "Zombie", soundName = "ZOMBIE_GROW"},
    [7] = {label = "Ghost", soundName = "GHOSTY_WHISPERS"},
    [8] = {label = "Scream", soundName = "GIRL_SCREAM"},
    [9] = {label = "LetsDoThis", soundName = "letsdothis"},
    [10] = {label = "Nuke", soundName = "nukeincome"},
}

--[[
    -- if true, you can move while in the menu after you press alt key. if false, you can't move while in the menu.
    -- admin menu can only be closed if you are focussed. 
    -- Most servers have target system attached to alt key so should not be a big issue. 
    -- if you feel like something's off, change this to false and open a ticket and we can fix it.
]]--
Config.AllowMovementWhileInMenu = true 

Config.NewNamesLogic = true -- if true, it will use the new names logic. if false, it will use the old names logic.
Config.LineColor = {["r"] = 255, ["g"] = 0, ["b"] =0} -- color of the line between you and the player. (r, g, b)

Config.ShowInGameNamesForNamesAndBlips = true -- if true, it will show in game names for names and blips. if false, it will show their steam/fivem name