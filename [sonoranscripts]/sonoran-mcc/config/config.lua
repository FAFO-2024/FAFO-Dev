config = {}
config.configuration_version = 1.3 -- Do NOT change unless updating whole config file. Used by updater to tell you when new config file options are available.
config.auto_update = true -- Toggle Auto Updater, requires ace permissions to function. See Install Docs: https://docs.sonoran.store
config.debug_mode = false
config.eBrakeWithSliders = true -- Should the vehicle activate the "E-BRAKE" when the sliders are out
config.speedType = 'mph' -- Which way should the alpr speed display? Options: 'mph' or 'kph'
config.keys = {
    -- Use https://docs.fivem.net/docs/game-references/controls/#controls to find the name...
    -- and use https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/ to find index parameters for the key options below...
    cameraToggle = {cmd = 'mcccamera', name = 'INPUT_PICKUP', indexParam = 'e', lang = 'Access MCC Cameras'}, -- Key to access cameras
    interiorLightToggle = {cmd = 'mccintlights', name = 'INPUT_REPLAY_CYCLEMARKERRIGHT', indexParam = 'RBRACKET', lang = 'Toggle MCC Interior Lights'}, -- Key to toggle rear interior lighting
    radioRepeaterToggle = {cmd = 'mccradio', name = 'INPUT_REPLAY_CYCLEMARKERLEFT', indexParam = 'LBRACKET', lang = 'Toggle MCC Radio Repeater'}, -- Key to toggle Sonoran Radio repeater
    alprLockPlate = {cmd = 'mccplatelock', name = 'INPUT_FRONTEND_ENDSCREEN_ACCEPT', indexParam = 'RETURN', lang = 'Lock the current plate in the MCC ALPR'},
    menuToggle = {name = 'INPUT_SCRIPTED_FLY_ZUP', indexParam = 'PAGEUP'} -- Keybind to open the door control menu, can be changed in FiveM settings
}

-- Optional Menu/Commands/Keybinds controls for doors
config.doorControl = {
    method = 4, -- What method to use to control the doors | INTEGER | Options: 1 = commands, 2 = menu, 3 = none, 4 = commands & menu
    commands = {
        baseCmd = {cmd = 'mcctoggle', lang = 'Base MCC Toggle Command'}, -- Base command, see below for options
        antenna = {cmd = 'antenna', lang = 'Toggle MCC Antenna'}, -- toggle the antenna
        sliders = {cmd = 'sliders', lang = 'Toggle MCC Slide Out Sections'}, -- toggle the sliders
        rearDoor = {cmd = 'reardoor', lang = 'Toggle MCC Rear Door'}, -- toggle the read door
        frontLeft = {cmd = 'frontleft', lang = "Toggle MCC Driver's Door"}, -- toggle the front left door
        frontRight = {cmd = 'frontright', lang = "Toggle Passenger's Door"}, -- toggle the front right door
        allDoors = {cmd = 'all', lang = 'Toggle ALL MCC Doors'}, -- toggle all doors
        menuToggle = {cmd = 'togglem', lang = 'Toggle MCC Control Menu'} -- command to open the door control menu
    }
}

-- Translate the resource by customizing the messages below...
config.language = {
    mccHelpMessage = 'Press \n~' .. config.keys.cameraToggle.name .. '~ to access cameras \n~' .. config.keys.interiorLightToggle.name .. '~ to toggle interior lights',
    mccRadioHelpMessage = '\n~' .. config.keys.radioRepeaterToggle.name .. '~ to toggle mobile radio repeater',
    mccMenuHelpMessage = '\n~' .. config.keys.menuToggle.name .. '~ for more controls',
    radioRepeaterOn = 'MCC Radio repeater has been toggled on',
    radioRepeaterOff = 'MCC Radio repeater has been toggled off',
    notInMCC = 'You must be in the MCC to use this!',
    noValidArgument = 'You must provide a valid argument!',
    subCommand = 'Subcommand',
    subCommandOptions = 'Available options: ',
    missingSonoranRadio = 'Sonoran Radio not running, feature unavailable...',
    antennaNotUp = 'You must raise the antenna first!\n Use "/mcctoggle antenna" do to so',
    slidersOut = 'The MCC sliders are moving out... E brake will now engage.',
    slidersIn = 'The MCC sliders are now in... E brake will now disengange',
    intLightOn = 'The interior light has been toggled on!',
    intLightOff = 'The interior light has been toggled off!',
    alprLockPlate = 'Lock Plate'
}

config.alpr = {
    enabled = false, -- Enable Autmatic License Plate Reader on MCC Cameras
    enableSonoranCad = false, -- Enable sonorancad integration to alert on bolo/warrant/flag and be able to lock to force a CAD license plate lookup
    scanAi = false -- Allow passive lookups of AI plates, will be lots of spam if you enable notifying on "no registration" in sonorancad wraithv2 plugin
}

config.radio = {
    enabled = false, -- Enable MCC Mobile Repeater (requires sonoranradio resource and name must remain to be "sonoranradio")
    range = 750 --MCC Mobile repeater 
}