-- Created by OSP-Development
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Complete Medical System Overhaul'
author 'OSP Development'
version '1.1.0'

shared_script {
    'lang/lang.lua',
    'config.lua',
    '@ox_lib/init.lua',
}

client_script {
    'lang/lang.lua',
    'client/*.lua',
}

server_script {
    -- '@async/async.lua',                      -- Uncomment these two lines if you are using mysql-async instead of oxmysql
	-- '@mysql-async/lib/MySQL.lua',
    '@oxmysql/lib/MySQL.lua',
    'lang/lang.lua',
    'server/server_open.lua',
    'server/server.lua',
}


files {
    'html/*',
    'html/img/*'
}

ui_page {
    'html/new.html'
}

escrow_ignore {
    'config.lua',
    'client/client_open.lua',
    'server/server_open.lua',
    'lang/lang.lua',
    'stream/*',
}

export {
    'GetAmbulanceData',
    'isDead',
}
dependency '/assetpacks'
dependency '/assetpacks'