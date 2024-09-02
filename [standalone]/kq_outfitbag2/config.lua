Config = {}

Config.debug = false

----------------------------------
--- FRAMEWORK SETTINGS
----------------------------------
--- If using a standalone solution, keep both frameworks disabled.

Config.esxSettings = {
    enabled = false,
    -- Whether or not to use the new ESX export method
    useNewESXExport = false
}

Config.qbSettings = {
    enabled = true,
}

----------------------------------
--- COMMAND / STANDALONE USAGE
----------------------------------
-- Outfitbag command settings
Config.command = {
    enabled = false,
    command = 'outfitbag',
    shortCommand = 'ob'
}

----------------------------------
--- SYSTEMS
----------------------------------
Config.sql = {
    driver = 'oxmysql', -- oxmysql or ghmattimysql or mysql
    -- If you're using an older version of oxmysql set this to false
    newOxMysql = true,
}

Config.target = {
    enabled = true,
    system = 'qb-target' -- 'qtarget' or 'qb-target' or 'ox_target' (Other systems might work as well)
}


----------------------------------
--- THEMING
----------------------------------
-- Here you can set the accent colors of the UI
Config.theme = {
    colors = {
        -- Used for the preview border and hover on buttons
        primary = {
            r = 178,
            g = 244,
            b = 0,
        },
        -- Used for the secondary hover color on buttons
        secondary = {
            r = 168,
            g = 242,
            b = 63,
        },
    },
}

----------------------------------
--- ITEMS
----------------------------------
-- Name of the item which will be usable as the bag
Config.bagItem = 'kq_outfitbag'


-- If you want to have different kind of bags you can add them here (These will have separate inventories)
-- Make sure to add the item to your database / file
Config.additionalItems = {
}

--[[ EXAMPLE
Config.additionalItems = {
    'kq_outfitbag_2',
}
]]--

----------------------------------
--- GENERAL
----------------------------------

-- Maxmimum amount of outfits that people can save per bag
Config.maxOutfits = 15

-- Whether or not to allow players to share their outfits
Config.allowBagSharing = true

-- The 3d object of the bag
Config.bagObject = 'reh_prop_reh_bag_outfit_01a'

-- Whether or not to delete the previous bag if player is placing a new one on the ground
Config.onlyAllowOneBagOnGround = true

-- Automatic bag despawning system
Config.bagDespawning = {
    enabled = true,
    time = 15, -- time in minutes
}

-- Whether to save outfits using an external system (this will make players keep their outfit upon relog when using a specialized outfit resource)
Config.clothingSystemSaving = {
    enabled = false,
    system = 'illenium-appearance', -- illenium-appearance or fivem-appearance by default.
    -- To add your custom system; you can do this in the client/editable/editable.lua file within the OnPlayerApplyOutfit function
}

----------------------------------
--- ANIMATIONS
----------------------------------
-- The idle animation when using or picking up a bag
Config.bagAnimation = {
    enabled = true,
    dict = 'amb@medic@standing@tendtodead@idle_a',
    anim = 'idle_a',
}

-- Animations played when changing outfits per body part
Config.outfitChangeAnimation = {
    head = {
        duration = 2000,
        dict = 'mp_cp_stolen_tut',
        anim = 'b_think',
    },
    top = {
        duration = 4000,
        dict = 'mp_safehouseshower@male@',
        anim = 'male_shower_towel_dry_to_get_dressed',
    },
    bottom = {
        duration = 4000,
        dict = 'clothingshoes',
        anim = 'try_shoes_positive_d',
    },
}

-- Animations which will be performed by the preview character when previewing a new outfit
Config.preview = {
    enabled = true,
    animations = {
        {'clothingshirt', 'check_out_c'},
        {'clothingshirt', 'try_shirt_positive_a'},
        {'random@getawaydriver', 'gesture_nod_yes_soft'},
        {'clothingshirt', 'try_shirt_neutral_a'},
        {'clothingshoes', 'try_shoes_positive_d'},
        {'clothingshirt', 'try_shirt_neutral_b'},
    },
}

----------------------------------
--- KEYBINDS
----------------------------------
-- Keybinds. Only when not using targeting
Config.keybinds = {
    pickup = {
        label = 'G',
        input = 58,
    },
    open = {
        label = 'E',
        input = 38,
    },
}

----------------------------------
--- FIXED BAGS
----------------------------------
-- Here you can easily add new outfits for static bags and bags using exports.
-- When debug mode is enabled you may use the /outfit-output [name] - command. This will output a file
-- into the outfit-outputs directory. You can open the newly created text file. Copy and paste the outfit here into the
-- bag you wish to add the outfit to.
Config.fixedBags = {
    ['gang'] = {
        bags = {
            locations = {
                vector4(87.44, -1963.54, 20.74, 50.0),
            },
        },
        outfits = {
            {
                name = "Example",
                model = 1885233650,
                drawable = {
                    tops = { drawable = 171, texture = 1, palette = 0 },
                    bag = { drawable = 45, texture = 0, palette = 0 },
                    undershirt = { drawable = 15, texture = 0, palette = 0 },
                    torso = { drawable = 4, texture = 0, palette = 0 },
                    chest = { drawable = 0, texture = 0, palette = 0 },
                    accessory = { drawable = 0, texture = 0, palette = 0 },
                    decals = { drawable = 0, texture = 0, palette = 0 },
                    mask = { drawable = 54, texture = 0, palette = 0 },
                    legs = { drawable = 31, texture = 0, palette = 0 },
                    feet = { drawable = 25, texture = 0, palette = 0 },
                },
                props = {
                    helmet = { prop = -1, texture = -1 },
                    glasses = { prop = 0, texture = 0 },
                    ear = { prop = 0, texture = 0 },
                },
            },
        }
    },
    ['police'] = {
        bags = {
            jobs = {
                'police',
                'sasp',
                'sheriff',
            },
            locations = {
                --vector4(592.66, -11.23, 72.82, 336.4),
            },
        },
        outfits = {
            {
                name = "PD Patrol M",
                model = 1885233650,
                drawable = {
                  feet = { drawable = 25, texture = 0, palette = 2 }, 
                  decals = { drawable = 0, texture = 0, palette = 2 }, 
                  tops = { drawable = 546, texture = 2, palette = 2 }, 
                  mask = { drawable = 121, texture = 0, palette = 2 }, 
                  torso = { drawable = 0, texture = 0, palette = 2 }, 
                  chest = { drawable = 13, texture = 0, palette = 2 }, 
                  legs = { drawable = 188, texture = 0, palette = 2 }, 
                  bag = { drawable = 0, texture = 0, palette = 2 }, 
                  accessory = { drawable = 1, texture = 0, palette = 2 }, 
                  undershirt = { drawable = 38, texture = 1, palette = 2 }, 
                },
                props = {
                  glasses = { prop = 0, texture = 0 }, 
                  helmet = { prop = 209, texture = 0 }, 
                  ear = { prop = -1, texture = -1 }, 
                },
              },
            {
                name = "PD Supervisor M",
                model = 1885233650,
                drawable = {
                  feet = { drawable = 25, texture = 0, palette = 2 }, 
                  decals = { drawable = 0, texture = 0, palette = 2 }, 
                  tops = { drawable = 546, texture = 0, palette = 2 }, 
                  mask = { drawable = 121, texture = 0, palette = 2 }, 
                  torso = { drawable = 0, texture = 0, palette = 2 }, 
                  chest = { drawable = 13, texture = 0, palette = 2 }, 
                  legs = { drawable = 188, texture = 0, palette = 2 }, 
                  bag = { drawable = 0, texture = 0, palette = 2 }, 
                  accessory = { drawable = 1, texture = 0, palette = 2 }, 
                  undershirt = { drawable = 38, texture = 1, palette = 2 }, 
                },
                props = {
                  glasses = { prop = 0, texture = 0 }, 
                  helmet = { prop = 209, texture = 0 }, 
                  ear = { prop = -1, texture = -1 }, 
                },
              },
            {
                name = "PD Assistant M",
                model = 1885233650,
                drawable = {
                  feet = { drawable = 25, texture = 0, palette = 2 }, 
                  decals = { drawable = 0, texture = 0, palette = 2 }, 
                  tops = { drawable = 546, texture = 3, palette = 2 }, 
                  mask = { drawable = 121, texture = 0, palette = 2 }, 
                  torso = { drawable = 0, texture = 0, palette = 2 }, 
                  chest = { drawable = 13, texture = 0, palette = 2 }, 
                  legs = { drawable = 188, texture = 0, palette = 2 }, 
                  bag = { drawable = 0, texture = 0, palette = 2 }, 
                  accessory = { drawable = 1, texture = 0, palette = 2 }, 
                  undershirt = { drawable = 38, texture = 1, palette = 2 }, 
                },
                props = {
                  glasses = { prop = 0, texture = 0 }, 
                  helmet = { prop = 209, texture = 0 }, 
                  ear = { prop = -1, texture = -1 }, 
                },
              },
            {
                name = "PD Command M",
                model = 1885233650,
                drawable = {
                  feet = { drawable = 25, texture = 0, palette = 2 }, 
                  decals = { drawable = 0, texture = 0, palette = 2 }, 
                  tops = { drawable = 546, texture = 4, palette = 2 }, 
                  mask = { drawable = 121, texture = 0, palette = 2 }, 
                  torso = { drawable = 0, texture = 0, palette = 2 }, 
                  chest = { drawable = 13, texture = 0, palette = 2 }, 
                  legs = { drawable = 188, texture = 0, palette = 2 }, 
                  bag = { drawable = 0, texture = 0, palette = 2 }, 
                  accessory = { drawable = 1, texture = 0, palette = 2 }, 
                  undershirt = { drawable = 38, texture = 1, palette = 2 }, 
                },
                props = {
                  glasses = { prop = 0, texture = 0 }, 
                  helmet = { prop = 209, texture = 0 }, 
                  ear = { prop = -1, texture = -1 }, 
                },
              },
            {
                name = "SP Patrol M",
                model = 1885233650,
                drawable = {
                  mask = { drawable = 121, texture = 0, palette = 2 }, 
                  bag = { drawable = 123, texture = 0, palette = 2 }, 
                  decals = { drawable = 0, texture = 0, palette = 2 }, 
                  torso = { drawable = 11, texture = 0, palette = 2 }, 
                  chest = { drawable = 13, texture = 0, palette = 2 }, 
                  accessory = { drawable = 1, texture = 0, palette = 2 }, 
                  legs = { drawable = 198, texture = 0, palette = 2 }, 
                  tops = { drawable = 565, texture = 0, palette = 2 }, 
                  feet = { drawable = 25, texture = 0, palette = 2 }, 
                  undershirt = { drawable = 38, texture = 0, palette = 2 }, 
                },
                props = {
                  helmet = { prop = 219, texture = 0 }, 
                  glasses = { prop = 0, texture = 0 }, 
                  ear = { prop = -1, texture = -1 }, 
                },
              },
            {
                name = "SP Supervisor M",
                model = 1885233650,
                drawable = {
                  mask = { drawable = 121, texture = 0, palette = 2 }, 
                  bag = { drawable = 123, texture = 0, palette = 2 }, 
                  decals = { drawable = 44, texture = 1, palette = 2 }, 
                  torso = { drawable = 11, texture = 0, palette = 2 }, 
                  chest = { drawable = 13, texture = 0, palette = 2 }, 
                  accessory = { drawable = 1, texture = 0, palette = 2 }, 
                  legs = { drawable = 198, texture = 0, palette = 2 }, 
                  tops = { drawable = 565, texture = 1, palette = 2 }, 
                  feet = { drawable = 25, texture = 0, palette = 2 }, 
                  undershirt = { drawable = 38, texture = 0, palette = 2 }, 
                },
                props = {
                  helmet = { prop = 219, texture = 0 }, 
                  glasses = { prop = 0, texture = 0 }, 
                  ear = { prop = -1, texture = -1 }, 
                },
              },
            {
                name = "SP Assistant M",
                model = 1885233650,
                drawable = {
                  mask = { drawable = 121, texture = 0, palette = 2 }, 
                  bag = { drawable = 123, texture = 0, palette = 2 }, 
                  decals = { drawable = 44, texture = 3, palette = 2 }, 
                  torso = { drawable = 11, texture = 0, palette = 2 }, 
                  chest = { drawable = 13, texture = 0, palette = 2 }, 
                  accessory = { drawable = 1, texture = 0, palette = 2 }, 
                  legs = { drawable = 198, texture = 0, palette = 2 }, 
                  tops = { drawable = 565, texture = 2, palette = 2 }, 
                  feet = { drawable = 25, texture = 0, palette = 2 }, 
                  undershirt = { drawable = 38, texture = 0, palette = 2 }, 
                },
                props = {
                  helmet = { prop = 219, texture = 0 }, 
                  glasses = { prop = 0, texture = 0 }, 
                  ear = { prop = -1, texture = -1 }, 
                },
              },
            {
                name = "PD Command M",
                model = 1885233650,
                drawable = {
                  feet = { drawable = 25, texture = 0, palette = 2 }, 
                  decals = { drawable = 0, texture = 0, palette = 2 }, 
                  tops = { drawable = 546, texture = 4, palette = 2 }, 
                  mask = { drawable = 121, texture = 0, palette = 2 }, 
                  torso = { drawable = 0, texture = 0, palette = 2 }, 
                  chest = { drawable = 13, texture = 0, palette = 2 }, 
                  legs = { drawable = 188, texture = 0, palette = 2 }, 
                  bag = { drawable = 0, texture = 0, palette = 2 }, 
                  accessory = { drawable = 1, texture = 0, palette = 2 }, 
                  undershirt = { drawable = 38, texture = 1, palette = 2 }, 
                },
                props = {
                  glasses = { prop = 0, texture = 0 }, 
                  helmet = { prop = 209, texture = 0 }, 
                  ear = { prop = -1, texture = -1 }, 
                },
              },
            {
                name = "SO Patrol M",
                model = 1885233650,
                drawable = {
                  mask = { drawable = 121, texture = 0, palette = 2 }, 
                  bag = { drawable = 116, texture = 0, palette = 2 }, 
                  decals = { drawable = 0, texture = 0, palette = 2 }, 
                  torso = { drawable = 11, texture = 0, palette = 2 }, 
                  chest = { drawable = 13, texture = 0, palette = 2 }, 
                  accessory = { drawable = 1, texture = 0, palette = 2 }, 
                  legs = { drawable = 184, texture = 0, palette = 2 }, 
                  tops = { drawable = 532, texture = 0, palette = 2 }, 
                  feet = { drawable = 25, texture = 0, palette = 2 }, 
                  undershirt = { drawable = 38, texture = 0, palette = 2 }, 
                },
                props = {
                  helmet = { prop = 205, texture = 0 }, 
                  glasses = { prop = 0, texture = 0 }, 
                  ear = { prop = -1, texture = -1 }, 
                },
              },
            {
                name = "SO Supervisor M",
                model = 1885233650,
                drawable = {
                  mask = { drawable = 121, texture = 0, palette = 2 }, 
                  bag = { drawable = 116, texture = 1, palette = 2 }, 
                  decals = { drawable = 44, texture = 1, palette = 2 }, 
                  torso = { drawable = 11, texture = 0, palette = 2 }, 
                  chest = { drawable = 13, texture = 0, palette = 2 }, 
                  accessory = { drawable = 1, texture = 0, palette = 2 }, 
                  legs = { drawable = 184, texture = 0, palette = 2 }, 
                  tops = { drawable = 532, texture = 1, palette = 2 }, 
                  feet = { drawable = 25, texture = 0, palette = 2 }, 
                  undershirt = { drawable = 38, texture = 0, palette = 2 }, 
                },
                props = {
                  helmet = { prop = 205, texture = 0 }, 
                  glasses = { prop = 0, texture = 0 }, 
                  ear = { prop = -1, texture = -1 }, 
                },
              },
            {
                name = "SO Assistant M",
                model = 1885233650,
                drawable = {
                  mask = { drawable = 121, texture = 0, palette = 2 }, 
                  bag = { drawable = 116, texture = 2, palette = 2 }, 
                  decals = { drawable = 44, texture = 3, palette = 2 }, 
                  torso = { drawable = 11, texture = 0, palette = 2 }, 
                  chest = { drawable = 13, texture = 0, palette = 2 }, 
                  accessory = { drawable = 1, texture = 0, palette = 2 }, 
                  legs = { drawable = 184, texture = 0, palette = 2 }, 
                  tops = { drawable = 532, texture = 2, palette = 2 }, 
                  feet = { drawable = 25, texture = 0, palette = 2 }, 
                  undershirt = { drawable = 38, texture = 0, palette = 2 }, 
                },
                props = {
                  helmet = { prop = 205, texture = 0 }, 
                  glasses = { prop = 0, texture = 0 }, 
                  ear = { prop = -1, texture = -1 }, 
                },
              },
            {
                name = "SO Command M",
                model = 1885233650,
                drawable = {
                  mask = { drawable = 121, texture = 0, palette = 2 }, 
                  bag = { drawable = 116, texture = 4, palette = 2 }, 
                  decals = { drawable = 41, texture = 0, palette = 2 }, 
                  torso = { drawable = 11, texture = 0, palette = 2 }, 
                  chest = { drawable = 13, texture = 0, palette = 2 }, 
                  accessory = { drawable = 1, texture = 0, palette = 2 }, 
                  legs = { drawable = 184, texture = 0, palette = 2 }, 
                  tops = { drawable = 532, texture = 2, palette = 2 }, 
                  feet = { drawable = 25, texture = 0, palette = 2 }, 
                  undershirt = { drawable = 38, texture = 0, palette = 2 }, 
                },
                props = {
                  helmet = { prop = 205, texture = 1 }, 
                  glasses = { prop = 0, texture = 0 }, 
                  ear = { prop = -1, texture = -1 }, 
                },
              },
            {
                name = "Female officer",
                model = -1667301416,
                drawable = {
                    chest = { drawable = 0, texture = 0, palette = 0 },
                    decals = { drawable = 0, texture = 0, palette = 0 },
                    torso = { drawable = 44, texture = 0, palette = 0 },
                    bag = { drawable = 0, texture = 0, palette = 0 },
                    mask = { drawable = 0, texture = 0, palette = 0 },
                    undershirt = { drawable = 35, texture = 0, palette = 0 },
                    legs = { drawable = 34, texture = 0, palette = 0 },
                    tops = { drawable = 48, texture = 0, palette = 0 },
                    accessory = { drawable = 0, texture = 0, palette = 0 },
                    feet = { drawable = 27, texture = 0, palette = 0 },
                },
                props = {
                    ear = { prop = 2, texture = 0 },
                    glasses = { prop = -1, texture = -1 },
                    helmet = { prop = -1, texture = -1 },
                },
            },
            {
                name = "Female Bulletproof",
                model = -1667301416,
                drawable = {
                    feet = { drawable = 27, texture = 0, palette = 0 },
                    torso = { drawable = 44, texture = 0, palette = 0 },
                    legs = { drawable = 34, texture = 0, palette = 0 },
                    mask = { drawable = 0, texture = 0, palette = 0 },
                    tops = { drawable = 48, texture = 0, palette = 0 },
                    accessory = { drawable = 0, texture = 0, palette = 0 },
                    chest = { drawable = 13, texture = 1, palette = 0 },
                    decals = { drawable = 0, texture = 0, palette = 0 },
                    bag = { drawable = 0, texture = 0, palette = 0 },
                    undershirt = { drawable = 35, texture = 0, palette = 0 },
                },
                props = {
                    helmet = { prop = -1, texture = -1 },
                    ear = { prop = 2, texture = 0 },
                    glasses = { prop = -1, texture = -1 },
                },
            },
            {
                name = "Female Trooper",
                model = -1667301416,
                drawable = {
                    chest = { drawable = 34, texture = 0, palette = 0 },
                    decals = { drawable = 0, texture = 0, palette = 0 },
                    torso = { drawable = 31, texture = 0, palette = 0 },
                    bag = { drawable = 0, texture = 0, palette = 0 },
                    mask = { drawable = 0, texture = 0, palette = 0 },
                    undershirt = { drawable = 35, texture = 0, palette = 0 },
                    legs = { drawable = 133, texture = 0, palette = 0 },
                    tops = { drawable = 327, texture = 3, palette = 0 },
                    accessory = { drawable = 0, texture = 0, palette = 0 },
                    feet = { drawable = 52, texture = 0, palette = 0 },
                },
                props = {
                    ear = { prop = 2, texture = 0 },
                    glasses = { prop = -1, texture = -1 },
                    helmet = { prop = -1, texture = -1 },
                },
            },
        }
    }
}
