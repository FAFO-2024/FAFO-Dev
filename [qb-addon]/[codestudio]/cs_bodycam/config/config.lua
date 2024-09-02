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
            vector4(604.73, -8.17, 87.99, 63.51)
        }
    },
    ['sasp'] = {              -- These Job can use bodycame and dashcam
        DashBoard_Access = 4,    -- Minimum rank required to view dashboard pannel
        Title = 'San Andreas State Patrol',  -- Department Title
        Logo = 'sasp.png',        --Logo from: cs_bodycam\ui\image  (*Optional)
        Location = {            -- Add Physical Location to access dashboard (*Optional Put false)
            vector4(601.68, -16.18, 87.99, 100.87)
        }
    },
    ['sheriff'] = {              -- These Job can use bodycame and dashcam
        DashBoard_Access = 4,    -- Minimum rank required to view dashboard pannel
        Title = 'Los Santos Sheriff Department',  -- Department Title
        Logo = 'sheriff.png',        --Logo from: cs_bodycam\ui\image  (*Optional)
        Location = {            -- Add Physical Location to access dashboard (*Optional Put false)
            vector4(600.37, -19.93, 87.99, 65.95)
        }
    },
    ['ambulance'] = {              -- These Job can use bodycame and dashcam
        DashBoard_Access = 5,    -- Minimum rank required to view dashboard pannel
        Title = 'Emergency Medical Services',  -- Department Title
        Logo = 'ambulance.png',        --Logo from: cs_bodycam\ui\image  (*Optional)
        Location = {            -- Add Physical Location to access dashboard (*Optional Put false)
            vector4(-1030.61, -1413.59, 5.05, 78.62)
        }
    },



    -- EXAMPLE ON HOW TO USE WITH STANDALONE ---
    ['put_perms_here'] = {           -- Enter Ace Group/Disocrd/Steam to which you want to be a part of this dashboard
        DashBoard_Access = 'put_perms_here',    -- Enter Ace Group/Disocrd/Steam to which you want to allow view dashboard access
        Title = 'YOUR Department',   -- Department Title
        Logo = 'police.png'
    },
}

CodeStudio.DashBoard_InsideVehicle = {  --Allow Certain Vehicles to Access Dashboard Panel and if you want to allow on all vehicles simply put false
[`sonomcc`] = true,
[`nm_redeye`] = true,
[`nm_raptor`] = true,
[`nm_cam69`] = true,
[`durangopru`] = true,
[`fdsilverado`] = true,
[`f250pov`] = true,
[`f150pov`] = true,
}

--- Required For Dashboard Locations Interaction ---
CodeStudio.UseTarget = 'qb-target'   --qb-target/ox_target | Put false if you dont want to use target
CodeStudio.UseTextUI = false         --Enable/Disable TextUI To access dashboard locations



-- BODY CAM + RECORDING SETTINGS --

CodeStudio.Default_BodyCam = {    -- This is Deault Format of Bodycam, If allowed it fetches different format's from CodeStudio.Dashboard
    Title = "Law Enforcement",
    SubHeading = 'Civilian',
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
    WebhookAPI = 'https://discord.com/api/webhooks/1260400552693727293/3Wp9iEg8sGTnxU6zJUH1hIQGVdf4imzcO-RkP53FCxEt-CAk4CemlUpRgGICA5wdvMA9',  --If you are using Fivemanage then put api key here otherwise put discord webhook
    RecordFPS = 45, -- At What FPS do you want recordings
    Max_Recording_Time = 1    ---Max time ALlowed to Record a single clip (In Minutes)
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
        -- if you dont want to use this and allow dashcam to be used in every vehicle simply put Restrict_Vehicle = false
        -- You can restrict usage of dashcam to these vehicles --
        [`sonomcc`] = true,
        [`18chargerl2`] = true,
        [`18fpisl2`] = true,
        [`19tahoel2`] = true,
        [`20fpiul2`] = true,
        [`f250l2nc`] = true,
        [`nm_redeye`] = true,
        [`nm_raptor`] = true,
        [`nm_cam69`] = true,
        [`durangopru`] = true,
        [`fdsilverado`] = true,
        [`f250pov`] = true,
        [`f150pov`] = true,
    }
}

CodeStudio.DebugCamera = false -- Make it true if you want to get new camera offset for some vehicle
CodeStudio.VehCamOffset = {
    -- The script comes with its own offset finder just set DebugCamera to true and get the camera offset.
    [`police2`] = {-3.000000, -3.330000, -3.530000},  -- Example vehicle.
    [`sonomcc`] = {-3.000000, -3.330000, -3.530000},
    [`18chargerl2`] = {-3.000000, -3.330000, -3.530000},
    [`18fpisl2`] = {-3.000000, -3.330000, -3.530000},
    [`19tahoel2`] = {-3.000000, -3.330000, -3.530000},
    [`20fpiul2`] = {-3.000000, -3.330000, -3.530000},
    [`f250l2nc`] = {-3.000000, -3.330000, -3.530000},
    [`nm_redeye`] = {-3.000000, -3.330000, -3.530000},
    [`nm_raptor`] = {-3.000000, -3.330000, -3.530000},
    [`nm_cam69`] = {-3.000000, -3.330000, -3.530000},
    [`durangopru`] = {-3.000000, -3.330000, -3.530000},
    [`fdsilverado`] = {-3.000000, -3.330000, -3.530000},
    [`f250pov`] = {-3.000000, -3.330000, -3.530000},
    [`f150pov`] = {-3.000000, -3.330000, -3.530000},
    -- [`vehiclespawncode`] = {0.000000, 0.510000, 0.630000},
}