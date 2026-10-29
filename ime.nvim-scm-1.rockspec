rockspec_format = '3.0'
description = {
  summary = '',
  detailed = '',
  labels = {},
  homepage = 'https://github.com/rimeinn/ime.nvim',
  license = 'GPL-3.0',
}
package = description.homepage:match('/([^/]+)/?$')
version = 'scm-1'
source = {
  url = description.homepage:gsub('https', 'git')
}

-- https://github.com/stefano-m/lua-dbus_proxy/issues/14
dependencies = { 'lua >= 5.1', 'dbus_proxy >= 0.10.4', 'lua-cjson', 'luafilesystem', 'ime >= 0.0.4', 'vim', 'datafile', 'platformdirs' }
build = {
  type = 'builtin',
  copy_directories = { 'plugin' },
  install = {
    conf = {
      ['get-GI_TYPELIB_PATH.nix'] = 'etc/conf/get-GI_TYPELIB_PATH.nix',
      ['get_current_schema.js'] = 'etc/conf/get_current_schema.js',
      ['get_enabled.js'] = 'etc/conf/get_enabled.js',
      ['set_enabled.js'] = 'etc/conf/set_enabled.js',
    }
  }
}
