fx_version 'adamant'
version '1.2'
game 'gta5'
author 'CodeStudio'
description 'Ultimate ID System'

this_is_a_map 'yes'
ui_page 'ui/index.html'

client_scripts {'main/client.lua', 'config/functions/cl_function.lua'}
server_scripts {'@oxmysql/lib/MySQL.lua', 'main/server.lua', 'config/functions/sv_function.lua'}
shared_scripts {'@ox_lib/init.lua', 'config/config.lua', 'config/language.lua'}

data_file 'DLC_ITYP_REQUEST' 'GreenScreenSINC.ytyp'

files {'ui/**', 'stream/GreenScreenSINC.ytyp'}

escrow_ignore {'config/**'}

dependencies {'oxmysql', 'ox_lib'}

lua54 'yes'
dependency '/assetpacks'