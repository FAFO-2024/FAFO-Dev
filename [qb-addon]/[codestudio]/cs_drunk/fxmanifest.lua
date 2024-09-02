fx_version 'adamant'
version '1.1'
game 'gta5'
description 'Code Studio Drunk Test Analyzer'

ui_page 'ui/index.html'

client_scripts {'main/client.lua', 'config/cl_function.lua'}
server_scripts {'main/server.lua', 'config/sv_function.lua'}
shared_scripts {'config/config.lua', 'main/function.lua'}

files {'ui/**'}

escrow_ignore {'config/*.lua'}

lua54 'yes'

dependency '/assetpacks'