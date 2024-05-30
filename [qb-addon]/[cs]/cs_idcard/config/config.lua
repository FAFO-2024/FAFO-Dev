CodeStudio = {}
CodeStudio.Debug = false

CodeStudio.OpenUI = {
    Enable = true,              --Enalbe/Disable Loccatons (*You can turn this off if you want to use with events Check Documentation for Info)
    useTarget = {
        Enable = true,
        Target = 'qb-target',     ---Supports qb-target/ox_target
        SpawnPed = false,
        TargetPed = `cs_lazlow`
    },
    useTextUI = { --You can use this if you dont want to use target
        Enable = false,
        openKey = 38    --E
    }
}

CodeStudio.UseMetaData = true    --Enalbe this if you are using inventory that supports metadata (qb-inventory, ox_inventory, qs-inventory)

CodeStudio.Animations = {   --(Requires dpemotes/rpemotes)
    enable = true,
    ID_Prop = `prop_franklin_dl`,
    Badge_Prop = `prop_fib_badge`
}

CodeStudio.AutoDisappearID = {          --IF you want to auto disappear ID insted of pressing ESC to close ID when player shows ID
    Enable = true,
    Wait = 6000
}


CodeStudio.ID_IssueLoc = {   -- if CodeStudio.OpenUI is enabled [This is where players will get the IDs]
    [1] = {
        job = {     --Job to access id/job card license (if you want everyone to access put false)
            'police',
            'sasp',
            'sheriff',
        },
        coords = {      --You can Add Multiple Coords 
            vector4(-394.27, -335.07, 32.4, 73.75),
        },

        Available_Cards = {       --Includes Public/Job ID    (Check: CodeStudio.ID_Cards, CodeStudio.Job_Cards)
            'id_card',
            'driving_card',
            'police',       -- if you put job card here it should be in CodeStudio.Job_Cards aswell
            'sasp',
            'sheriff',
        }
    },
    [2] = {
        job = {     --Job to access id/job card license (if you want everyone to access put false)
            'firefighter',
            'ambulance',
        },
        coords = {      --You can Add Multiple Coords 
            vector4(-1049.68, -1425.63, 4.97, 165.14),
        },

        Available_Cards = {       --Includes Public/Job ID    (Check: CodeStudio.ID_Cards, CodeStudio.Job_Cards)
            'id_card',
            'driving_card',
            'firefighter',       -- if you put job card here it should be in CodeStudio.Job_Cards aswell
            'ambulance',
        }
    },
    [3] = {
        job = false,
        coords = {
            vector4(-1081.69, -247.34, 36.76, 180),
        },

        Available_Cards = {
            'id_card',
            'driving_card',
        }
    },
    [4] = {
        job = false,
        coords = {  --weapons license pick up
            vector4(-377.12, -347.07, 31.65, 143.31),
        },

        Available_Cards = {
            'weapon_card',
        }
    },
    --[[ [5] = {
        job = false,
        coords = {  --hunting license pick up
            vector4(-378.59, -356.73, 31.65, 20.54),
        },

        Available_Cards = {
            'hunting_card',
        }
    }, ]]
}



CodeStudio.ManageMent = {   -- if CodeStudio.OpenUI is enabled [This is where job boss will issue/revoke IDs]
    [1] = {
        job = { --Jobs with grades to access management menus you can add multiple jobs
            ['police'] = 4,
            ['sasp'] = 4,
            ['sheriff'] = 4,
        },
        coords = {  -- You can add multiple locations
            vector4(-394.74, -338.98, 32.4, 80.41),
        },
        JobCard = true,      --Job ID Management where you can grant and revoke job cards
        PublicCard = {       --Public ID Management where you can revoke and grant licenses from: CodeStudio.ID_Cards
            'id_card',
            'driving_card',
            'weapon_card',
        },
    },
    [2] = {
        job = { --Jobs with grades to access management menus you can add multiple jobs
            ['firefighter'] = 4,
            ['ambulance'] = 5,
        },
        coords = {  -- You can add multiple locations
            vector4(-1052.7, -1423.25, 4.99, 257.42),
        },
        JobCard = true,
        PublicCard = {
        },
    },
    [3] = {
        job = {
            ['lawyer'] = 1,
        },
        coords = {
            vector4(1),
        },
        JobCard = false,
        PublicCard = {'id_card'},
    },
}

