fx_version 'cerulean'
game 'gta5'

author 'Tonybyn_Mp4'
description 'Burgershot Job for the Qbox framework'
repository 'https://github.com/TonybynMp4/qbx_burgershot'
version '1.2.0'

shared_scripts {
	'@qbx_core/shared/locale.lua',
	'@ox_lib/init.lua',
    'config.lua',
	'locales/en.lua',
	'locales/*.lua'
}

client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'client/main.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'
