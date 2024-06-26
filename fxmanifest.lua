fx_version 'cerulean'
game 'gta5'

author 'Tonybyn_Mp4'
description 'Burgershot Job for the Qbox framework'
repository 'https://github.com/TonybynMp4/y_burgershot'
version '1.3.4'

ox_lib 'locale'
shared_scripts {
	'@ox_lib/init.lua',
}

client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'client/main.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

files {
    'locales/*.json',
    'config/client.lua',
    'config/shared.lua'
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'
