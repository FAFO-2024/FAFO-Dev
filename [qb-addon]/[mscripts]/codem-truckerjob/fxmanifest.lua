fx_version 'cerulean'
game 'gta5'
version '1.1'
author 'discord.gg/codem'

shared_scripts {
	'shared/*.lua',
}

client_scripts {
	'client/main.lua',
}

server_scripts {
	-- '@mysql-async/lib/MySQL.lua', --:warning:PLEASE READ:warning:; Uncomment this line if you use 'mysql-async'.:warning:
	'@oxmysql/lib/MySQL.lua', --:warning:PLEASE READ:warning:; Uncomment this line if you use 'oxmysql'.:warning:
	'server/*.lua',
}


ui_page "html/index.html"

files {
	'html/index.html',
	'html/index.js',
	'html/index.css',
	'html/responsive.css',
	'html/components/**/index.html',
	'html/components/**/index.js',
	'html/vue/*.js',
	'html/utils/*.js',
	'html/assets/images/*.png',
	'html/assets/images/*.svg',
	'html/assets/fonts/*.ttf',
	'html/assets/fonts/*.TTF',
	'html/assets/fonts/*.OTF',
	'html/*.mp3',


}
escrow_ignore {
	'shared/*.lua',
	'server/botToken.lua',
	'server/dailymissions.lua',
	'server/xp.lua',
}
lua54 'yes'

dependency '/assetpacks'