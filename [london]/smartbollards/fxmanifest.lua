fx_version 'bodacious'
game 'gta5'

author 'London Studios'
description 'A smart interactive bollard solution.'
version '1.0.0'
lua54 'yes'

client_scripts {
    'cl_bollards.lua',
    'cl_spooner.lua',
    'cl_utils.lua'
}

shared_script 'config.lua'

shared_script '@es_extended/imports.lua'

server_scripts {
    'sv_bollards.lua',
    'sv_utils.lua'
}

files {
    'stream/**.ytyp',
    'stream/**.ydr',
    'bollardsets.json',
}

escrow_ignore {
    'config.lua',
    'cl_utils.lua',
    'bollardsets.json',
    'sv_utils.lua'
}

data_file 'DLC_ITYP_REQUEST' 'stream/*.ytyp'

dependency '/assetpacks'