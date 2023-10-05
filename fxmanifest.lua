fx_version 'cerulean'
game 'gta5'

author 'Tonybyn_Mp4'
description 'Burgershot Job for the Qbox framework'
version '1.1.0'

shared_scripts {
	'@qbx_core/shared/locale.lua',
	'@qbx_core/import.lua',
	'@ox_lib/init.lua',
    'config.lua',
	'locales/en.lua',
	'locales/*.lua'
}

modules {
	'qbx_core:client:playerdata'
}

client_script 'client/main.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'