fx_version 'cerulean'
games { 'gta5' }

author 'Sonoran Software Systems'
real_name 'Sonoran ATM Heist'
description 'Steal & rob ATM\'s realistically and efficiency'
version '1.0.5'
config_version '1.1'

lua54 'yes'

shared_scripts { 'shared/*.lua', 'config/config.lua' }

server_scripts { 'server/*.lua', 'server/util/unzip.js', 'config/discord.lua' }

client_scripts { 'client/*.lua' }

escrow_ignore { 'config/config.CHANGEME.lua', 'config/discord.CHANGEME.lua', 'config/atms.CHANGEME.json', 'config/ESX INSTALLME.sql'}

dependency '/assetpacks'
dependency '/assetpacks'