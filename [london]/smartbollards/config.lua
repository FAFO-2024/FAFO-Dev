config = {

    enableDeveloperMode = false,
    -- This allows you to use the spooner to create, edit and delete bollard sets
    -- If enabled ANY user on the server will have access, so make sure this is disabled on your live server

    blips = {
        enabled = false, -- Set this to true to enable blips for the bollard sets
        -- Blips will be enabled regardless if developerMode is enabled

        -- This is the blip which will be shown on the map for the bollard sets
        -- You can change the sprite and colour of the blip here
        shortRange = false,
        sprite = 536,
        colour = 5,
        scale = 0.8,
        display = 4,
        name = "Bollard Set",
    },

    permissionSets = {
    -- This resource uses these permission sets to identify whether or not to lower the bollards
    -- If a permission set is defined, it will first check if the user is in a permitted vehicle, before checking if they have sufficient permission
    -- If no permission set is defined, it will will lower for all players in any vehicle
    -- If a pincode is enabled for a bollard set, any player who knows the pincode will be able to enter the code to lower the bollards, regardless of their job or vehicle
    -- If a bollardsets permissionsset is set to "all" then everyone will be able to use them

        ["police"] = {

            permittedVehicles = {`fbi`, `police4`}, -- Vehicles which are permitted to lower the bollards
            permissions = {
                acePermissions = {
                    enabled = false,
                    permissions = {"acePermissionHere"} -- A user can have any of the following permissions, allowing you to add multiple
                },
                ESX = {
                    enabled = false,
                    checkJob = {
                        enabled = true, -- Enable this to use ESX job check
                        jobs = {"police"} -- A user can have any of the following jobs, allowing you to add multiple
                    }
                },
                -- We've added vRP integration. All you need to do is enable it below. Then, configure if you wish to check for groups or permissions, or even both
                vRP = {
                    enabled = false,
                    checkGroup = {
                        enabled = false, -- Enable this to use vRP group check
                        groups = {"police"}, -- A user can have any of the following groups, meaning you can add different jobs
                    },
                    checkPermission = {
                        enabled = false, -- Enable this to use vRP permission check
                        permissions = {"bollards.move"} -- A user can have any of the following permissions, allowing you to add multiple
                    },
                },
                -- We've added QBCore integration. All you need to do is enable it below. Then, configure if you wish to check for jobs or permissions, or even both
                QBCore = {
                    enabled = true,
                    checkJob = {
                        enabled = true, -- Enable this to use QBCore job check
                        jobs = {"police"}, -- A user can have any of the following jobs, meaning you can add different jobs
                    },
                    checkPermission = {
                        enabled = false, -- Enable this to use QBCore permission check
                        permissions = {"bollards.move"}, -- A user can have any of the following permissions, allowing you to add multiple
                    },
                },
            }
        },
        ["fire"] = {

            permittedVehicles = {`firetruk`}, -- Vehicles which are permitted to lower the bollards
            permissions = {
                acePermissions = {
                    enabled = false,
                    permissions = {"acePermissionHere"} -- A user can have any of the following permissions, allowing you to add multiple
                },
                ESX = {
                    enabled = false,
                    checkJob = {
                        enabled = true, -- Enable this to use ESX job check
                        jobs = {"fire"} -- A user can have any of the following jobs, allowing you to add multiple
                    }
                },
                -- We've added vRP integration. All you need to do is enable it below. Then, configure if you wish to check for groups or permissions, or even both
                vRP = {
                    enabled = false,
                    checkGroup = {
                        enabled = false, -- Enable this to use vRP group check
                        groups = {"fire"}, -- A user can have any of the following groups, meaning you can add different jobs
                    },
                    checkPermission = {
                        enabled = false, -- Enable this to use vRP permission check
                        permissions = {"bollards.move"} -- A user can have any of the following permissions, allowing you to add multiple
                    },
                },
                -- We've added QBCore integration. All you need to do is enable it below. Then, configure if you wish to check for jobs or permissions, or even both
                QBCore = {
                    enabled = true,
                    checkJob = {
                        enabled = true, -- Enable this to use QBCore job check
                        jobs = {"fire"}, -- A user can have any of the following jobs, meaning you can add different jobs
                    },
                    checkPermission = {
                        enabled = false, -- Enable this to use QBCore permission check
                        permissions = {"bollards.move"}, -- A user can have any of the following permissions, allowing you to add multiple
                    },
                },
            }
        },
        ["ambulance"] = {

            permittedVehicles = {`ambulance`}, -- Vehicles which are permitted to lower the bollards
            permissions = {
                acePermissions = {
                    enabled = false,
                    permissions = {"acePermissionHere"} -- A user can have any of the following permissions, allowing you to add multiple
                },
                ESX = {
                    enabled = false,
                    checkJob = {
                        enabled = true, -- Enable this to use ESX job check
                        jobs = {"police", "admin"} -- A user can have any of the following jobs, allowing you to add multiple
                    }
                },
                -- We've added vRP integration. All you need to do is enable it below. Then, configure if you wish to check for groups or permissions, or even both
                vRP = {
                    enabled = false,
                    checkGroup = {
                        enabled = false, -- Enable this to use vRP group check
                        groups = {"police", "admin"}, -- A user can have any of the following groups, meaning you can add different jobs
                    },
                    checkPermission = {
                        enabled = false, -- Enable this to use vRP permission check
                        permissions = {"bollards.move"} -- A user can have any of the following permissions, allowing you to add multiple
                    },
                },
                -- We've added QBCore integration. All you need to do is enable it below. Then, configure if you wish to check for jobs or permissions, or even both
                QBCore = {
                    enabled = true,
                    checkJob = {
                        enabled = true, -- Enable this to use QBCore job check
                        jobs = {"police", "admin"}, -- A user can have any of the following jobs, meaning you can add different jobs
                    },
                    checkPermission = {
                        enabled = false, -- Enable this to use QBCore permission check
                        permissions = {"bolalrds.move"}, -- A user can have any of the following permissions, allowing you to add multiple
                    },
                },
            }
        },
    },

    -- These messages are configurable messages which will be shown to the user.
    messages = {
        correctCode = "Access code correctly entered.",
        incorrectCode = "Incorrect access code entered.",
        pincodeInstructions = "Press [E] to enter access code.",
        pincodeWindowTitle = "Enter 4-digit access code:",
    },

    -- These are the models which will be used for the bollards
    -- It is highly unlikely you will need to change these, but if you do need to do so, you can change them here
    models = {   
        base = `bv_autobollard_base`,
        mobile_bollard = `bv_autobollard_bands`,
        static_bollard = `bv_autobollard1`,
        bollard_band_yellow = `bv_autobollard_band_light_yellow`,
        bollard_band_red = `bv_autobollard_band_light_red`,
        signalPost = `bv_autobollard_lightpost`,
        signalPost_bollard = `bv_autobollard_lightpost2`,
        redSignal = `bv_ab_red`,
        greenSignal = `bv_ab_green`,
    },
}

