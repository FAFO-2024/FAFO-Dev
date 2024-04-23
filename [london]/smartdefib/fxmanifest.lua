fx_version 'adamant'
games { 'gta5' }
lua54 'yes'

author 'London Studios'
description 'A resource providing a realistic defibrillator experience'
version '1.0.0'

client_scripts {
    'config.lua',
    'cl_exports.lua',
    'cl_utils.lua',
    'cl_defib.lua',
}

export 'blipsEnable'

shared_script '@es_extended/imports.lua'

server_scripts {
    '@mysql-async/lib/MySQL.lua', -- Enable this if ESXv2 is enabled
    "@vrp/lib/utils.lua",
    'config.lua',
    'sv_defib.lua',
    'sv_utils.lua'
}

files {
    'stream/*',
    'index.html',
    'sounds/*.ogg',
    'locations.json',
}

ui_page 'index.html'

escrow_ignore {
    'stream/*',
    'config.lua',
    'cl_utils.lua',
    'cl_exports.lua',
    'sv_utils.lua',
    'locations.json',
}

files {
    'stream/prop_defib.ytyp',
}

data_file 'DLC_ITYP_REQUEST' 'stream/prop_defib.ytyp'
dependency '/assetpacks'