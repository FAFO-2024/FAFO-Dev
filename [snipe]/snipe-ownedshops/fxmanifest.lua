fx_version 'cerulean'
game 'gta5'

description 'Owned Shops Script'
version '1.5.0'
author 'Snipe'

lua54 'yes'
ui_page 'html/index.html'

shared_scripts {
    '@ox_lib/init.lua',
	'config/config.lua',
    'config/*.lua'
}

files {
	'html/**/*',
}

client_scripts{
    'utils/client.lua',
    'client/**/*.lua'
} 

server_scripts{
    'utils/server.lua',
    '@oxmysql/lib/MySQL.lua',
    'server/**/*.lua'
} 

escrow_ignore {
    'client/cl_customise.lua',
    'client/cl_normalshops.lua',
    'client/cl_inventory.lua',
    'server/sv_customise.lua',
    'config/config.lua',
    'config/locales.lua',
    'config/normalshops.lua',
    'utils/client.lua',
    'utils/server.lua',
    'server/sv_webhooks.lua',
}

dependency{
    'ox_lib'
}
dependency '/assetpacks'