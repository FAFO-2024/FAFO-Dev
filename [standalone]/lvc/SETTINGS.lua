--------------------COMMUNITY ID-------------------
community_id = 'daT2in'
--	Sets a prefix for saved values at the user end, without this people who play on multiple LVC server could face conflicts. **Once set DO NOT CHANGE. It will result in loss of data for end users.**
--		I recommend something short (4-6 characters) for example a community abbreviation. SPACES ARE NOT ALLOWED.

------------------MENU KEYBINDING------------------
open_menu_key = 'O'
--	Sets default key for RegisterKeyMapping. Examples: 'l','F5', etc. DEFAULT: 'O', users may set one in their GTA V > Settings > Hotkeys > FiveM settings. 
--		More info: https://cookbook.fivem.net/2020/01/06/using-the-new-console-key-bindings/
--		List of Keys: https://pastebin.com/u9ewvWWZ


---------------LOCKOUT FUNCTIONALITY---------------
lockout_default_hotkey = ''
--	Sets default key for RegisterKeyMapping. Examples: 'l','F5', etc. DEFAULT: NONE, users may set one in their GTA V > Settings > Hotkeys > FiveM settings. 
--		More info: https://cookbook.fivem.net/2020/01/06/using-the-new-console-key-bindings/
--		List of Keys: https://pastebin.com/u9ewvWWZ
locked_press_count = 5    
--	Initial press count for reminder e.g. if this is 5 and reminder_rate is 10 then, after 5 key presses it will remind you the first time, after that every 10 key presses. 
reminder_rate = 10
--	How often, in luxart key presses, to remind you that your siren controller is locked.

-----------------HUD FUNCTIONALITY-----------------
hud_first_default = false
--	First state of HUD, otherwise it uses the players KVP setting (previous state). 

---------------MAIN SIREN SETTINGS-----------------
main_siren_settings_masterswitch = true
--	Enables users to rename siren tones, change siren options. (Cycle / Button) 
park_kill_masterswitch = true
--	Enables park kill functionality. Setting this to false will not allow users to change from default behaviour this. 
park_kill_default = false
--	Default setting for park kill mode. (default: true)
airhorn_interrupt_masterswitch = true
--	Enables ability to toggle air horn interrupt. Setting this to false will not allow users to change from default behaviour this. 
airhorn_interrupt_default = true
--	Default setting of the airhorn interrupt for the main siren. (default: true) 
reset_to_standby_masterswitch = true
--	Enables ability to toggle reset to standby. Setting this to false will not allow users to change from default behaviour this. 
reset_to_standby_default = true
--	Default setting for Reset-To-Standby functionality. (default: true)

--------------CUSTOM MANU/HORN/SIREN---------------
custom_manual_tones_master_switch = true
--	Enables manual tone settings menu items to change which tone is played for the primary and secondary manual tones.
custom_aux_tones_master_switch = true
--	Enables auxiliary tone settings menu item so players can change which tone is played when AUX siren (Up-Arrow) is enabled. 
main_siren_set_register_keys_set_defaults = true
--	Enables RegisterKeyMapping for all main_allowed_tones and sets the default keys to numrow 1-0.


--------------TURN SIGNALS / HAZARDS---------------
hazard_key = 202	
left_signal_key = 84
right_signal_key = 83
hazard_hold_duration = 750
--	Time in milliseconds backspace must be pressed to turn on / off hazard lights. 


----------------SOUND EFFECT VOLUMES---------------
button_sfx_scheme_choices = { 'SSP2000', 'SSP3000', 'Cencom', 'ST300' }
--Customize which button SFX schemes are available. An item here must match exactly the folder name located in `lvc\UI\sounds`, recommend NOT using spaces instead use a dash (e.g. Cencom-Gold)
default_sfx_scheme_name = 'SSP2000'
default_on_volume = 0.5			
default_off_volume = 0.7			
default_upgrade_volume = 0.5		
default_downgrade_volume = 0.7
default_hazards_volume = 0.09
default_lock_volume = 0.25
default_lock_reminder_volume = 0.2
default_reminder_volume = 0.09


------------------PLUG-IN SUPPORT------------------
plugins_installed = false


------------------CUSTOM SETTINGS FROM BUB------------------
-- The spawncode of the car codes into the [''], then the extras for each stage in their respective slot.
-- Example:
--[[
    ['spawncode'] = {
        one = {2, 5}, -- Extras for Stage 1
        two = {3}, -- Extras for Stage 2
        three = {4} -- Extras for Stage 3
    },
]]
stageCars = {
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

noRepair = {
    -- Vehicle that do NOT need to be auto repaired (Extras do NOT have collisions)
    'challengers', "f550ambow", "f550ambow2", 'bcsotransp1', 'lcsotransp1', 'lcso4', 'lcso3', 'lcso1', 'bcso1', '1500', 'sasp1', 'sasp6', 'bcso3', 'bcso2', 'bcso4', 'lcso2'
}