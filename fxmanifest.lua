fx_version 'bodacious'

game 'gta5'

name 'Show Weapon by itzhapp'

description 'Show Weapon created by itzhapp#9737, part of [Extra]'

author 'itzhapp'

version '1.0'

client_scripts {
	'@es_extended/locale.lua',
	'client/**.lua'
}

shared_scripts{
	'@es_extended/locale.lua',
	'cfg/**.lua'
}

dependencies {
	'es_extended',
	'yarn',
	'ox_inventory'
}