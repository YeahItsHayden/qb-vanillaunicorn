fx_version 'cerulean'
game 'gta5'

description 'QB-VanillaUnicorn Job'
version '1.0.0'
author 'Hayden#6789'

shared_scripts {
    'config/sh_config.lua'
}

client_scripts {
    'config/cl_config.lua',
	'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

dependencies {
    'zf_context'
}