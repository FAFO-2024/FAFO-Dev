fx_version 'adamant'
game 'gta5'
description 'mWeed'
lua54 'yes'
author 'Lucid#3604'
version '1.2'

shared_scripts {
    'shared/GetCore.lua',
    'shared/config.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
	'server/*.lua',
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/app/*.js',
	'html/app/components/*.js',
	'html/app/modules/*.js',	
	'html/app/utils/*.js',	
	'html/app/pages/**/*.js',
	'html/app/pages/**/*.html',	
	'html/css/*.css',
	'html/assets/fonts/*.otf',
	'html/assets/fonts/*.ttf',
	'html/assets/sounds/*.MP3',
	'html/assets/sounds/*.wav',
	'html/assets/images/*.png',
	'html/assets/item_images/*.png',

}

escrow_ignore {
	'shared/config.lua',
	'shared/GetCore.lua',
	'client/animatons.lua',
	'client/dealer.lua',
	'client/editable.lua',
	'client/interaction.lua',
	'client/PlayerLoaded.lua',
	'client/weed.lua',
	'server/botToken.lua',
	'server/dealer.lua',
	'server/weed.lua',
}

dependency '/assetpacks'