fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'
description 'GKSPHONEv2'
version '2.0.6'

ui_page 'html/index.html'

shared_scripts {
    "@qb-apartments/config.lua", 	-- ## If you are not going to use the qb-apartments script delete it ##
    "@qb-garages/config.lua", 		-- ## If you are not going to use the qb-garages script delete it ##
    "config/config.lua",
	"config/functions.lua",
	"config/rentacar/sh_config.lua",
    "config/jobs/*",
}

files {
    "html/**/*",
    "config/config.json",
    "config/**/*"
}

client_scripts {
    "config/charge/*.lua",
    "config/signal/*.lua",
    "config/camera/*.lua",
	"client/**/*",
    "escrow/client/**/*",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "config/*.lua",
	"config/rentacar/sv_config.lua",
    "config/charge/*.lua",
    "config/signal/*.lua",
    "server/**/*",
    "escrow/server/**/*",
}

-- Client Exports --
client_exports {
    'Notification',
	'SendNewMail',
    'SendNewMailOffline'
}

--- Server Exports ---
server_exports {
    'SendNewMail',
    'SendNewMailOffline',
    'sendNotification'
}


dependencies {
    "oxmysql"
}

escrow_ignore {
    "config/*",
	"config/**/*",
    "server/**/*",
    "server/*",
    "client/*",
    "client/**/*"
}
dependency '/assetpacks'