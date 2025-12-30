local git_ref = '$git_ref'
local modrev = '$modrev'
local specrev = '$specrev'

local repo_url = '$repo_url'

rockspec_format = '3.0'
package = '$package'
if modrev:sub(1, 1) == '$' then
  modrev = "scm"
  specrev = "1"
  repo_url = "https://github.com/rimeinn/ime.nvim"
  package = repo_url:match("/([^/]+)/?$")
end
version = modrev .. '-' .. specrev

description = {
  summary = '$summary',
  detailed = '',
  labels = { 'lua', 'neovim', 'ime', 'dbus', 'linux' },
  homepage = '$homepage',
  license = 'GPL-3.0',
}

-- https://github.com/stefano-m/lua-dbus_proxy/issues/14
dependencies = { "lua >= 5.1", 'dbus_proxy >= 0.10.4', 'lua-cjson', 'luafilesystem', 'ime >= 0.0.4', "vim" }

test_dependencies = {}

source = {
  url = repo_url .. '/archive/' .. git_ref .. '.zip',
  dir = '$repo_name-' .. '$archive_dir_suffix',
}

if modrev == 'scm' or modrev == 'dev' then
  source = {
    url = repo_url:gsub('https', 'git')
  }
end

build = {
  type = 'builtin',
  copy_directories = { 'plugin' },
  install = {
    conf = {
      ['..'] = 'shell.nix',
      ['../scripts/update.sh'] = 'scripts/update.sh',
    },
  }
}
