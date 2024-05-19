fx_version 'adamant'
game 'gta5'
lua54 'yes'

client_scripts {
    '@NativeUI/NativeUI.lua',
    'config.lua',
    'client/utils.lua',
    'client/menu.lua',
    'client/client.lua'
}

server_scripts { 
    'config.lua',
    'server.lua'
}

escrow_ignore {
    'config.lua',
    'tape.ytd',
    'tapex.ytd',
}

files{
    'stream/tape.ytyp',
    'stream/mdx_rolltape.ytyp'
}

data_file 'DLC_ITYP_REQUEST' 'stream/tape.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/mdx_rolltape.ytyp'
dependency '/assetpacks'