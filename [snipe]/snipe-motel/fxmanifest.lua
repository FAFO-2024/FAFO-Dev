fx_version 'cerulean'
game 'gta5'

description 'Snipe Motel System'
version '1.4.0'
author 'Snipe'

lua54 'yes'

ui_page 'html/index.html'

shared_scripts{
    '@ox_lib/init.lua',
    'shared/**/*.lua'
}

files {
	'html/**/*',
}

client_scripts{
    'client/open/camera/utils.lua',
    'client/**/*.lua',
} 

server_scripts{
    '@oxmysql/lib/MySQL.lua',
    'server/**/*.lua',
}

escrow_ignore{
    'client/open/camera/*',
    'client/open/*',
    'server/open/*',
    'shared/open/*'
}

files {
	'audiodata/audioexample_sounds.dat54.rel',
	'audiodirectory/apartment_sounds.awc',
}

data_file 'AUDIO_WAVEPACK' 'audiodirectory'
data_file 'AUDIO_SOUNDDATA' 'audiodata/audioexample_sounds.dat'



dependency '/assetpacks'