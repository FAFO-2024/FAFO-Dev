fx_version 'cerulean'
game 'gta5'
version '2.2'
author 'discord.gg/codem'

shared_scripts {
	'shared/*.lua',
}

client_scripts {
	'client/main.lua',
	'client/minigame.lua',

	'client/interactionHandler.lua',
	'client/util.lua',
}

server_scripts {
	-- '@mysql-async/lib/MySQL.lua', --:warning:PLEASE READ:warning:; Uncomment this line if you use 'mysql-async'.:warning:
	'@oxmysql/lib/MySQL.lua', --:warning:PLEASE READ:warning:; Uncomment this line if you use 'oxmysql'.:warning:
	'server/*.lua',
}

ui_page "html/index.html"

files {
	'html/index.html',
	'html/*.mp3',

	'html/index.css',
	'html/responsive.css',
	'html/index.js',
	'html/vue/*.js',
	'html/assets/**/**/*.png',
	'html/assets/**/**/**/*.png',
	'html/assets/**/*.ttf',
	'html/assets/**/*.otf',

	'html/assets/**/*.TTF',
	'html/utils/*.js',
	'html/components/**/*.js',
	'html/components/**/*.css',
	'html/components/**/*.html',
	'html/components/**/components/**/*.html',
	'html/components/**/components/**/*.js',
	'html/components/**/components/**/*.css',


}

escrow_ignore {
	'shared/*.lua',
	'client/interactionHandler.lua',
	'client/util.lua',
	'server/util.lua',
	'server/xp.lua',
	'server/botToken.lua',
	'server/editable.lua',
}

lua54 'yes'

dependency '/assetpacks'