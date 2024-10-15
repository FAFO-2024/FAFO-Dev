Config = {}
Config.Framework = "qb" -- esx
Config.Debug    = false
Config.Target   = 'qb' --ox
Config.Elevators = {
    [1] = {
        name = "FIB Building",                      -- Building name
        Group = {"ambulance","police"},             -- "jobs allowed to have access"
        item = nil,                                 -- "security_pass"
        waittime = 3000,                            -- Progress bar waiting time
        floor = {
            [1] =   {id = 1,    disabled =  true,   floor = "-2",   name = "description -2...",         width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)},
            [2] =   {id = 2,    disabled =  true,   floor = "-1",   name = "description -1...",         width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)},
            [3] =   {id = 3,    disabled =  false,  floor = "0",    name = "Ground Floor",              width = 1.0, length = 1.0,      playercoords= vector4(136.19, -761.65, 45.75, 165.06), targetcoords = vector4(136.52, -763.11, 45.75, 158.37)},
            [4] =   {id = 4,    disabled =  true,   floor = "1",    name = "description 1...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
            [5] =   {id = 5,    disabled =  true,   floor = "2",    name = "description 2...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
            [6] =   {id = 6,    disabled =  true,   floor = "3",    name = "description 3...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
            [7] =   {id = 7,    disabled =  true,   floor = "4",    name = "description 4...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
            [8] =   {id = 8,    disabled =  true,   floor = "5",    name = "description 5...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
            [9] =   {id = 9,    disabled =  true,   floor = "6",    name = "description 6...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
            [10] =  {id = 10,   disabled =  true,   floor = "7",    name = "description 7...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
            [11] =  {id = 11,   disabled =  true,   floor = "8",    name = "description 8...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
            [12] =  {id = 12,   disabled =  false,  floor = "9",    name = "Communications Office",     width = 1.0, length = 1.0,      playercoords= vector4(135.98, -762.48, 242.15, 159.14), targetcoords = vector4(136.67, -763.16, 242.15, 183.26)},
        },
    },
     [2] = {
         name = "LSPD R",                      -- Building name
         Group = {"police","sasp","sheriff","firefighter","ambulance"},             -- "jobs allowed to have access"
         item = nil,                                 -- "security_pass"
         waittime = 3000,                            -- Progress bar waiting time
         floor = {
             [1] =   {id = 1,    disabled =  false,  floor = "-2",   name = "Training",                  width = 1.0, length = 1.0,      playercoords= vector4(593.5, 16.05, 44.46, 88.17), targetcoords = vector4(592.49, 15.13, 44.46, 109.71)  },
             [2] =   {id = 2,    disabled =  false,  floor = "-1",   name = "Garage",                    width = 1.0, length = 1.0,      playercoords= vector4(540.96, 29.16, 70.63, 184.94), targetcoords = vector4(540.9, 29.24, 70.63, 1.67)  },
             [3] =   {id = 3,    disabled =  false,  floor = "0",    name = "Ground Floor LSPD",         width = 1.0, length = 1.0,      playercoords= vector4(585.87, 15.0, 82.78, 159.4), targetcoords = vector4(586.32, 13.65, 82.78, 157.22)  },
             [4] =   {id = 4,    disabled =  false,  floor = "1",    name = "Operations Office",         width = 1.0, length = 1.0,      playercoords= vector4(583.92, 18.54, 87.98, 148.33), targetcoords = vector4(584.37, 17.13, 87.98, 154.51)  },
             [5] =   {id = 5,    disabled =  false,  floor = "2",    name = "Flight Deck",               width = 1.0, length = 1.0,      playercoords= vector4(565.59, 4.92, 103.23, 268.65), targetcoords = vector4(565.69, 4.94, 103.23, 89.77)  },
             [6] =   {id = 6,    disabled =  true,   floor = "3",    name = "description 3...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
             [7] =   {id = 7,    disabled =  true,   floor = "4",    name = "description 4...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
             [8] =   {id = 8,    disabled =  true,   floor = "5",    name = "description 5...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
             [9] =   {id = 9,    disabled =  true,   floor = "6",    name = "description 6...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
             [10] =  {id = 10,   disabled =  true,   floor = "7",    name = "description 7...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
             [11] =  {id = 11,   disabled =  true,   floor = "8",    name = "description 8...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
             [12] =  {id = 12,   disabled =  true,   floor = "9",    name = "description 9...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
         },
     },
     [3] = {
        name = "LSPD L",                      -- Building name
        Group = {"police","sasp","sheriff","firefighter","ambulance"},             -- "jobs allowed to have access"
        item = nil,                                 -- "security_pass"
        waittime = 3000,                            -- Progress bar waiting time
        floor = {
            [1] =   {id = 1,    disabled =  false,  floor = "-2",   name = "Training",                  width = 1.0, length = 1.0,      playercoords= vector4(593.36, 19.41, 44.46, 89.35), targetcoords = vector4(592.29, 18.47, 44.46, 93.79)  },
            [2] =   {id = 2,    disabled =  false,  floor = "-1",   name = "Garage",                    width = 1.0, length = 1.0,      playercoords= vector4(538.06, 29.04, 70.63, 186.7), targetcoords = vector4(538.1, 29.0, 70.63, 1.84)  },
            [3] =   {id = 3,    disabled =  false,  floor = "0",    name = "Ground Floor LSPD",         width = 1.0, length = 1.0,      playercoords= vector4(582.01, 16.36, 82.78, 156.1), targetcoords = vector4(582.51, 15.08, 82.78, 154.17)  },
            [4] =   {id = 4,    disabled =  false,  floor = "1",    name = "Operations Office",         width = 1.0, length = 1.0,      playercoords= vector4(580.16, 19.93, 87.98, 154.44), targetcoords = vector4(580.57, 18.61, 87.98, 153.79)  },
            [5] =   {id = 5,    disabled =  false,  floor = "2",    name = "Flight Deck",               width = 1.0, length = 1.0,      playercoords= vector4(565.59, 4.92, 103.23, 268.65), targetcoords = vector4(565.69, 4.94, 103.23, 89.77)  },
            [6] =   {id = 6,    disabled =  true,   floor = "3",    name = "description 3...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
            [7] =   {id = 7,    disabled =  true,   floor = "4",    name = "description 4...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
            [8] =   {id = 8,    disabled =  true,   floor = "5",    name = "description 5...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
            [9] =   {id = 9,    disabled =  true,   floor = "6",    name = "description 6...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
            [10] =  {id = 10,   disabled =  true,   floor = "7",    name = "description 7...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
            [11] =  {id = 11,   disabled =  true,   floor = "8",    name = "description 8...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
            [12] =  {id = 12,   disabled =  true,   floor = "9",    name = "description 9...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
        },
    }
    -- [2] = {
    --     name = "Pillbox",                      -- Building name
    --     Group = {"ambulance","police"},             -- "jobs allowed to have access"
    --     item = "zat-ticket",                                 -- "security_pass"
    --     waittime = 3000,                            -- Progress bar waiting time
    --     floor = {
    --         [1] =   {id = 1,    disabled =  true,   floor = "-2",   name = "description -2...",         width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
    --         [2] =   {id = 2,    disabled =  true,   floor = "-1",   name = "description -1...",         width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
    --         [3] =   {id = 3,    disabled =  false,  floor = "0",    name = "Ground Floor Pillbox",      width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
    --         [4] =   {id = 4,    disabled =  true,   floor = "1",    name = "description 1...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
    --         [5] =   {id = 5,    disabled =  true,   floor = "2",    name = "description 2...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
    --         [6] =   {id = 6,    disabled =  true,   floor = "3",    name = "description 3...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
    --         [7] =   {id = 7,    disabled =  true,   floor = "4",    name = "description 4...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
    --         [8] =   {id = 8,    disabled =  true,   floor = "5",    name = "description 5...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
    --         [9] =   {id = 9,    disabled =  true,   floor = "6",    name = "description 6...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
    --         [10] =  {id = 10,   disabled =  true,   floor = "7",    name = "description 7...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
    --         [11] =  {id = 11,   disabled =  true,   floor = "8",    name = "description 8...",          width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
    --         [12] =  {id = 12,   disabled =  false,  floor = "9",    name = "Operations Office ",        width = 1.0, length = 1.0,      playercoords= vector4(0,0,0,0), targetcoords = vector4(0,0,0,0)  },
    --     },
    -- }
}
