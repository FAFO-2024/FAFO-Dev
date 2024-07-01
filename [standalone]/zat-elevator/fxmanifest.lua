fx_version 'cerulean'

games {"gta5", "rdr3"}

author "Project Error"
version '1.0.0'

lua54 'yes'

ui_page 'web/build/index.html'

client_script "client/**/*"

files {
  'web/build/index.html',
  'web/build/**/*'
}

shared_scripts {
  'config.lua',
  'shared/locales.lua',
  '@es_extended/imports.lua', -- only for ESX
  '@es_extended/locale.lua',  -- only for ESX
}
escrow_ignore {
  'client/target.lua',
  'shared/locales.lua',
  'config.lua',
}

dependency '/assetpacks'