fx_version 'cerulean'

game 'gta5'

use_experimental_fxv2_oal 'yes'

author 'Ambitions Studio'

description 'Ambitions HUD — A complete character management system with identity creation, appearance setup, and full integration into the Ambitions framework.'

version '0.3.0'

name 'Ambitions HUD'

lua54 'yes'

shared_scripts {
  '@Ambitions/init.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
}

client_scripts {
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
