fx_version 'cerulean'
games {'gta5'}

author 'Redneck Modifications'
real_name 'Rendeck Stretcher Script'
description 'A simple script to be able to use the stretcher model on the ambos.'
lua54 'yes'

client_scripts {
	'warmenu.lua',
	'config.lua',
  	'client/main.lua'
}

escrow_ignore {'config.lua'}

dependency '/assetpacks'