rockspec_format = "3.0"
package = "ime.nvim"
version = "scm-1"
source = {
	url = "git+https://github.com/rimeinn/ime.nvim.git",
}
description = {
	summary = "auto switch IME for neovim. 如何在 NeoVim 中方便的输入汉字（CJKV characters）",
	labels = { "fcitx5", "ibus", "lua", "neovim", "rime", "vim-plugin" },
	homepage = "https://ime-nvim.readthedocs.io/",
	license = "GPL-3.0",
}

-- https://github.com/stefano-m/lua-dbus_proxy/issues/14
dependencies = { "lua >= 5.1", "dbus_proxy >= 0.10.4", "lua-cjson", "luafilesystem", "ime >= 0.0.4", "vim" }

build = {
	type = "builtin",
	copy_directories = { "plugin" },
	install = {
		conf = {
			[".."] = "shell.nix",
			["../scripts/update.sh"] = "scripts/update.sh",
		},
	},
}
