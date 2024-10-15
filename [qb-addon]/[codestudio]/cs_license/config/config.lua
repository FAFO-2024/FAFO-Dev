CodeStudio = {}

CodeStudio.AutoSQL = true
CodeStudio.Debug = false

-- 'QB' = For QBCore Framework
-- 'ESX' = For ESX Framework

CodeStudio.ServerType = 'QB'    --QB|ESX

CodeStudio.IDSettings = {
    Animations = false,     -- Enable/Disable License Use Animation
    AutoDisappearID = {     
        Enable = false,     -- Auto Hide License Display after certain time
        Wait = 3000         -- Time in ms
    },
    useMetaData = false    --Enable/Disable Metadata Licenses (Depending upon your inventory support)
}


CodeStudio.IDPhotoMode = {
    -- studio = Player will go into Photo Studio and click photo (*Requires MetaData)
    -- auto = Automatically Grab Players Mugshot
    -- none = Use Default Pic, No Profile Photo 

    ProfilePic_Type = 'auto',     --Enter Type 'studio'|'auto'|'none'

    -- This is Only for Studio Mode -- (*Requires MetaData Enabled)
    StudioLocation = vector4(402.92, -996.50, -100.00, 184),  --Photo Studio Location (Normal Studio)
    useGreenScreen = false,     --true: Green Screen Studio | false: Normal Studio
    Save_Method = 'discord'     --discord|fivemanage|fivemerr   *[PUT WEBHOOK OR API IN SV_FUNCTION.LUA ]
}


CodeStudio.LocationSettings = {     --Location Access Settings
    useTarget = {
        Enable = false,              --Toggle target system
        Target = 'qb-target'        --qb-target/ox_target
    },
    useTextUI = {
        Enable = true,              --Toggle textUi system requires
        openKey = 38                --Key to open menu
    },
}


CodeStudio.LicenseCreator = {       --Ingmae License Creator for Admins
    creatorCommand = 'idcreate',    --Command Name
    Restrict = {    --Restrict Jobs | Ace Perms | Identifers(Discord/Steam/Fivem)
        'discord:968848387132772434',
    }
}


CodeStudio.LicenseChecker = {        --License Check to verify all issued licenses of a player
    Enable = true,  --Enable/Disable License Checker
    checkCommand = 'idcheck',  --Command Name
    Restrict = {    --Restrict Jobs | Ace Perms | Identifers(Discord/Steam/Fivem)
        'police',
    }
}


CodeStudio.FakeID = {       --Fake/Forged license System (This Requires CodeStudio.IDSettings.useMetaData)
    Enable = true,
    itemName = 'fake_id',   --Fake/Forged license Item Name
    location = {    --Multiple Location Support
        vector4(707.33, -966.9, 30.41, 177.56)
    }
}


CodeStudio.LicenseMenu = {  --License Collection Menu
    [1] = {
        location = {     --Multiple Location Support
            vector4(-1082.16, -247.48, 37.76, 201.58),
        },
        types = {   --Types of licenses you want to allow in the license collection menu
            PublicID = true,
            JobID = true,
            WorkerID = true,
        }
    },
    -- You Can Add Unlimited License Collection Menu --
    
}

CodeStudio.LicenseMenu_Blip = { --Blip Settings for License Collection Menu
    Enable = true,      --Enable/Disable Blips
    blipsprite = 498,
    blipscale = 0.8,
    blipcolor = 0,
    blipText = 'License Collection Menu'
}



CodeStudio.Management = {
    ['police'] = {  --Job Name
        minRank = 1,    --Minimum Rank or Grade Required to Access Management Panel
        JobBadge = {
            Enable = true,                  -- Enable/Disable Job Badge
            Name = "Police Department",     -- Badge Name
            Logo = 'image/default.png',     -- Badge Logo (Supports URL too)
            ThemeColor = '#373d4c',         -- Badge Theme Color Hex
            -- CustomBG = 'https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvcm00ODYtYmctMDE5LXguanBn.jpg',  -- Badge Custom Background
            Price = 0,                      -- Badge Price
            ItemName = 'police_card'        -- Badge Item Name
        },
        location = {        --Multiple Location Support
            vector4(459.84, -988.87, 24.91, 261.8)
        }
    },

    ['ambulance'] = {  --Job Name
        minRank = 1,    --Minimum Rank or Grade Required to Access Management Panel
        JobBadge = {
            Enable = true,                  -- Enable/Disable Job Badge
            Name = "EMS Department",        -- Badge Name
            Logo = 'image/default.png',     -- Badge Logo (Supports URL too)
            ThemeColor = '#FFB6C1',         -- Badge Theme Color Hex
            Price = 0,                      -- Badge Price
            ItemName = 'ems_card'           -- Badge Item Name
        },
        location = {        --Multiple Location Support
            vector4(464.2, -984.32, 25.57, 1.26)
        }
    }

    -- You Can Add Unlimited Job Management Panels--
    
}


CodeStudio.WorkerID = {  --Worker ID Setup
    ['postal'] = {  --Job Name
        ItemName = 'postal_id',         -- Worker ID Item Name
        JobTitle = 'Go Postal',         -- Worker ID Name
        Logo = 'image/go-postal.png',   -- Worker ID Logo (Supports URL too)
        ThemeColor = '#eb4f4f',         -- Worker ID Theme Color Hex
        Price = 0,                      -- Worker ID Price
    }
    -- You Can Add Unlimited Worker IDs --
    
}

