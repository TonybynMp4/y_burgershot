fx_version 'cerulean'
game 'gta5'

author 'Tonyby_Mp4'
description 'Burgershot Job for the Qbox framework'
version '1.0.0'

shared_scripts {
	'@qbx-core/import.lua',
	'@qbx-core/shared/locale.lua',
	'@ox_lib/init.lua',
    'config.lua',
	'locales/*.lua'
}

modules {
	'qbx-core:core',
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'