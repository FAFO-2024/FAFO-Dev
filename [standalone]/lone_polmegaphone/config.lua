--Made by Lone with ❤️

Config = {}

Config.framework = 'qb' -- qb / esx

Config.job      = 'police, sasp, sheriff, ambulance, firefighter' --job the player should be to use. i suggest to use police/ambulance and it should only work in emergency vehicles
Config.maxrange = 40 --max audible range
Config.keybind  = 'LSHIFT' --keybind to activate the megaphone (hold the button)
Config.micon    = 'Hold Megaphone' --text that shown when megaphone activated
Config.micoff   = 'Megaphone off' --text that shown when megaphone deactivated


--SubMIX filter for megaphone adjust as your wish

--play with values to get your desired audio filter but this one is good
Config.submix = {
                    [`default`] = 0,
                    [`freq_low`] = 0.0,
                    [`freq_hi`] = 10000.0,
                    [`rm_mod_freq`] = 300.0,
                    [`rm_mix`] = 0.2,
                    [`fudge`] = 0.0,
                    [`o_freq_lo`] = 200.0,
                    [`o_freq_hi`] = 5000.0,
                }