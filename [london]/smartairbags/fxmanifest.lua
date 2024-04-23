fx_version 'bodacious'

games { 'gta5' }

author 'London Studios'
description 'Adds airbags to vehicles'
version '1.0.0'
lua54 'yes'

shared_script 'config.lua'

files {
    'stream/prop_car_airbag.ytyp',
	'index.html',
	'sounds/*',
	'stream/*.ytd',
}

data_file 'DLC_ITYP_REQUEST' 'stream/prop_car_airbag.ytyp'

client_scripts {
	'cl_utils.lua',
	'cl_airbags.lua',
}

server_scripts {
	'sv_airbags.lua',
}

escrow_ignore {
	'index.html',
	'stream/**',
	'config.lua',
	'cl_utils.lua',
	'sounds/*',
	'stream/*.ytd',
}

ui_page 'index.html'

-- Join the London Studios Discord server here: https://discord.gg/htyaZNaG
dependency '/assetpacks'