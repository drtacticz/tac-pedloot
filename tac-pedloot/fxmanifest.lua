fx_version 'cerulean'
game 'gta5'
author 'T A C'
description 'QB-core looting script for dead ped corps'
version '1.0'
lua54 'yes'
shared_scripts {
	'@qb-core/shared/locale.lua',
	'locales/en.lua', 										-- change to your language "you can add more"
	'config.lua',
}
client_scripts {
	'client/main.lua',
}
server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua',
}
dependencies {
        'qb-core',
		'ox_target',
}