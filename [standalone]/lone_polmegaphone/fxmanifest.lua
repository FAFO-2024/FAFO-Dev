--Made by Lone with ❤️

fx_version 'cerulean'
game 'gta5'

--Details
author '.lone17'
description 'Vehicle megaphone script for Police vehicles'
version '1.0.0'


client_script {
    'client/client.lua',
}

server_script 'server/server.lua'

shared_script {
'config.lua',
'@es_extended/imports.lua',
}


escrow_ignore {
   'config.lua',
}

lua54 'yes'

dependency '/assetpacks'