fx_version 'cerulean'
games {'gta5'}

author 'Sonoran Software Systems & Agent BUB'
real_name 'Redneck Lighting Controller'
description 'Realistic extra based lighting system for Redneck Models.'
version '3.0'
config_version '3.0'

lua54 'yes'

shared_scripts {'config.lua'}

server_scripts {'server/*.lua'}

client_scripts {
    'client/*.lua',
    '@lvc/**/**/*.**'
}

files {
    'nui/app.js',
    'nui/index.html',
    'nui/images/*.png',
    'nui/images/whelen-gw/*.png',
    'nui/images/whelen-skeet/*.png',
    'nui/images/arrow/*.png',
    'nui/images/pathfinder/*.png',
    'nui/images/cencom/*.png',
    'nui/images/zthree/*.png',
    'nui/images/matrix/*.png',
    'nui/images/matrix-extras/*.png',
    'nui/images/**/*.png',
    'nui/style.css',
    'nui/sounds/*.ogg',
    'nui/sounds/cencom/*.ogg',
    'nui/sounds/zthree/*.ogg',
    'nui/sounds/matrix/*.ogg',
    'nui/sounds/**/*.ogg'
}

escrow_ignore {'config.CHANGEME.lua', 'README.md'}

ui_page 'nui/index.html'

dependency '/assetpacks'