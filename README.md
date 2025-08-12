# ime.nvim

[![readthedocs](https://shields.io/readthedocs/ime-nvim)](https://ime-nvim.readthedocs.io)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/rimeinn/ime.nvim/main.svg)](https://results.pre-commit.ci/latest/github/rimeinn/ime.nvim/main)
[![github/workflow](https://github.com/rimeinn/ime.nvim/actions/workflows/main.yml/badge.svg)](https://github.com/rimeinn/ime.nvim/actions)

[![github/downloads](https://shields.io/github/downloads/rimeinn/ime.nvim/total)](https://github.com/rimeinn/ime.nvim/releases)
[![github/downloads/latest](https://shields.io/github/downloads/rimeinn/ime.nvim/latest/total)](https://github.com/rimeinn/ime.nvim/releases/latest)
[![github/issues](https://shields.io/github/issues/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim/issues)
[![github/issues-closed](https://shields.io/github/issues-closed/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim/issues?q=is%3Aissue+is%3Aclosed)
[![github/issues-pr](https://shields.io/github/issues-pr/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim/pulls)
[![github/issues-pr-closed](https://shields.io/github/issues-pr-closed/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim/pulls?q=is%3Apr+is%3Aclosed)
[![github/discussions](https://shields.io/github/discussions/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim/discussions)
[![github/milestones](https://shields.io/github/milestones/all/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim/milestones)
[![github/forks](https://shields.io/github/forks/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim/network/members)
[![github/stars](https://shields.io/github/stars/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim/stargazers)
[![github/watchers](https://shields.io/github/watchers/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim/watchers)
[![github/contributors](https://shields.io/github/contributors/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim/graphs/contributors)
[![github/commit-activity](https://shields.io/github/commit-activity/w/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim/graphs/commit-activity)
[![github/last-commit](https://shields.io/github/last-commit/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim/commits)
[![github/release-date](https://shields.io/github/release-date/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim/releases/latest)

[![github/license](https://shields.io/github/license/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim/blob/main/LICENSE)
[![github/languages](https://shields.io/github/languages/count/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim)
[![github/languages/top](https://shields.io/github/languages/top/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim)
[![github/directory-file-count](https://shields.io/github/directory-file-count/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim)
[![github/code-size](https://shields.io/github/languages/code-size/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim)
[![github/repo-size](https://shields.io/github/repo-size/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim)
[![github/v](https://shields.io/github/v/release/rimeinn/ime.nvim)](https://github.com/rimeinn/ime.nvim)

[![luarocks](https://img.shields.io/luarocks/v/rimeinn/ime.nvim)](https://luarocks.org/modules/rimeinn/ime.nvim)

Switch back from IME after `InsertLeave`. Powered by dbus.

## Introduction

### Multi-mode IME

- Vim (include other editors who have a vim emulator) is mulit-mode editor:
  - insert mode
  - normal mode
  - ...
- IME is also multi-mode mostly:
  - ASCII mode
  - CJKV mode
  - ...

In insert mode, we can switch IME mode to input ASCII characters or CJKV
characters. However, in other modes of Vim, only ASCII mode can work: Vim will
not response any CJKV character. So we must switch back from IME after
`InsertLeave`.

Currently, we have two schemes to realize it:

#### IME inside Vim

![IME inside Vim](https://github.com/user-attachments/assets/e35e9848-ba5d-478c-be80-953830cd8a65)

- no dependencies of GUI
- support remote machines: ssh, telnet, ...

1. Vim passes user's input to IME by librime/dbus
2. IME passes the result to Vim by librime/dbus
3. Vim draw UI of Vim IME window
4. When user `InsertLeave`, we close Vim IME window.

##### [librime](https://github.com/rime/librime)

librime is a library for creating IME.

- [coc-rime](https://github.com/tonyfettes/coc-rime): written in javascript
- [rime.nvim](https://github.com/rimeinn/rime.nvim): written in lua

##### [dbus](https://dbus.freedesktop.org/)

dbus is an inter process communication system. we can communicate with an
external IME.

- [fcitx5.nvim](https://github.com/tonyfettes/fcitx5.nvim): for fcitx5
- [fcitx5-ui.nvim](https://github.com/black-desk/fcitx5-ui.nvim): for fcitx5

#### IME outside Vim

![IME outside Vim](https://github.com/user-attachments/assets/1f4ed782-9aa2-49ab-8ed7-be0c4a3f0c2a)

- support more hotkeys
- same settings as IME for other windows

1. call IME to switch back to ASCII mode when `InsertLeave` by CLI/dbus

##### CLI

Some IMEs provide a CLI program to switch mode.

- [issw](https://github.com/vovkasm/input-source-switcher): for macOS
- [macism](https://github.com/laishulu/macism): for macOS
- [im-select](https://github.com/daipeihust/im-select): for macOS and Windows
- `ibus engine`: for ibus
- `fcitx-remote`: for fcitx5
- [`g3kb-switch`](https://github.com/lyokha/g3kb-switch): for ibus, and provide
  a DLL
- [`xkb-switch`](https://github.com/grwlf/xkb-switch): for xim, and provide a
  DLL
- [`xkb-switch` (for macOS)](https://github.com/myshov/xkbswitch-macosx): for
  macOS, and provide a DLL

Some Vim plugins use CLI:

- [nvim-auto-ime](https://github.com/crispgm/nvim-auto-ime): only support macism
- [coc-imselect](https://github.com/neoclide/coc-imselect): only support
  im-select
- [im-select.nvim](https://github.com/keaising/im-select.nvim): support
  im-select, ibus engine, fcitx-remote
- [alohaia/fcitx.nvim](https://github.com/alohaia/fcitx.nvim): only support
  fcitx-remote
- [h-hg/fcitx.nvim](https://github.com/h-hg/fcitx.nvim): only support
  fcitx-remote
- [vim-barbaric](https://github.com/rlue/vim-barbaric): support ibus engine,
  fcitx-remote, xkb-switch

##### dbus

- [vim-xkbswitch](https://github.com/lyokha/vim-xkbswitch): support g3kb-switch,
  xkb-switch and issw by their DLLs, where g3kb-switch utilizes dbus and is
  written in C
- [fcitx.vim](https://github.com/lilydjwg/fcitx.vim): support fcitx and
  fcitx5-rime. written in python
- This plugin: support
  - fcitx5: with or without rime input schema
  - ibus
  - gnome-shell: you can get IME information from gnome-shell whatever you use
    which IME. You need
    [unsafe-mode-menu](https://github.com/linushdot/unsafe-mode-menu)
    to open unsafe mode in latest gnome-shell.
  - g3kb-switch: or use it to bypass security prohibit.

> In Gnome 41 and newer, the switcher will only work with G3kbSwitch Gnome Shell
> extension, because method org.gnome.Shell.Eval which was used in the original
> implementation of the switcher is now disabled for security reasons
>
> -- [g3kb-switch](https://github.com/lyokha/g3kb-switch#gnome-45-and-newer)

### single-mode IME

![single-mode IME](https://user-images.githubusercontent.com/32936898/201919443-6007f9bd-8c29-4804-9911-2e0a59a83e17.jpg)

<!-- markdownlint-disable MD033 -->

Editor can provide a popup menu to let user select candidate. If user use
<kbd>Ctrl</kbd> + <kbd>P</kbd>/<kbd>N</kbd> to select, input CJKV characters.
Otherwise, input ASCII characters.

- more key pressing, the 10-th candidation need 10 times
  <kbd>Ctrl</kbd> + <kbd>N</kbd>
- ASCII characters cannot be near CJKV characters.
  `hi nihao` will complete `nihao`, `hinihao` will complete `hinihao`.
  However, it shouldn't happen. Because:

<!-- markdownlint-enable MD033 -->

> 中英文之間需要增加空格
>
> -- [中文文案排版指北](https://github.com/sparanoid/chinese-copywriting-guidelines#%E4%B8%AD%E8%8B%B1%E6%96%87%E4%B9%8B%E9%96%93%E9%9C%80%E8%A6%81%E5%A2%9E%E5%8A%A0%E7%A9%BA%E6%A0%BC)

We can create:

- a language server to support all editors which supports LSP.
  The editor will manage the popup menu according to LSP.
- an editor specific plugin.
  - register a completion source of other editor plugins which manage the popup
    menu
  - manage the popup menu by itself

#### LSP

- [ds-pinyin-lsp](https://github.com/iamcco/ds-pinyin-lsp): only support full
  pinyin.

#### [coc.nvim](https://github.com/neoclide/coc.nvim)

- [coc-rime](https://github.com/tonyfettes/coc-rime): written in javascript

#### [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)

- [cmp-rime](https://github.com/Ninlives/cmp-rime): written in python
- [rime.nvim](https://github.com/rimeinn/rime.nvim#nvim-cmp): written in lua

##### Manage popup menu by itself

Manage popup menu by itself will result in the conflict with other editor
plugins which manage the popup menu.
At the same time, you must enable one of them.

> Sorry, you have to make the choice.
>
> -- [coc-snippets](https://github.com/neoclide/coc-snippets/issues/137)

- [vimIM](https://github.com/vim-scripts/VimIM): stop maintenance
- [ZFVimIM](https://github.com/ZSaberLv0/ZFVimIM): a rewrite of vimIM.
  It will
  [disable most completion plugins](https://github.com/ZSaberLv0/ZFVimIM/blob/master/plugin/ZFVimIM_autoDisable.vim)
  when it is enabled.

## Dependencies

```sh
# Ubuntu
sudo apt-get -y install libgirepository-1.0-1 libgirepository1.0-dev pkg-config
sudo apt-mark auto libgirepository1.0-dev pkg-config
# ArchLinux
sudo pacman -S libgirepository pkg-config
# Android Termux
apt-get -y install gobject-introspection pkg-config
# Nix
# use nix-shell to create a virtual environment then build
```

## Install

### rocks.nvim

#### Command style

```vim
:Rocks install ime.nvim
```

#### Declare style

`~/.config/nvim/rocks.toml`:

```toml
[plugins]
"ime.nvim" = "scm"
```

Then

```vim
:Rocks sync
```

or:

```sh
$ luarocks --lua-version 5.1 --local --tree ~/.local/share/nvim/rocks install ime.nvim
# ~/.local/share/nvim/rocks is the default rocks tree path
# you can change it according to your vim.g.rocks_nvim.rocks_path
```

## Tips

- For Nix user, run
  `/the/path/of/luarocks/rocks-5.1/ime.nvim/VERSION/scripts/update.sh`
  when dynamic link libraries are broken after `nix-collect-garbage -d`.
- For NixOS, `require'dbus_proxy'` needs correct `vim.env.GI_TYPELIB_PATH`. This
  plugin will do it out of box. You also can add the following code to
  `.bash_profile` to run once to speed up:

```sh
if [[ -f /run/current-system/nixos-version ]]; then
  if [[ -f /the/path/lua/5.1/ime/get-GI_TYPELIB_PATH.nix ]]; then
    export GI_TYPELIB_PATH
    eval GI_TYPELIB_PATH="$(nix eval --impure -f ~/.local/share/lua/5.1/ime/get-GI_TYPELIB_PATH.nix)"
  fi
fi
```
