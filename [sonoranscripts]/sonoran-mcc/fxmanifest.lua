fx_version 'cerulean'
games {'gta5'}

author 'Sonoran Software Systems'
real_name 'MCC Camera System'
description 'Camera System for the MCC'
version '1.0.2'
config_version '1.3'

lua54 'yes'

shared_scripts {'config/config.lua'}

client_scripts {'client/client.lua', 'client/warmenu.lua'}

server_scripts {'server/server.lua', 'server/update.lua', 'server/util/unzip.js'}

files {'data/*.meta', 'html/ui.html', 'html/sounds/pullUp.mp3', 'html/sounds/putDown.mp3'}
ui_page 'html/ui.html'

data_file 'VEHICLE_METADATA_FILE' 'data/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/vehiclelayouts.meta'

escrow_ignore {'config/config.CHANGEME.lua'}

dependency '/assetpacks'