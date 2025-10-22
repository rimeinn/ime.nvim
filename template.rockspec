local git_ref = '$git_ref'
local modrev = '$modrev'
local specrev = '$specrev'

local repo_url = '$repo_url'

rockspec_format = '3.0'
package = '$package'
version = modrev ..'-'.. specrev

description = {
  summary = '$summary',
  detailed = $detailed_description,
  labels = $labels,
  homepage = '$homepage',
  $license
}

-- https://github.com/stefano-m/lua-dbus_proxy/issues/14
dependencies = { "lua >= 5.1", 'dbus_proxy >= 0.10.4', 'lua-cjson', 'luafilesystem', 'ime >= 0.0.4' }

test_dependencies = $test_dependencies

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
