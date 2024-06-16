-- Variables

local QBCore = exports['qb-core']:GetCoreObject()
local currentZone = nil
local PlayerData = {}

-- Handlers

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then return end
	PlayerData = QBCore.Functions.GetPlayerData()
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

-- Static Header

local musicHeader = {
    {
        header = 'Play some music!',
        params = {
            event = 'qb-djbooth:client:playMusic'
        }
    }
}

-- Main Menu

function createMusicMenu()
    musicMenu = {
        {
            isHeader = true,
            header = '💿 | DJ Booth'
        },
        {
            header = '🎶 | Play a song',
            txt = 'Enter a youtube URL',
            params = {
                event = 'qb-djbooth:client:musicMenu',
                args = {
                    zoneName = currentZone
                }
            }
        },
        {
            header = '⏸️ | Pause Music',
            txt = 'Pause currently playing music',
            params = {
                isServer = true,
                event = 'qb-djbooth:server:pauseMusic',
                args = {
                    zoneName = currentZone
                }
            }
        },
        {
            header = '▶️ | Resume Music',
            txt = 'Resume playing paused music',
            params = {
                isServer = true,
                event = 'qb-djbooth:server:resumeMusic',
                args = {
                    zoneName = currentZone
                }
            }
        },
        {
            header = '🔈 | Change Volume',
            txt = 'Resume playing paused music',
            params = {
                event = 'qb-djbooth:client:changeVolume',
                args = {
                    zoneName = currentZone
                }
            }
        },
        {
            header = '❌ | Turn off music',
            txt = 'Stop the music & choose a new song',
            params = {
                isServer = true,
                event = 'qb-djbooth:server:stopMusic',
                args = {
                    zoneName = currentZone
                }
            }
        }
    }
end

-- DJ Booths

local henhouse = BoxZone:Create(Config.Locations['henhouse'].coords, 1, 1, {
    name="henhouse",
    heading=0
})

henhouse:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['henhouse'].job then
        currentZone = 'henhouse'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local walkercustom = BoxZone:Create(Config.Locations['walkercustom'].coords, 1, 1, {
    name="walkercustom",
    heading=0
})

walkercustom:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['walkercustom'].job then
        currentZone = 'walkercustom'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local emeraldbar = BoxZone:Create(Config.Locations['emeraldbar'].coords, 1, 1, {
    name="emeraldbar",
    heading=0
})

emeraldbar:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['emeraldbar'].job then
        currentZone = 'emeraldbar'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local hogbar = BoxZone:Create(Config.Locations['hogbar'].coords, 1, 1, {
    name="hogbar",
    heading=0
})

hogbar:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['hogbar'].job then
        currentZone = 'hogbar'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local pearls = BoxZone:Create(Config.Locations['pearls'].coords, 1, 1, {
    name="pearls",
    heading=0
})

pearls:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['pearls'].job then
        currentZone = 'pearls'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)




local wedding = BoxZone:Create(Config.Locations['wedding'].coords, 1, 1, {
    name="wedding",
    heading=0
})

wedding:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['wedding'].job then
        currentZone = 'wedding'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local casino = BoxZone:Create(Config.Locations['casino'].coords, 1, 1, {
    name="casino",
    heading=0
})

casino:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['casino'].job then
        currentZone = 'casino'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local frankienewbarrettold = BoxZone:Create(Config.Locations['frankienewbarrettold'].coords, 1, 1, {
    name="frankienewbarrettold",
    heading=0
})

frankienewbarrettold:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['frankienewbarrettold'].job then
        currentZone = 'frankienewbarrettold'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local newlilbeachspot = BoxZone:Create(Config.Locations['newlilbeachspot'].coords, 1, 1, {
    name="newlilbeachspot",
    heading=0
})

newlilbeachspot:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['newlilbeachspot'].job then
        currentZone = 'newlilbeachspot'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local odin = BoxZone:Create(Config.Locations['odin'].coords, 1, 1, {
    name="odin",
    heading=0
})

odin:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['odin'].job then
        currentZone = 'odin'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local thb = BoxZone:Create(Config.Locations['thb'].coords, 1, 1, {
    name="thb",
    heading=0
})

thb:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['thb'].job then
        currentZone = 'thb'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local burgershot = BoxZone:Create(Config.Locations['burgershot'].coords, 1, 1, {
    name="thb",
    heading=0
})

burgershot:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['burgershot'].job then
        currentZone = 'burgershot'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local grove = BoxZone:Create(Config.Locations['grove'].coords, 1, 1, {
    name="grove",
    heading=0
})

grove:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['grove'].job then
        currentZone = 'grove'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local uwu = BoxZone:Create(Config.Locations['uwu'].coords, 1, 1, {
    name="uwu",
    heading=0
})

uwu:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['uwu'].job then
        currentZone = 'uwu'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local wingstop = BoxZone:Create(Config.Locations['wingstop'].coords, 1, 1, {
    name="grove",
    heading=0
})

wingstop:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['wingstop'].job then
        currentZone = 'wingstop'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local jaks = BoxZone:Create(Config.Locations['jaks'].coords, 1, 1, {
    name="jaks",
    heading=0
})

jaks:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['jaks'].job then
        currentZone = 'jaks'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local jaks2 = BoxZone:Create(Config.Locations['jaks2'].coords, 1, 1, {
    name="jaks2",
    heading=0
})

jaks2:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['jaks2'].job then
        currentZone = 'jaks2'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local jaks3 = BoxZone:Create(Config.Locations['jaks3'].coords, 1, 1, {
    name="jaks3",
    heading=0
})

jaks3:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['jaks3'].job then
        currentZone = 'jaks3'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local whitewidow = BoxZone:Create(Config.Locations['whitewidow'].coords, 1, 1, {
    name="whitewidow",
    heading=0
})

whitewidow:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['whitewidow'].job then
        currentZone = 'whitewidow'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local motorworks = BoxZone:Create(Config.Locations['motorworks'].coords, 1, 1, {
    name="motorworks",
    heading=0
})

motorworks:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['motorworks'].job then
        currentZone = 'motorworks'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local motorworks = BoxZone:Create(Config.Locations['motorworks2'].coords, 1, 1, {
    name="motorworks2",
    heading=0
})

motorworks:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['motorworks2'].job then
        currentZone = 'motorworks2'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local henhouse2 = BoxZone:Create(Config.Locations['henhouse2'].coords, 1, 1, {
    name="henhouse2",
    heading=0
})

henhouse2:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['henhouse2'].job then
        currentZone = 'henhouse2'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local cayoparty = BoxZone:Create(Config.Locations['cayoparty'].coords, 1, 1, {
    name="cayoparty",
    heading=0
})

cayoparty:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['cayoparty'].job then
        currentZone = 'cayoparty'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local cigar = BoxZone:Create(Config.Locations['cigar'].coords, 1, 1, {
    name="cigar",
    heading=0
})

cigar:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['cigar'].job then
        currentZone = 'cigar'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local italian = BoxZone:Create(Config.Locations['italian'].coords, 1, 1, {
    name="italian",
    heading=0
})

italian:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['italian'].job then
        currentZone = 'italian'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local raceway = BoxZone:Create(Config.Locations['raceway'].coords, 1, 1, {
    name="raceway",
    heading=0
})

raceway:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['raceway'].job then
        currentZone = 'raceway'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local tylerhouse = BoxZone:Create(Config.Locations['tylerhouse'].coords, 1, 1, {
    name="tylerhouse",
    heading=0
})

tylerhouse:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['tylerhouse'].job then
        currentZone = 'tylerhouse'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local beanmachine = BoxZone:Create(Config.Locations['beanmachine'].coords, 1, 1, {
    name="beanmachine",
    heading=0
})

beanmachine:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['beanmachine'].job then
        currentZone = 'beanmachine'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local smoke = BoxZone:Create(Config.Locations['smoke'].coords, 1, 1, {
    name="smoke",
    heading=0
})

smoke:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['smoke'].job then
        currentZone = 'smoke'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local calihouse = BoxZone:Create(Config.Locations['calihouse'].coords, 1, 1, {
    name="calihouse",
    heading=0
})

calihouse:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['calihouse'].job then
        currentZone = 'calihouse'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local vanilla = BoxZone:Create(Config.Locations['vanilla'].coords, 1, 1, {
    name="vanilla",
    heading=0
})

vanilla:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['vanilla'].job then
        currentZone = 'vanilla'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local bowl = BoxZone:Create(Config.Locations['bowl'].coords, 1, 1, {
    name="bowl",
    heading=0
})

bowl:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['bowl'].job then
        currentZone = 'bowl'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local paradiseclub = BoxZone:Create(Config.Locations['paradiseclub'].coords, 1, 1, {
    name="paradiseclub",
    heading=0
})

paradiseclub:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['paradiseclub'].job then
        currentZone = 'paradiseclub'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local studio1 = BoxZone:Create(Config.Locations['studio1'].coords, 1, 1, {
    name="studio1",
    heading=0
})

studio1:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['studio1'].job then
        currentZone = 'studio1'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local studio2 = BoxZone:Create(Config.Locations['studio2'].coords, 1, 1, {
    name="studio2",
    heading=0
})

studio2:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['studio2'].job then
        currentZone = 'studio2'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

local studio3 = BoxZone:Create(Config.Locations['studio3'].coords, 1, 1, {
    name="studio3",
    heading=0
})

studio3:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['studio3'].job then
        currentZone = 'studio3'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)

-- Events

RegisterNetEvent('qb-djbooth:client:playMusic', function()
    createMusicMenu()
    exports['qb-menu']:openMenu(musicMenu)
end)

RegisterNetEvent('qb-djbooth:client:musicMenu', function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Song Selection',
        submitText = "Submit",
        inputs = {
            {
                type = 'text',
                isRequired = true,
                name = 'song',
                text = 'YouTube URL'
            }
        }
    })
    if dialog then
        if not dialog.song then return end
        TriggerServerEvent('qb-djbooth:server:playMusic', dialog.song, currentZone)
    end
end)

RegisterNetEvent('qb-djbooth:client:changeVolume', function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Music Volume',
        submitText = "Submit",
        inputs = {
            {
                type = 'text', -- number doesn't accept decimals??
                isRequired = true,
                name = 'volume',
                text = 'Min: 0.01 - Max: 1'
            }
        }
    })
    if dialog then
        if not dialog.volume then return end
        TriggerServerEvent('qb-djbooth:server:changeVolume', dialog.volume, currentZone)
    end
end)
local bahama = BoxZone:Create(Config.Locations['bahama'].coords, 1, 1, {
    name="bahama",
    heading=0
})

bahama:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['bahama'].job then
        currentZone = 'bahama'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)
RegisterNetEvent('qb-djbooth:client:changeVolume', function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Music Volume',
        submitText = "Submit",
        inputs = {
            {
                type = 'text', -- number doesn't accept decimals??
                isRequired = true,
                name = 'volume',
                text = 'Min: 0.01 - Max: 1'
            }
        }
    })
    if dialog then
        if not dialog.volume then return end
        TriggerServerEvent('qb-djbooth:server:changeVolume', dialog.volume, currentZone)
    end
end)
local lolabeachhousebalcony = BoxZone:Create(Config.Locations['lolabeachhousebalcony'].coords, 1, 1, {
    name="lola beach house balcony",
    heading=0
})

lolabeachhousebalcony:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['lolabeachhousebalcony'].job then
        currentZone = 'lolabeachhousebalcony'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)
RegisterNetEvent('qb-djbooth:client:changeVolume', function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Music Volume',
        submitText = "Submit",
        inputs = {
            {
                type = 'text', -- number doesn't accept decimals??
                isRequired = true,
                name = 'volume',
                text = 'Min: 0.01 - Max: 1'
            }
        }
    })
    if dialog then
        if not dialog.volume then return end
        TriggerServerEvent('qb-djbooth:server:changeVolume', dialog.volume, currentZone)
    end
end)
local lolabeachhousebeach = BoxZone:Create(Config.Locations['lolabeachhousebeach'].coords, 1, 1, {
    name="lola beach house beach",
    heading=0
})

lolabeachhousebeach:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['lolabeachhousebeach'].job then
        currentZone = 'lolabeachhousebeach'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)
RegisterNetEvent('qb-djbooth:client:changeVolume', function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Music Volume',
        submitText = "Submit",
        inputs = {
            {
                type = 'text', -- number doesn't accept decimals??
                isRequired = true,
                name = 'volume',
                text = 'Min: 0.01 - Max: 1'
            }
        }
    })
    if dialog then
        if not dialog.volume then return end
        TriggerServerEvent('qb-djbooth:server:changeVolume', dialog.volume, currentZone)
    end
end)
local bowling = BoxZone:Create(Config.Locations['bowling'].coords, 1, 1, {
    name="Bowling Alley",
    heading=0
})

bowling:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['bowling'].job then
        currentZone = 'bowling'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)
RegisterNetEvent('qb-djbooth:client:changeVolume', function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Music Volume',
        submitText = "Submit",
        inputs = {
            {
                type = 'text', -- number doesn't accept decimals??
                isRequired = true,
                name = 'volume',
                text = 'Min: 0.01 - Max: 1'
            }
        }
    })
    if dialog then
        if not dialog.volume then return end
        TriggerServerEvent('qb-djbooth:server:changeVolume', dialog.volume, currentZone)
    end
end)
local reeftavernocean = BoxZone:Create(Config.Locations['reeftavernocean'].coords, 1, 1, {
    name="Reef Tavern Ocean",
    heading=0
})

reeftavernocean:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['reeftavernocean'].job then
        currentZone = 'reeftavernocean'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)
RegisterNetEvent('qb-djbooth:client:changeVolume', function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Music Volume',
        submitText = "Submit",
        inputs = {
            {
                type = 'text', -- number doesn't accept decimals??
                isRequired = true,
                name = 'volume',
                text = 'Min: 0.01 - Max: 1'
            }
        }
    })
    if dialog then
        if not dialog.volume then return end
        TriggerServerEvent('qb-djbooth:server:changeVolume', dialog.volume, currentZone)
    end
end)
local reeftavernbeach = BoxZone:Create(Config.Locations['reeftavernbeach'].coords, 1, 1, {
    name="Reef Tavern Beach",
    heading=0
})

reeftavernbeach:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['reeftavernbeach'].job then
        currentZone = 'reeftavernbeach'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)
RegisterNetEvent('qb-djbooth:client:changeVolume', function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Music Volume',
        submitText = "Submit",
        inputs = {
            {
                type = 'text', -- number doesn't accept decimals??
                isRequired = true,
                name = 'volume',
                text = 'Min: 0.01 - Max: 1'
            }
        }
    })
    if dialog then
        if not dialog.volume then return end
        TriggerServerEvent('qb-djbooth:server:changeVolume', dialog.volume, currentZone)
    end
end)
local ronnie = BoxZone:Create(Config.Locations['ronnie'].coords, 1, 1, {
    name="Ronnie",
    heading=0
})

ronnie:onPlayerInOut(function(isPointInside)
    if isPointInside and PlayerData.job.name == Config.Locations['ronnie'].job then
        currentZone = 'ronnie'
        exports['qb-menu']:showHeader(musicHeader)
    else
        currentZone = nil
        exports['qb-menu']:closeMenu()
    end
end)