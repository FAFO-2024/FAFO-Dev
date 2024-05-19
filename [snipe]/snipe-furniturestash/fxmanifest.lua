fx_version 'cerulean'
game 'gta5'

description 'Snipe Furniture Stash System for Motels'
version '1.0.1'
author 'Snipe'

lua54 'yes'

shared_scripts{
    '@ox_lib/init.lua',
    'shared/**/*.lua',
}

client_scripts{
    'client/**/*.lua',
} 

server_scripts{
    '@oxmysql/lib/MySQL.lua',
    'server/**/*.lua'
}

escrow_ignore{
    'client/open/*',
    'server/open/*',
    'shared/*'
}

dependency '/assetpacks'