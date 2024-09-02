Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.AvailableJobs = {                                     -- Only used when not using qb-jobs.
    --['trucker'] = { ['label'] = 'Trucker', ['isManaged'] = false },
}

Config.Cityhalls = {
    --[[ { -- Cityhall 1
        coords = vec3(-265.0, -963.6, 31.2),
        showBlip = true,
        blipData = {
            sprite = 487,
            display = 4,
            scale = 0.65,
            colour = 0,
            title = 'City Services'
        },
        licenses = {
            ['id_card'] = {
                label = 'ID Card',
                cost = 50,
            },
            ['driver_license'] = {
                label = 'Driver License',
                cost = 50,
                metadata = 'driver'
            },
        }
    }, ]]
}

Config.DrivingSchools = {
    { -- Driving School 1
        coords = vector3(212.72, -1393.84, 30.57),
        showBlip = true,
        blipData = {
            sprite = 225,
            display = 4,
            scale = 0.65,
            colour = 3,
            title = 'Driving School'
        },
        instructors = {
            'DJD56142',
            'DXT09752',
            'SRI85140',
        }
    },
}

Config.Peds = {
    -- Cityhall Ped
    --[[ {
        model = 'a_m_m_hasjew_01',
        coords = vec4(-262.79, -964.18, 30.22, 181.71),
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        cityhall = true,
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0,
            debugPoly = false
        }
    }, ]]
    -- Driving School Ped
    {
        model = 'a_m_m_eastsa_02',
        coords = vector4(218.56, -1398.2, 29.57, 52.77),
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        drivingschool = true,
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0
        }
    }
}
