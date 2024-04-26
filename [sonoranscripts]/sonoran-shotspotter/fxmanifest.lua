fx_version 'cerulean'
games {'gta5'}
author 'Sonoran Software'
version '1.3.0'
config_version '1.5'
real_name 'Shot Spotter'

lua54 'yes'

client_scripts {'client/*.lua'}

server_scripts {'server/*.lua', 'server/util/unzip.js', 'config/discord.lua'}

shared_scripts {'shared/*.lua', 'config/config.lua'}

files {'stream/*.ytyp'}

data_file 'DLC_ITYP_REQUEST' 'stream/*.ytyp'

escrow_ignore {'config/config.CHANGEME.lua', 'config/spotters.CHANGEME.json', 'config/discord.CHANGEME.lua'}

dependency '/assetpacks'