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
build = {
  type = 'builtin',
  copy_directories = { 'plugin' },
}

-- https://github.com/stefano-m/lua-dbus_proxy/issues/14
dependencies = { "lua >= 5.1", 'dbus_proxy >= 0.10.4', 'lua-cjson', 'luafilesystem', 'ime >= 0.0.4', "vim" }
