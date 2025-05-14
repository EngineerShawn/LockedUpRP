-- DO NOT TOUCH THE MANIFEST UNLESS YOU HAVE A REASON SPECIFIED BELOW
-- (please)

fx_version 'cerulean'
game 'gta5'
description 'Advanced, standalone AntiCheat for your FiveM server'
author 'wx / woox'
version '3.85'
lua54 'yes'

client_scripts {
	'client/anticheat_client.lua',
	'client/anticheat_antiafk.lua',
	'client/anticheat_nui.lua',
	'client/anticheat_heartbeat.lua',
	'html/index.js',
}

server_scripts {
	-- If you don't have OxMySQL and you're using other mysql system uncomment the line below
	-- '@mysql-async/lib/MySQL.lua',
	'@oxmysql/lib/MySQL.lua',
	'configs/anticheat_webhooks.lua',
	'editable/server/*.lua',
	'server/anticheat_update.lua',
	'server/anticheat_server.lua',
	'server/anticheat_txadmin.lua',
	'server/anticheat_commands.lua',
	'server/anticheat_exports.lua',
	'server/anticheat_functions.lua',
	'server/anticheat_logs.lua',
	'server/anticheat_nui.lua',
	'server/anticheat_heartbeat.lua',
	'admins/*.lua'
}

shared_scripts {
	'locale/anticheat_locale.lua',
	'configs/anticheat_config.lua',
	'editable/shared/*.lua',
	-- 'shared/*.lua',
}

escrow_ignore {
	'configs/*.lua',
	'admins/*.lua',
	'locale/*.lua',
	'ocr/*.lua',
	'editable/**/*.lua'
}

server_exports {
	'ban',
	'whitelistPlayer',
	'removeWhitelist',
	'addAdmin',
	'removeAdmin',
}

ui_page {
	'html/index.html',
}

files {
	'client/hashes.json',
	'html/index.html',
	'html/index.js',
	'html/**/*',
}

dependencies {
    '/server:4890',
    'yarn',
}

wx = "justbetter"
