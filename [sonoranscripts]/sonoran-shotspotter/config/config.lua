config = {}
config.configuration_version = "1.5"
config.debug_mode = false

-- Permission Systems
config.permissions = {
    restricted = true, -- Should the script be restricted? [Boolean]
    ace_perms = {
        use_ace_perms = true, -- Use ace perms? [Boolean]
        ace_object = "sonoran.shotspot" -- Ace permission object [String]
    },
    esx = {
        use_esx = false, -- Utilize the ESX framework for permissions [Boolean]
        police_job = {"police", "sheriff", "sahp"}, -- The name of your ESX_Policejob [String]
        admin = "esx.god"
    },
    qbcore = {
        use_qbcore = true, -- Utilize the QBCore framework for permissions [Boolean]
        police_job = {"police", "sheriff", "sahp"}, -- The name of your QB_Policejob [String]
        admin = "qbcore.god"
    },
    admin = {
        ace_object = "shotspotter.admin"
    }
}
-- General Config
config.general = {
    use_auto_detect = false, -- Ignore spotter radius and simple auto detect
    auto_update = true, -- Would you like to automatically update the script?
    use_cad = false, -- Utilize the Sonoran Cad framework to automatically send 911 calls to cad
    use_livemap = false, -- Utilize the Sonoran Cad livemap
    postals = {
        use_postals = true, -- Use the postal code in the 911 call
        postal_script = 'nearest-postal' -- The name of the postal script to use
    }
}
config.check_dispatch = {
    use_check = true, -- Check if there is a dispatcher oneline before sending a 911 call
    send_911_if_on = true, -- Send the 911 call if the dispatcher is online
    send_911_if_off = true, -- Send the 911 call if there is no active AddDispatchSpawnBlockingAngledArea
    send_ingame_alert_if_on = false, -- Send the alert to the active units if dispatch is online
    send_ingame_alert_if_off = true -- Send the alert to the active units if dispatch is offline
}

config.network_latency = {
    use_network_latency = true, -- Add a delay to the calls from the shot SetPlayerMayNotEnterAnyVehicle
    network_time = 30 -- Max time in SECONDS that it will take before a call goes through
}
config.notifications = {
    type = 'native' -- Available types: native, pNotify, okokNotify
}
config.commands = {
    use_command = true, -- Use a command to toggle shot spotter on and off (true = you will have to run the command to get the alerts | false = anyone allowed will always get them) [Boolean]
    shotspot_cmd = "shotspot", -- The command to activate the shot spotter
    show_spotter_id = "showspotterid", -- The command to show spotter ID's
    show_spotter_pos = "showspotterpos", -- Show a specified spotter position
    changepositiondata = "changepositiondata", -- Change position data
    reload_spotters = "reloadspotters",
    placement_gun = "spawnnewspotter",
    cancelspotterplace = "cancelspotterplace",
    disablespotter = "togglespotter"
}
config.map = {
    show_on_map = true, -- Should there be a blip on the map of the general location of the shot fired
    radius = 300.0 -- How large of a radius should the shot spotter show (default 300.0) [Integer]
}

-- Shot Spotter
config.spotter = {
    use_object = true, -- Utilize the included shot spotter object || ** MUST BE TRUE ** DO NOT EDIT **
    cooldown = 60, -- Cooldown time in seconds
    poleProps = {'1043035044', '862871082', '-655644382', '-730685616', '656557234', '865627822', '589548997', '-1535830511', '-945465914', '-925181899', '-2065691369', '-22216529'} -- Array of props that cameras are spawned on
}

-- Whitelist
config.whitelist = {
    peds = {"S_M_Y_COP_01", "S_M_Y_COP_02"}, -- Peds that will not trigger the shot spotter
    weapons = { -- Weapons that will not trigger the shot spotter
    "WEAPON_UNARMED", "WEAPON_STUNGUN", "WEAPON_KNIFE", "WEAPON_KNUCKLE", "WEAPON_NIGHTSTICK", "WEAPON_HAMMER",
    "WEAPON_BAT", "WEAPON_GOLFCLUB", "WEAPON_CROWBAR", "WEAPON_BOTTLE", "WEAPON_DAGGER", "WEAPON_HATCHET",
    "WEAPON_MACHETE", "WEAPON_FLASHLIGHT", "WEAPON_SWITCHBLADE", "WEAPON_FIREEXTINGUISHER", "WEAPON_PETROLCAN",
    "WEAPON_SNOWBALL", "WEAPON_FLARE", "WEAPON_BALL"}
}
config.lang = {
    cmds = {
        enable_alerts = "Enable shot spotter alerts and locations",
        alerts_enabled = "You have enabled shot spotter alerts!",
        alerts_disabled = "You have disabled shot spotter alerts!",
        access_denied = "Access Denied!",
        alr_spawning = "Already spawning a shot spotter. Please cancel current spawn first!",
        spawn_new = "Spawn a new shot spotter and save it to the config based on pointing a gun",
        label_text = "The label you want to apply to the shot spotter",
        no_name = "You did not supply a spotter name.",
        show_spotter_pos = "Show the position of the shot spotters",
        show_id_ID = "Shot spotter ID",
        show_spotter_id = "Show the ID of the nearby shot spotter",
        changepositiondata = "Change the position of the specified shot spotters",
        position_name = "Postition i.e X, Y, Yaw, Roll",
        position_value = "Integer value for the position",
        reload_spotters = "Reload all spotters and postions",
        cancelspotterplace = "Cancel the current placement of a spotter",
        disablespotter = "Disable a shot spotter by ID"
    },
    webhooks = {
        alert_toggled_on_title = "{{player}} has toggled their Shot Spotter",
        alert_toggled_on_body = "They will now recieve all shot spotter alerts and locations.",
        alert_toggled_off_title = "{{player}} has toggled their Shot Spotter",
        alert_toggled_off_body = "They will no longer recieve shot spotter alerts and locations.",
        active_shooter_title = "Shot Spotter Triggered",
        active_shooter_body = "There has been a shooting picked up by the shot spotter {{spotter}} near {{street}}",
        disabled_title = "A Shot Spotter Has Been Toggled!",
        disabled_body = "The spotter with the ID {{spotter}} has been toggled by {{player}}"
    },
    events = {
        nineoneone_desc = "This is an automated message from the Sonoran Shot Spotter",
        nineoneone_player = "We have recieved and automatic alert from {{spotter}} about a shooting near {{street}} (Postal: {{postal}})",
        alr_blip = "Another blip was not created due to your GPS already having one active."
    }
}