Config = {}

-- General Configuration Section --
Config.configuration_version = 3.0 -- Don't change this unless you've updated the script
Config.debug_mode = true -- Only useful for developers and if support asks you to enable it

Config.controller = {
    ["arrowp"] = 'arrow',
    ["arrowb"] = 'arrow',
    ["arrowc"] = 'arrow',
    ["bcsotransp1"] = 'whelen-gw',
    ["lcsotransp1"] = 'whelen-gw',
    ["lcso4"] = 'whelen-gw',
    ["lcso3"] = 'whelen-gw',
    ["lcso1"] = 'whelen-gw',
    ["bcso1"] = 'whelen-gw',
    ["f250gw"] = 'whelen-gw',
    ["f150gw"] = 'whelen-gw',
    ["22f550skeeters"] = 'whelen-skeet',
    ["22f550skeeters2"] = 'whelen-skeet',
    ["22f550skeeterc"] = 'whelen-skeet',
    ["22f550skeeterc2"] = 'whelen-skeet',
    ["22f550skeeterc6x6"] = 'whelen-skeet',
    ["22f550skeeterc26x6"] = 'whelen-skeet',
    ["22f550skeeters6x6"] = 'whelen-skeet',
    ["22f550skeeters26x6"] = 'whelen-skeet',
    ["1500"] = 'whelen-skeet',
    ["challengers"] = 'whelen-skeet',
    ["f550ambow"] = 'whelen-skeet',
    ["f550ambows"] = 'whelen-skeet',
    ["18chargerslr"] = "pathfinder",
    ["sasp1"] = "cencom",
    ["sasp3"] = "cencom",
    ["sasp2"] = "cencom",
    ["sasp5"] = "cencom",
    ["sasp6"] = "cencom",
    ["sasp7"] = "cencom",
    ["sasp8"] = "cencom",
    ["sasp9"] = "cencom",
    ["sasp2k9"] = "cencom",
    ["sasp3k9"] = "cencom",
    ["sasp4"] = "cencom",
    ["sasp4k9"] = "cencom",
    ["bcso3"] = "zthree",
    ["bcso2"] = "zthree",
    ["bcso4"] = "zthree",
    ["lcso2"] = "matrix",
    ["f550amboc"] = "matrix-extras",
    ["f550ambocs"] = "matrix-extras",
    ["f550amboc2"] = "matrix-extras",
    ["f550amboc2s"] = "matrix-extras",
}
--[[ 
    Options: "whelen" (Game Warden Trucks) and "arrow" (Arrow Engine) 
    Ensure to add any vehicles with the "arrow" controller to both the noTAC and noPP list at the bottom.
]]

Config.stageLighting = {
    ['sasp1'] = {
        one = {2, 5}, -- Extras for Stage 1
        two = {3}, -- Extras for Stage 2
        three = {4} -- Extras for Stage 3
    },
    ['sasp2'] = {
        one = {2, 5},
        two = {3},
        three = {4, 6, 7}
    },
    ['sasp2k9'] = {
        one = {2, 5},
        two = {3},
        three = {4, 6, 7}
    },
    ['sasp3'] = {
        one = {2, 5},
        two = {3},
        three = {4, 6, 7}
    },
    ['sasp3k9'] = {
        one = {2, 5},
        two = {3},
        three = {4, 6, 7}
    },
    ['sasp4k9'] = {
        one = {2, 5},
        two = {3},
        three = {4, 6, 7}
    },
    ['sasp4'] = {
        one = {2, 5},
        two = {3},
        three = {4, 6, 7}
    },
    ['sasp5'] = {
        one = {2, 5},
        two = {3},
        three = {4, 6, 7}
    },
    ['sasp6'] = {
        one = {2, 5},
        two = {3},
        three = {4, 6, 7}
    },
    ['sasp7'] = {
        one = {2, 5},
        two = {3},
        three = {4, 6, 7}
    },
    ['sasp8'] = {
        one = {2, 5},
        two = {3},
        three = {4, 6, 7}
    },
    ['sasp9'] = {
        one = {2, 5},
        two = {3},
        three = {4, 6, 7}
    },
    ['1500'] = {
        one = {1},
        two = {2, 5},
        three = {3}
    },
    ['challengers'] = {
        one = {1},
        two = {2},
        three = {3, 4}
    },
}

Config.vehicles = {
    --[[ Example Vehicle Configuration Template, copy and paste the following with a comma (,)
        at the end of line 32 (thirty-two), the items are lableded with explanatory comments after each item.
        All numbers are arrays, the curly braces ({}) must remain, separate multiple extra numbers with a comma.
        If a vehicle does not have a specific extra type simply leave an empty set of curly braces and
        it will be ignored.
    ]]
    ["challengers"] = {
        ["parkpattern"] = {
            enabled = {
                on = {5},
                off = {1, 2, 3, 4}
            },
            disabled = {
                on = {1, 2, 3, 4},
                off = {5}
            },
        }, -- Park Pattern Lighting
        ["cruise"] = {
            enabled = {
                on = {6},
                off = {}
            },
            disabled = {
                on = {},
                off = {6}
            },
        }, -- Cruise lighting
    },
    ["1500"] = {
        ["parkpattern"] = {
            enabled = {
                on = {4},
                off = {1, 2, 3, 5}
            },
            disabled = {
                on = {1, 2, 3, 5},
                off = {4}
            },
        }, -- Park Pattern Lighting
        ["cruise"] = {
            enabled = {
                on = {6},
                off = {}
            },
            disabled = {
                on = {},
                off = {6}
            },
        }, -- Cruise lighting
    },
    ["f550amboc"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {4, 6}
            },
            disabled = {
                on = {6},
                off = {}
            },
        }, -- Full Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {3},
                off = {}
            },
            disabled = {
                on = {},
                off = {3}
            },
        }, -- Rear Flood Light
        ["parkpattern"] = {
            enabled = {
                on = {4},
                off = {6}
            },
            disabled = {
                on = {6},
                off = {4}
            },
        }, -- Park Pattern Lighting
        ["cruise"] = {
            enabled = {
                on = {5},
                off = {}
            },
            disabled = {
                on = {},
                off = {5}
            },
        }, -- Cruise lighting
        ["leftFlood"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Left Flood Lighting
        ["rightFlood"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Right Flood Lighting  
    },
    ["f550ambocs"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {4, 6}
            },
            disabled = {
                on = {6},
                off = {}
            },
        }, -- Full Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {3},
                off = {}
            },
            disabled = {
                on = {},
                off = {3}
            },
        }, -- Rear Flood Light
        ["parkpattern"] = {
            enabled = {
                on = {4},
                off = {6}
            },
            disabled = {
                on = {6},
                off = {4}
            },
        }, -- Park Pattern Lighting
        ["cruise"] = {
            enabled = {
                on = {5},
                off = {}
            },
            disabled = {
                on = {},
                off = {5}
            },
        }, -- Cruise lighting
        ["leftFlood"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Left Flood Lighting
        ["rightFlood"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Right Flood Lighting  
    },
    ["f550amboc2"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {4, 6}
            },
            disabled = {
                on = {6},
                off = {}
            },
        }, -- Full Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {3},
                off = {}
            },
            disabled = {
                on = {},
                off = {3}
            },
        }, -- Rear Flood Light
        ["parkpattern"] = {
            enabled = {
                on = {4},
                off = {6}
            },
            disabled = {
                on = {6},
                off = {4}
            },
        }, -- Park Pattern Lighting
        ["cruise"] = {
            enabled = {
                on = {5},
                off = {}
            },
            disabled = {
                on = {},
                off = {5}
            },
        }, -- Cruise lighting
        ["leftFlood"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Left Flood Lighting
        ["rightFlood"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Right Flood Lighting  
    },
    ["f550amboc2s"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {4, 6}
            },
            disabled = {
                on = {6},
                off = {}
            },
        }, -- Full Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {3},
                off = {}
            },
            disabled = {
                on = {},
                off = {3}
            },
        }, -- Rear Flood Light
        ["parkpattern"] = {
            enabled = {
                on = {4},
                off = {6}
            },
            disabled = {
                on = {6},
                off = {4}
            },
        }, -- Park Pattern Lighting
        ["cruise"] = {
            enabled = {
                on = {5},
                off = {}
            },
            disabled = {
                on = {},
                off = {5}
            },
        }, -- Cruise lighting
        ["leftFlood"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Left Flood Lighting
        ["rightFlood"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Right Flood Lighting  
    },
    ["f550ambow"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {4, 6}
            },
            disabled = {
                on = {6},
                off = {}
            },
        }, -- Full Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {3},
                off = {}
            },
            disabled = {
                on = {},
                off = {3}
            },
        }, -- Rear Flood Light
        ["parkpattern"] = {
            enabled = {
                on = {4},
                off = {6}
            },
            disabled = {
                on = {6},
                off = {4}
            },
        }, -- Park Pattern Lighting
        ["cruise"] = {
            enabled = {
                on = {5},
                off = {}
            },
            disabled = {
                on = {},
                off = {5}
            },
        }, -- Cruise lighting
        ["leftFlood"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Left Flood Lighting
        ["rightFlood"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Right Flood Lighting
    },
    ["f550ambows"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {4, 6}
            },
            disabled = {
                on = {6},
                off = {}
            },
        }, -- Full Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {3},
                off = {}
            },
            disabled = {
                on = {},
                off = {3}
            },
        }, -- Rear Flood Light
        ["parkpattern"] = {
            enabled = {
                on = {4},
                off = {6}
            },
            disabled = {
                on = {6},
                off = {4}
            },
        }, -- Park Pattern Lighting
        ["cruise"] = {
            enabled = {
                on = {5},
                off = {}
            },
            disabled = {
                on = {},
                off = {5}
            },
        }, -- Cruise lighting
        ["leftFlood"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Left Flood Lighting
        ["rightFlood"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Right Flood Lighting
    },
    ["lcsotransp1"] = {
        ["parkpattern"] = {
            enabled = {
                on = {1},
                off = {2, 3}
            },
            disabled = {
                on = {2, 3},
                off = {1}
            },
        }, -- Park Pattern Lighting
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {2, 3}
            },
            disabled = {
                on = {2, 3},
                off = {}
            },
        }, -- Full Light Kill        
        ["frontLightKill"] = {
            enabled = {
                on = {},
                off = {2}
            },
            disabled = {
                on = {2},
                off = {}
            },
        }, -- Front Light Kill
        ["cruise"] = {
            enabled = {
                on = {6},
                off = {}
            },
            disabled = {
                on = {},
                off = {6}
            },
        }, -- Cruise lighting
        ["cornercruise"] = {
            enabled = {
                on = {5},
                off = {}
            },
            disabled = {
                on = {},
                off = {5}
            },
        }, -- Corner Cruise lighting
        ["tac"] = {
            enabled = {
                on = {4},
                off = {}
            },
            disabled = {
                on = {},
                off = {4}
            },
        }, -- Traffic Advisor Center
    },
    ["bcsotransp1"] = {
        ["parkpattern"] = {
            enabled = {
                on = {1},
                off = {2, 3}
            },
            disabled = {
                on = {2, 3},
                off = {1}
            },
        }, -- Park Pattern Lighting
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {2, 3}
            },
            disabled = {
                on = {2, 3},
                off = {}
            },
        }, -- Full Light Kill        
        ["frontLightKill"] = {
            enabled = {
                on = {},
                off = {2}
            },
            disabled = {
                on = {2},
                off = {}
            },
        }, -- Front Light Kill
        ["cruise"] = {
            enabled = {
                on = {6},
                off = {}
            },
            disabled = {
                on = {},
                off = {6}
            },
        }, -- Cruise lighting
        ["cornercruise"] = {
            enabled = {
                on = {5},
                off = {}
            },
            disabled = {
                on = {},
                off = {5}
            },
        }, -- Corner Cruise lighting
        ["tac"] = {
            enabled = {
                on = {4},
                off = {}
            },
            disabled = {
                on = {},
                off = {4}
            },
        }, -- Traffic Advisor Center
    },
    ["lcso4"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {2, 3, 4, 6, 7}
            },
            disabled = {
                on = {2, 3, 4, 6, 7},
                off = {}
            },
        }, -- Full Light Kill
        ["frontLightKill"] = {
            enabled = {
                on = {},
                off = {2, 6}
            },
            disabled = {
                on = {2, 6},
                off = {}
            },
        }, -- Front Light Kill
        ["cruise"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Cruise lighting
        ["frontFlood"] = {
            enabled = {
                on = {5},
                off = {6}
            },
            disabled = {
                on = {6},
                off = {5}
            },
        }, -- Take Down (Font Flood)
    },
    ["lcso3"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {2, 3, 4, 5, 7}
            },
            disabled = {
                on = {2, 3, 4, 5, 7},
                off = {}
            },
        }, -- Full Light Kill
        ["frontLightKill"] = {
            enabled = {
                on = {},
                off = {2}
            },
            disabled = {
                on = {2},
                off = {}
            },
        }, -- Front Light Kill
        ["cruise"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Cruise lighting
        ["tac"] = {
            enabled = {
                on = {6},
                off = {7}
            },
            disabled = {
                on = {7},
                off = {6}
            },
        }, -- Traffic Advisor Center
    },
    ["lcso2"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {5, 9, 10, 11, 12}
            },
            disabled = {
                on = {5, 9, 10, 11, 12},
                off = {}
            },
        }, -- Full Light Kill
        ["cruise"] = {
            enabled = {
                on = {8},
                off = {}
            },
            disabled = {
                on = {},
                off = {8}
            },
        }, -- Cruise lighting
        ["cornercruise"] = {
            enabled = {
                on = {7},
                off = {}
            },
            disabled = {
                on = {},
                off = {7}
            },
        }, -- Corner Cruise lighting
        ["tac"] = {
            enabled = {
                on = {6},
                off = {}
            },
            disabled = {
                on = {},
                off = {6}
            },
        }, -- Traffic Advisor Center
        ["parkpattern"] = {
            enabled = {
                on = {1, 2, 3, 4},
                off = {5, 9, 10, 11, 12}
            },
            disabled = {
                on = {5, 9, 10, 11, 12},
                off = {1, 2, 3, 4}
            },
        }, -- Park Pattern Lighting
    },
    ["bcso4"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {7, 8, 9, 5, 6}
            },
            disabled = {
                on = {7, 8, 9, 5, 6},
                off = {}
            },
        }, -- Full Light Kill        
        ["frontLightKill"] = {
            enabled = {
                on = {},
                off = {5}
            },
            disabled = {
                on = {5},
                off = {}
            },
        }, -- Front Light Kill
        ["rearLightKill"] = {
            enabled = {
                on = {},
                off = {6}
            },
            disabled = {
                on = {6},
                off = {}
            },
        }, -- Rear Light Kill
        ["cruise"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Cruise lighting
        ["tac"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Traffic Advisor Center
        ["tal"] = {
            enabled = {
                on = {3},
                off = {}
            },
            disabled = {
                on = {},
                off = {3}
            },
        }, -- Traffic Advisor Right
        ["tar"] = {
            enabled = {
                on = {4},
                off = {}
            },
            disabled = {
                on = {},
                off = {4}
            },
        }, -- Traffic Advisor Left
    },
    ["bcso3"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {5, 4, 3, 6}
            },
            disabled = {
                on = {5, 4, 3, 6},
                off = {}
            },
        }, -- Full Light Kill        
        ["frontLightKill"] = {
            enabled = {
                on = {},
                off = {5}
            },
            disabled = {
                on = {5},
                off = {}
            },
        }, -- Front Light Kill
        ["rearLightKill"] = {
            enabled = {
                on = {},
                off = {4, 3}
            },
            disabled = {
                on = {4, 3},
                off = {}
            },
        }, -- Rear Light Kill
        ["cruise"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Cruise lighting
        ["tac"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Traffic Advisor Center
    },
    ["bcso2"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {5, 4, 3, 6}
            },
            disabled = {
                on = {5, 4, 3, 6},
                off = {}
            },
        }, -- Full Light Kill        
        ["frontLightKill"] = {
            enabled = {
                on = {},
                off = {5}
            },
            disabled = {
                on = {5},
                off = {}
            },
        }, -- Front Light Kill
        ["rearLightKill"] = {
            enabled = {
                on = {},
                off = {4, 3}
            },
            disabled = {
                on = {4, 3},
                off = {}
            },
        }, -- Rear Light Kill
        ["cruise"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Cruise lighting
        ["tac"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Traffic Advisor Center
    },
    ["bcso1"] = {
        ["parkpattern"] = {
            enabled = {
                on = {1, 2},
                off = {3, 5, 6, 7, 11}
            },
            disabled = {
                on = {3, 5, 6, 7, 11},
                off = {1, 2}
            },
        }, -- Park Pattern Lighting
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {3, 5, 6, 7, 11}
            },
            disabled = {
                on = {3, 5, 6, 7, 11},
                off = {}
            },
        }, -- Full Light Kill        
        ["frontLightKill"] = {
            enabled = {
                on = {},
                off = {3}
            },
            disabled = {
                on = {3},
                off = {}
            },
        }, -- Front Light Kill
        ["cruise"] = {
            enabled = {
                on = {8, 9, 10},
                off = {}
            },
            disabled = {
                on = {},
                off = {8, 9, 10}
            },
        }, -- Cruise lighting
        ["tac"] = {
            enabled = {
                on = {4},
                off = {11}
            },
            disabled = {
                on = {11},
                off = {4}
            },
        }, -- Traffic Advisor Center
    },
    ["lcso1"] = {
        ["parkpattern"] = {
            enabled = {
                on = {1, 2},
                off = {3, 5, 6, 7, 11}
            },
            disabled = {
                on = {3, 5, 6, 7, 11},
                off = {1, 2}
            },
        }, -- Park Pattern Lighting
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {3, 5, 6, 7, 11}
            },
            disabled = {
                on = {3, 5, 6, 7, 11},
                off = {}
            },
        }, -- Full Light Kill        
        ["frontLightKill"] = {
            enabled = {
                on = {},
                off = {3}
            },
            disabled = {
                on = {3},
                off = {}
            },
        }, -- Front Light Kill
        ["cruise"] = {
            enabled = {
                on = {8, 9, 10},
                off = {}
            },
            disabled = {
                on = {},
                off = {8, 9, 10}
            },
        }, -- Cruise lighting
        ["tac"] = {
            enabled = {
                on = {4},
                off = {11}
            },
            disabled = {
                on = {11},
                off = {4}
            },
        }, -- Traffic Advisor Center
    },
    ["22f550skeeters"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {1, 2, 3, 4, 5}
            },
            disabled = {
                on = {3, 4, 5},
                off = {}
            },
        }, -- Full Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {8},
                off = {}
            },
            disabled = {
                on = {},
                off = {8}
            },
        }, -- Rear Flood Light
        ["parkpattern"] = {
            enabled = {
                on = {1},
                off = {3, 4, 5}
            },
            disabled = {
                on = {3, 4, 5},
                off = {1}
            },
        }, -- Park Pattern Lighting
        ["cruise"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Cruise lighting
        ["leftFlood"] = {
            enabled = {
                on = {6},
                off = {}
            },
            disabled = {
                on = {},
                off = {6}
            },
        }, -- Left Flood Lighting
        ["rightFlood"] = {
            enabled = {
                on = {7},
                off = {}
            },
            disabled = {
                on = {},
                off = {7}
            },
        }, -- Right Flood Lighting
    },
    ["22f550skeeters2"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {1, 2, 3, 4, 5}
            },
            disabled = {
                on = {3, 4, 5},
                off = {}
            },
        }, -- Full Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {8},
                off = {}
            },
            disabled = {
                on = {},
                off = {8}
            },
        }, -- Rear Flood Light
        ["parkpattern"] = {
            enabled = {
                on = {1},
                off = {3, 4, 5}
            },
            disabled = {
                on = {3, 4, 5},
                off = {1}
            },
        }, -- Park Pattern Lighting
        ["cruise"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Cruise lighting
        ["leftFlood"] = {
            enabled = {
                on = {6},
                off = {}
            },
            disabled = {
                on = {},
                off = {6}
            },
        }, -- Left Flood Lighting
        ["rightFlood"] = {
            enabled = {
                on = {7},
                off = {}
            },
            disabled = {
                on = {},
                off = {7}
            },
        }, -- Right Flood Lighting
    },
    ["22f550skeeters6x6"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {1, 2, 3, 4, 5}
            },
            disabled = {
                on = {3, 4, 5},
                off = {}
            },
        }, -- Full Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {8},
                off = {}
            },
            disabled = {
                on = {},
                off = {8}
            },
        }, -- Rear Flood Light
        ["parkpattern"] = {
            enabled = {
                on = {1},
                off = {3, 4, 5}
            },
            disabled = {
                on = {3, 4, 5},
                off = {1}
            },
        }, -- Park Pattern Lighting
        ["cruise"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Cruise lighting
        ["leftFlood"] = {
            enabled = {
                on = {6},
                off = {}
            },
            disabled = {
                on = {},
                off = {6}
            },
        }, -- Left Flood Lighting
        ["rightFlood"] = {
            enabled = {
                on = {7},
                off = {}
            },
            disabled = {
                on = {},
                off = {7}
            },
        }, -- Right Flood Lighting
    },
    ["22f550skeeters26x6"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {1, 2, 3, 4, 5}
            },
            disabled = {
                on = {3, 4, 5},
                off = {}
            },
        }, -- Full Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {8},
                off = {}
            },
            disabled = {
                on = {},
                off = {8}
            },
        }, -- Rear Flood Light
        ["parkpattern"] = {
            enabled = {
                on = {1},
                off = {3, 4, 5}
            },
            disabled = {
                on = {3, 4, 5},
                off = {1}
            },
        }, -- Park Pattern Lighting
        ["cruise"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Cruise lighting
        ["leftFlood"] = {
            enabled = {
                on = {6},
                off = {}
            },
            disabled = {
                on = {},
                off = {6}
            },
        }, -- Left Flood Lighting
        ["rightFlood"] = {
            enabled = {
                on = {7},
                off = {}
            },
            disabled = {
                on = {},
                off = {7}
            },
        }, -- Right Flood Lighting
    },
    ["22f550skeeterc6x6"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {1, 2, 3, 4, 5}
            },
            disabled = {
                on = {3, 4, 5},
                off = {}
            },
        }, -- Full Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {8},
                off = {}
            },
            disabled = {
                on = {},
                off = {8}
            },
        }, -- Rear Flood Light
        ["parkpattern"] = {
            enabled = {
                on = {1},
                off = {3, 4, 5}
            },
            disabled = {
                on = {3, 4, 5},
                off = {1}
            },
        }, -- Park Pattern Lighting
        ["cruise"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Cruise lighting
        ["leftFlood"] = {
            enabled = {
                on = {6},
                off = {}
            },
            disabled = {
                on = {},
                off = {6}
            },
        }, -- Left Flood Lighting
        ["rightFlood"] = {
            enabled = {
                on = {7},
                off = {}
            },
            disabled = {
                on = {},
                off = {7}
            },
        }, -- Right Flood Lighting
    },
    ["22f550skeeterc26x6"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {1, 2, 3, 4, 5}
            },
            disabled = {
                on = {3, 4, 5},
                off = {}
            },
        }, -- Full Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {8},
                off = {}
            },
            disabled = {
                on = {},
                off = {8}
            },
        }, -- Rear Flood Light
        ["parkpattern"] = {
            enabled = {
                on = {1},
                off = {3, 4, 5}
            },
            disabled = {
                on = {3, 4, 5},
                off = {1}
            },
        }, -- Park Pattern Lighting
        ["cruise"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Cruise lighting
        ["leftFlood"] = {
            enabled = {
                on = {6},
                off = {}
            },
            disabled = {
                on = {},
                off = {6}
            },
        }, -- Left Flood Lighting
        ["rightFlood"] = {
            enabled = {
                on = {7},
                off = {}
            },
            disabled = {
                on = {},
                off = {7}
            },
        }, -- Right Flood Lighting
    },
    ["sasp4k9"] = {
        ["leftFlood"] = {
            enabled = {
                on = {12},
                off = {}
            },
            disabled = {
                on = {},
                off = {12}
            },
        }, -- Left Alley Lighting
        ["rightFlood"] = {
            enabled = {
                on = {11},
                off = {}
            },
            disabled = {
                on = {},
                off = {11}
            },
        }, -- Right Alley Lighting
        ["wigwags"] = {
            enabled = {
                on = {7},
                off = {}
            },
            disabled = {
                on = {},
                off = {7}
            },
        }, -- Wig Wags Lighting
    },
    ["sasp4"] = {
        ["leftFlood"] = {
            enabled = {
                on = {12},
                off = {}
            },
            disabled = {
                on = {},
                off = {12}
            },
        }, -- Left Alley Lighting
        ["rightFlood"] = {
            enabled = {
                on = {11},
                off = {}
            },
            disabled = {
                on = {},
                off = {11}
            },
        }, -- Right Alley Lighting
        ["wigwags"] = {
            enabled = {
                on = {7},
                off = {}
            },
            disabled = {
                on = {},
                off = {7}
            },
        }, -- Wig Wags Lighting
    },
    ["sasp3k9"] = {
        ["leftFlood"] = {
            enabled = {
                on = {12},
                off = {}
            },
            disabled = {
                on = {},
                off = {12}
            },
        }, -- Left Alley Lighting
        ["rightFlood"] = {
            enabled = {
                on = {11},
                off = {}
            },
            disabled = {
                on = {},
                off = {11}
            },
        }, -- Right Alley Lighting
        ["wigwags"] = {
            enabled = {
                on = {7},
                off = {}
            },
            disabled = {
                on = {},
                off = {7}
            },
        }, -- Wig Wags Lighting
    },
    ["sasp3"] = {
        ["leftFlood"] = {
            enabled = {
                on = {12},
                off = {}
            },
            disabled = {
                on = {},
                off = {12}
            },
        }, -- Left Alley Lighting
        ["rightFlood"] = {
            enabled = {
                on = {11},
                off = {}
            },
            disabled = {
                on = {},
                off = {11}
            },
        }, -- Right Alley Lighting
        ["wigwags"] = {
            enabled = {
                on = {7},
                off = {}
            },
            disabled = {
                on = {},
                off = {7}
            },
        }, -- Wig Wags Lighting
    },
    ["sasp2k9"] = {
        ["leftFlood"] = {
            enabled = {
                on = {12},
                off = {}
            },
            disabled = {
                on = {},
                off = {12}
            },
        }, -- Left Alley Lighting
        ["rightFlood"] = {
            enabled = {
                on = {11},
                off = {}
            },
            disabled = {
                on = {},
                off = {11}
            },
        }, -- Right Alley Lighting
        ["wigwags"] = {
            enabled = {
                on = {7},
                off = {}
            },
            disabled = {
                on = {},
                off = {7}
            },
        }, -- Wig Wags Lighting
    },
    ["sasp2"] = {
        ["leftFlood"] = {
            enabled = {
                on = {12},
                off = {}
            },
            disabled = {
                on = {},
                off = {12}
            },
        }, -- Left Alley Lighting
        ["rightFlood"] = {
            enabled = {
                on = {11},
                off = {}
            },
            disabled = {
                on = {},
                off = {11}
            },
        }, -- Right Alley Lighting
        ["wigwags"] = {
            enabled = {
                on = {7},
                off = {}
            },
            disabled = {
                on = {},
                off = {7}
            },
        }, -- Wig Wags Lighting
    },
    ["sasp5"] = {
        ["leftFlood"] = {
            enabled = {
                on = {12},
                off = {}
            },
            disabled = {
                on = {},
                off = {12}
            },
        }, -- Left Alley Lighting
        ["rightFlood"] = {
            enabled = {
                on = {11},
                off = {}
            },
            disabled = {
                on = {},
                off = {11}
            },
        }, -- Right Alley Lighting
    },
    ["sasp6"] = {
        ["leftFlood"] = {
            enabled = {
                on = {12},
                off = {}
            },
            disabled = {
                on = {},
                off = {12}
            },
        }, -- Left Alley Lighting
        ["rightFlood"] = {
            enabled = {
                on = {11},
                off = {}
            },
            disabled = {
                on = {},
                off = {11}
            },
        }, -- Right Alley Lighting
    },
    ["sasp7"] = {
        ["leftFlood"] = {
            enabled = {
                on = {12},
                off = {}
            },
            disabled = {
                on = {},
                off = {12}
            },
        }, -- Left Alley Lighting
        ["rightFlood"] = {
            enabled = {
                on = {11},
                off = {}
            },
            disabled = {
                on = {},
                off = {11}
            },
        }, -- Right Alley Lighting
    },
    ["sasp8"] = {
        ["leftFlood"] = {
            enabled = {
                on = {12},
                off = {}
            },
            disabled = {
                on = {},
                off = {12}
            },
        }, -- Left Alley Lighting
        ["rightFlood"] = {
            enabled = {
                on = {11},
                off = {}
            },
            disabled = {
                on = {},
                off = {11}
            },
        }, -- Right Alley Lighting
    },
    ["sasp9"] = {
        ["leftFlood"] = {
            enabled = {
                on = {12},
                off = {}
            },
            disabled = {
                on = {},
                off = {12}
            },
        }, -- Left Alley Lighting
        ["rightFlood"] = {
            enabled = {
                on = {11},
                off = {}
            },
            disabled = {
                on = {},
                off = {11}
            },
        }, -- Right Alley Lighting
    },
    ["sasp1"] = {
        ["leftFlood"] = {
            enabled = {
                on = {12},
                off = {}
            },
            disabled = {
                on = {},
                off = {12}
            },
        }, -- Left Alley Lighting
        ["rightFlood"] = {
            enabled = {
                on = {11},
                off = {}
            },
            disabled = {
                on = {},
                off = {11}
            },
        }, -- Right Alley Lighting
    },
    ["18chargerslr"] = {
        ["frontFlood"] = {
            enabled = {
                on = {4,5},
                off = {}
            },
            disabled = {
                on = {},
                off = {4,5}
            },
        }, -- Front Flood Lighting
        ["tac"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Traffic Advisor Center
        ["leftFlood"] = {
            enabled = {
                on = {3},
                off = {}
            },
            disabled = {
                on = {},
                off = {3}
            },
        }, -- Left Flood Lighting
        ["rightFlood"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Right Flood Lighting
    },
    ["arrowc"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {4, 5}
            },
            disabled = {
                on = {4, 5},
                off = {}
            },
        }, -- Full Light Kill
        ["frontLightKill"] = {
            enabled = {
                on = {},
                off = {4}
            },
            disabled = {
                on = {4},
                off = {}
            },
        }, -- Front Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {3},
                off = {}
            },
            disabled = {
                on = {},
                off = {3}
            },
        }, -- Rear Flood Light
        ["leftFlood"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Left Flood Lighting
        ["rightFlood"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Right Flood Lighting
        ["cruise"] = {
            enabled = {
                on = {6},
                off = {}
            },
            disabled = {
                on = {},
                off = {6}
            },
        }, -- Cruise lighting
    },
    ["arrowb"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {4, 5}
            },
            disabled = {
                on = {4, 5},
                off = {}
            },
        }, -- Full Light Kill
        ["frontLightKill"] = {
            enabled = {
                on = {},
                off = {4}
            },
            disabled = {
                on = {4},
                off = {}
            },
        }, -- Front Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {3},
                off = {}
            },
            disabled = {
                on = {},
                off = {3}
            },
        }, -- Rear Flood Light
        ["leftFlood"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Left Flood Lighting
        ["rightFlood"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Right Flood Lighting
        ["cruise"] = {
            enabled = {
                on = {6},
                off = {}
            },
            disabled = {
                on = {},
                off = {6}
            },
        }, -- Cruise lighting
    },
    ["arrowp"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {4, 5}
            },
            disabled = {
                on = {4, 5},
                off = {}
            },
        }, -- Full Light Kill
        ["frontLightKill"] = {
            enabled = {
                on = {},
                off = {4}
            },
            disabled = {
                on = {4},
                off = {}
            },
        }, -- Front Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {3},
                off = {}
            },
            disabled = {
                on = {},
                off = {3}
            },
        }, -- Rear Flood Light
        ["leftFlood"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Left Flood Lighting
        ["rightFlood"] = {
            enabled = {
                on = {2},
                off = {}
            },
            disabled = {
                on = {},
                off = {2}
            },
        }, -- Right Flood Lighting
        ["cruise"] = {
            enabled = {
                on = {6},
                off = {}
            },
            disabled = {
                on = {},
                off = {6}
            },
        }, -- Cruise lighting
    },
    ["f250gw"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {2, 3, 4, 5, 6, 7, 8}
            },
            disabled = {
                on = {2, 3, 4, 5},
                off = {}
            },
        }, -- Full Light Kill
        ["frontLightKill"] = {
            enabled = {
                on = {2, 3, 5},
                off = {4}
            },
            disabled = {
                on = {2, 3, 4, 5},
                off = {}
            },
        }, -- Front Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {10},
                off = {}
            },
            disabled = {
                on = {},
                off = {10}
            },
        }, -- Rear Flood Light
        ["frontFlood"] = {
            enabled = {
                on = {9},
                off = {}
            },
            disabled = {
                on = {},
                off = {9}
            },
        }, -- Front Flood Lighting
        ["tac"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Traffic Advisor Center
        ["parkpattern"] = {
            enabled = {
                on = {6, 7, 8},
                off = {2, 3, 4, 5}
            },
            disabled = {
                on = {2, 3, 4, 5},
                off = {6, 7, 8}
            },
        }, -- Park Pattern Lighting
        ["cruise"] = {
            enabled = {
                on = {11, 12},
                off = {}
            },
            disabled = {
                on = {},
                off = {11, 12}
            },
        }, -- Cruise lighting
    },
    ["f250gwk9"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {2, 3, 4, 5, 6, 7, 8}
            },
            disabled = {
                on = {2, 3, 4, 5},
                off = {}
            },
        }, -- Full Light Kill
        ["frontLightKill"] = {
            enabled = {
                on = {2, 3, 5},
                off = {4}
            },
            disabled = {
                on = {2, 3, 4, 5},
                off = {}
            },
        }, -- Front Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {10},
                off = {}
            },
            disabled = {
                on = {},
                off = {10}
            },
        }, -- Rear Flood Light
        ["frontFlood"] = {
            enabled = {
                on = {9},
                off = {}
            },
            disabled = {
                on = {},
                off = {9}
            },
        }, -- Front Flood Lighting
        ["tac"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Traffic Advisor Center
        ["parkpattern"] = {
            enabled = {
                on = {6, 7, 8},
                off = {2, 3, 4, 5}
            },
            disabled = {
                on = {2, 3, 4, 5},
                off = {6, 7, 8}
            },
        }, -- Park Pattern Lighting
        ["cruise"] = {
            enabled = {
                on = {11, 12},
                off = {}
            },
            disabled = {
                on = {},
                off = {11, 12}
            },
        }, -- Cruise lighting
    },
    ["f150gw"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {2, 3, 4, 5, 6, 7, 8}
            },
            disabled = {
                on = {2, 3, 4, 5},
                off = {}
            },
        }, -- Full Light Kill
        ["frontLightKill"] = {
            enabled = {
                on = {2, 3, 5},
                off = {4}
            },
            disabled = {
                on = {2, 3, 4, 5},
                off = {}
            },
        }, -- Front Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {10},
                off = {}
            },
            disabled = {
                on = {},
                off = {10}
            },
        }, -- Rear Flood Light
        ["frontFlood"] = {
            enabled = {
                on = {9},
                off = {}
            },
            disabled = {
                on = {},
                off = {9}
            },
        }, -- Front Flood Lighting
        ["tac"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Traffic Advisor Center
        ["parkpattern"] = {
            enabled = {
                on = {6, 7, 8},
                off = {2, 3, 4, 5}
            },
            disabled = {
                on = {2, 3, 4, 5},
                off = {6, 7, 8}
            },
        }, -- Park Pattern Lighting
        ["cruise"] = {
            enabled = {
                on = {11, 12},
                off = {}
            },
            disabled = {
                on = {},
                off = {11, 12}
            },
        }, -- Cruise lighting
    },
    ["f150gwk9"] = {
        ["fullLightKill"] = {
            enabled = {
                on = {},
                off = {2, 3, 4, 5, 6, 7, 8}
            },
            disabled = {
                on = {2, 3, 4, 5},
                off = {}
            },
        }, -- Full Light Kill
        ["frontLightKill"] = {
            enabled = {
                on = {2, 3, 5},
                off = {4}
            },
            disabled = {
                on = {2, 3, 4, 5},
                off = {}
            },
        }, -- Front Light Kill
        ["rearFlood"] = {
            enabled = {
                on = {10},
                off = {}
            },
            disabled = {
                on = {},
                off = {10}
            },
        }, -- Rear Flood Light
        ["frontFlood"] = {
            enabled = {
                on = {9},
                off = {}
            },
            disabled = {
                on = {},
                off = {9}
            },
        }, -- Front Flood Lighting
        ["tac"] = {
            enabled = {
                on = {1},
                off = {}
            },
            disabled = {
                on = {},
                off = {1}
            },
        }, -- Traffic Advisor Center
        ["parkpattern"] = {
            enabled = {
                on = {6, 7, 8},
                off = {2, 3, 4, 5}
            },
            disabled = {
                on = {2, 3, 4, 5},
                off = {6, 7, 8}
            },
        }, -- Park Pattern Lighting
        ["cruise"] = {
            enabled = {
                on = {11, 12},
                off = {}
            },
            disabled = {
                on = {},
                off = {11, 12}
            },
        }, -- Cruise lighting
    }
}

Config.sounds = {
    ["sasp1"] = "cencom",
    ["sasp3"] = "cencom",
    ["sasp2"] = "cencom",
    ["sasp5"] = "cencom",
    ["sasp6"] = "cencom",
    ["sasp7"] = "cencom",
    ["sasp8"] = "cencom",
    ["sasp9"] = "cencom",
    ["sasp2k9"] = "cencom",
    ["sasp3k9"] = "cencom",
    ["sasp4"] = "cencom",
    ["sasp4k9"] = "cencom",
    ["bcso3"] = "zthree",
    ["bcso2"] = "zthree",
    ["bcso4"] = "zthree",
    ["lcso2"] = "matrix",
    ["f550amboc"] = "matrix",
    ["f550ambocs"] = "matrix",
    ["f550amboc2"] = "matrix",
    ["f550amboc2s"] = "matrix",
}

Config.general = {
    dbPrefix = 'rnl', -- The custom key for saving UI data. (Changing will cause all data to default.)
    command_names = {
        showUI = 'showUI', -- The command to manually hide or display the UI.
        resetUI = 'resetUI', -- The command that resets the UI's position/scale back to default.
        adjust_position = 'moveUI', -- The command to move the UI on your screen.
        reset_position = 'resetUIPosition', -- The command that rests the UI's position.
        reset_scale = 'resetUIScale', -- The command that resets the UI's scale.
        adjust_scale = 'scaleUI' -- The command to scale the UI.
    },
    auto_park_pattern = true, -- Enable the park pattern automatically when vehicle enters "park" (Experimental)
    parkPatternSync = true, -- Enable the syncing of park patterns with other vehicles around you
    parkPatternSyncCooldown = 5, -- How long to wait between park pattern syncs (SECONDS)
    parkPatternSyncDistance = 30, -- How far away should vehicles sync park patterns?
    noTAC = {
        -- Doesn't have a Traffic Advisor Center
        "arrowp", "arrowc", "arrowb", 'f550amboc', "f550ambocs",  "sasp1", "sasp2", "sasp2k9", "sasp3", "sasp3k9", "sasp4", "sasp4k9", "22f550skeeters", "22f550skeeters2", "22f550skeeterc", "22f550skeeterc2", "22f550skeeterc6x6", "22f550skeeterc26x6", "22f550skeeters6x6", "22f550skeeters26x6", "lcso4", "f550ambow", "f550ambow2", "1500", "challengers"
    },
    noPP = {
        -- Doesn't have a Park Pattern
        "arrowp", "arrowc", "arrowb", "18chargerslr", "sasp1", "sasp2", "sasp2k9", "sasp3", "sasp3k9", "sasp4", "sasp4k9", "lcso3", "lcso4", "bcso2", "bcso3", "bcso4"
    },
    hasDoorKill = {
        -- Has Doorkill
        "bcso1", "lcso3", "lcso1", "lcso2", "sasp1", "sasp2", "sasp2k9", "sasp3", "sasp3k9", "sasp4", "sasp4k9", "sasp5", "sasp6", "sasp7", "sasp8", "sasp9", "f150gw", "f250gw", "1500"
    },
    noRepair = {
        -- Vehicle that do NOT need to be auto repaired (Extras do NOT have collisions)
        'challengers', "f550ambow", "f550ambows", "f550ambocs",  'f550amboc', 'f550amboc2', 'f550amboc2s', 'bcsotransp1', 'lcsotransp1', 'lcso4', 'lcso3', 'lcso1', 'bcso1', '1500', 'sasp1', 'sasp6', 'bcso3', 'bcso2', 'bcso4', 'lcso2'
    }
}