fx_version 'cerulean'
version '2.5'
game 'gta5'
author 'CodeStudio'
description 'Code Studio Advanced ID Card + Job Badge'

ui_page 'ui/index.html'

client_scripts {'config/function/cl_function.lua', 'main/client.lua'}
server_scripts {'@oxmysql/lib/MySQL.lua', 'config/function/sv_function.lua', 'main/server.lua'}
shared_scripts {'@ox_lib/init.lua', 'config/*.lua'}

files {'ui/**'}

escrow_ignore {'config/**'}

dependencies {'oxmysql', 'ox_lib'}

lua54 'yes'

dependency '/assetpacks'