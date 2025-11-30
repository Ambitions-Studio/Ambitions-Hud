fx_version 'cerulean'

game 'gta5'

use_experimental_fxv2_oal 'yes'

author 'Ambitions Studio'

description 'Ambitions HUD — pA clean, modular, and fully customizable HUD system designed specifically for the Ambitions Framework on FiveM.'

version '0.3.0'

name 'Ambitions HUD'

lua54 'yes'

shared_scripts {
    '@Ambitions/init.lua',
    'config/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
}

client_scripts {
    'client/modules/*.lua',
}

ui_page 'web/dist/index.html'

files {
  'web/dist/index.html',
  'web/dist/assets/*.css',
  'web/dist/assets/*.js',
}

dependencies {
    'oxmysql',
    'Ambitions'
}
