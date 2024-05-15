fx_version 'cerulean'
game 'gta5'
version '1.6'

shared_scripts {
	'shared/*.lua',
}

client_scripts {
	'client/*.lua',
}

server_scripts {
	'server/*.lua',
}

ui_page "html/index.html"

files {
	'html/index.html',
	'html/style.css',
	'html/index.js',
	'html/*.js',
	'html/fonts/*.OTF',
	'html/fonts/*.otf',
	'html/images/*.png',
}

escrow_ignore{
	'shared/*.lua',
	'server/botToken.lua'
}

lua54 'yes'
dependency '/assetpacks'