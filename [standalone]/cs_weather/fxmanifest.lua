fx_version 'adamant'
version '1.0'
game 'gta5'
author 'CodeStudio'
description 'Weather Management'

ui_page 'ui/index.html'

client_scripts {'main/client.lua', 'config/functions/cl_function.lua'}
server_scripts {'@oxmysql/lib/MySQL.lua', 'main/server.lua', 'config/functions/sv_function.lua'}
shared_scripts {'@ox_lib/init.lua', 'config/config.lua'}

files {'ui/**'}

escrow_ignore {'config/**'}

dependencies {'ox_lib', 'oxmysql'}

lua54 'yes'

dependency '/assetpacks'