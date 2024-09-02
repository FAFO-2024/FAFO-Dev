CodeStudio = {}

CodeStudio.AutoSQL = true
CodeStudio.Debug = false

-- 'QB' = For QBCore Framework
-- 'ESX' = For ESX Framework
-- false = For Standalone

CodeStudio.ServerType = 'QB'    --['QB'|'ESX'|false]


-- DASHBOARD PANNEL AND GROUPS --

CodeStudio.Dashboard = {
    ['police'] = {              -- These Job can use bodycame and dashcam
        DashBoard_Access = 4,    -- Minimum rank required to view dashboard pannel
        Title = 'Los Santos Police Department',  -- Department Title
        Logo = 'police.png',        --Logo from: cs_bodycam\ui\image  (*Optional)
        Location = {            -- Add Physical Location to access dashboard (*Optional Put false)
            vector4(459.74, -989.2, 24.91, 279.71)--CHANGE ME
        }
    },
    ['sasp'] = {              -- These Job can use bodycame and dashcam
        DashBoard_Access = 4,    -- Minimum rank required to view dashboard pannel
        Title = 'San Andreas State Patrol',  -- Department Title
        Logo = 'sasp.png',        --Logo from: cs_bodycam\ui\image  (*Optional)
        Location = {            -- Add Physical Location to access dashboard (*Optional Put false)
            vector4(459.74, -989.2, 24.91, 279.71)--CHANGE ME
        }
    },
    ['sheriff'] = {              -- These Job can use bodycame and dashcam
        DashBoard_Access = 4,    -- Minimum rank required to view dashboard pannel
        Title = 'Los Santos Sheriff Department',  -- Department Title
        Logo = 'sheriff.png',        --Logo from: cs_bodycam\ui\image  (*Optional)
        Location = {            -- Add Physical Location to access dashboard (*Optional Put false)
            vector4(459.74, -989.2, 24.91, 279.71)--CHANGE ME
        }
    },
    ['ambulance'] = {             -- These Job can use bodycame and dashcam
        DashBoard_Access = 4,     -- Minimum rank required to view dashboard pannel
        Title = 'Pillbox Hospital Department',    -- Department Title
        Logo = 'ambulance.png',      --Logo from: cs_bodycam\ui\image  (*Optional)
        Location = {            -- Add Physical Location to access dashboard (*Optional Put false)
            vector4(459.74, -989.2, 24.91, 279.71)--CHANGE ME
        }
    },
    ['firefighter'] = {           -- These Job can use bodycame and dashcam
        DashBoard_Access = 4,     -- Minimum rank required to view dashboard pannel
        Title = 'Los Santos Fire Department',  -- Department Title
        Logo = 'firefighter.png',        --Logo from: cs_bodycam\ui\image  (*Optional)
        Location = {            -- Add Physical Location to access dashboard (*Optional Put false)
            vector4(459.74, -989.2, 24.91, 279.71)--CHANGE ME
        }
    },



    -- EXAMPLE ON HOW TO USE WITH STANDALONE ---

    ['put_perms_here'] = {           -- Enter Ace Group/Discord/Steam to which you want to be a part of this dashboard group
        DashBoard_Access = 'put_perms_here',    -- Enter Ace Group/Discord/Steam to which you want to allow view dashboard access
        Title = 'YOUR Department',   -- Department Title
        Logo = 'police.png'
    },
}

CodeStudio.DashBoard_InsideVehicle = {  --Allow Certain Vehicles to Access Dashboard Panel and if you want to allow on all vehicles simply put false
-- CodeStudio.DashBoard_InsideVehicle = false  if you to allow dashboard use in every vehicle
    [`nm_redeye`] = true,
    [`nm_raptor`] = true,
    [`nm_bolide`] = true,
    [`nm_cam69`] = true,
    [`durangopru`] = true,
    [`fdsilverado`] = true,
}

--- Required For Dashboard Locations Interaction ---
CodeStudio.UseTarget = 'qb-target'   --qb-target/ox_target | Put false if you dont want to use target
CodeStudio.UseTextUI = false         --Enable/Disable TextUI To access dashboard locations



-- BODY CAM + RECORDING SETTINGS --

CodeStudio.Default_BodyCam = {    -- This is Deault Format of Bodycam, If allowed it fetches different format's from CodeStudio.Dashboard
    Title = "Los Santos First Responders",
    SubHeading = 'FR',
    Logo = 'default.png'
}

CodeStudio.BodyCam = {
    Enable = true,
    AllowCivilians = false,  --Enable/Disable USe of Body cam recordings grant to civilians if false it will restrict it to CodeStudio.Dashboard
    ShowProfilePic = true,
    Use = {
        WithItem = false,
        ItemName = 'bodycam',
        DisconnectOnNo_BodyCam = false,  --*Requires WithItem
        
        WithCommand = true,
        CommandName = 'bodycam'
    },
}

CodeStudio.Recording = {
    Enable = true,
    Fivemanage = false, --If you are using Fivemanage API
    Fivemerr = false,   --If you are using Fivemerr API
    RecordFPS = 60, -- At What FPS do you want recordings
    RecordMic = true,  --Microphone capture with video recordings
    Max_Recording_Time = 1    ---Max time ALlowed to Record a single clip (In Minutes)

    -- RECORDING WEBHOOK OR API IS IN SV_FUNCTION.LUA --
}



-- DASH CAM SETTINGS --

CodeStudio.DashCam = {
    Enable = true,
    Use = {
        WithItem = false,
        ItemName = 'dashcam',
        RemoveItemOnUse = false, --*Requires WithItem

        WithCommand = true,
        CommandName = 'dashcam'
    },
    Restrict_Vehicle = {  
        -- Restrict_Vehicle = false  if you to allow dashcam to be used in every vehicle
        -- You can restrict usage of dashcam to these vehicles --
        [`police`] = true,
        [`polgauntlet`] = true,
        [`ambulance`] = true,
    }
}

CodeStudio.DebugCamera = false -- Make it true if you want to get new camera offset for some vehicle
CodeStudio.VehCamOffset = {
    -- The script comes with its own offset finder just set DebugCamera to true and get the camera offset.
    [`police2`] = {-3.000000, -3.330000, -3.530000},  -- Example vehicle. 
    -- [`vehiclespawncode`] = {0.000000, 0.510000, 0.630000},
}




