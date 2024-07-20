# ime.nvim

[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/Freed-Wu/ime.nvim/main.svg)](https://results.pre-commit.ci/latest/github/Freed-Wu/ime.nvim/main)
[![github/workflow](https://github.com/Freed-Wu/ime.nvim/actions/workflows/main.yml/badge.svg)](https://github.com/Freed-Wu/ime.nvim/actions)

[![github/downloads](https://shields.io/github/downloads/Freed-Wu/ime.nvim/total)](https://github.com/Freed-Wu/ime.nvim/releases)
[![github/downloads/latest](https://shields.io/github/downloads/Freed-Wu/ime.nvim/latest/total)](https://github.com/Freed-Wu/ime.nvim/releases/latest)
[![github/issues](https://shields.io/github/issues/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim/issues)
[![github/issues-closed](https://shields.io/github/issues-closed/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim/issues?q=is%3Aissue+is%3Aclosed)
[![github/issues-pr](https://shields.io/github/issues-pr/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim/pulls)
[![github/issues-pr-closed](https://shields.io/github/issues-pr-closed/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim/pulls?q=is%3Apr+is%3Aclosed)
[![github/discussions](https://shields.io/github/discussions/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim/discussions)
[![github/milestones](https://shields.io/github/milestones/all/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim/milestones)
[![github/forks](https://shields.io/github/forks/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim/network/members)
[![github/stars](https://shields.io/github/stars/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim/stargazers)
[![github/watchers](https://shields.io/github/watchers/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim/watchers)
[![github/contributors](https://shields.io/github/contributors/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim/graphs/contributors)
[![github/commit-activity](https://shields.io/github/commit-activity/w/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim/graphs/commit-activity)
[![github/last-commit](https://shields.io/github/last-commit/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim/commits)
[![github/release-date](https://shields.io/github/release-date/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim/releases/latest)

[![github/license](https://shields.io/github/license/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim/blob/main/LICENSE)
[![github/languages](https://shields.io/github/languages/count/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim)
[![github/languages/top](https://shields.io/github/languages/top/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim)
[![github/directory-file-count](https://shields.io/github/directory-file-count/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim)
[![github/code-size](https://shields.io/github/languages/code-size/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim)
[![github/repo-size](https://shields.io/github/repo-size/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim)
[![github/v](https://shields.io/github/v/release/Freed-Wu/ime.nvim)](https://github.com/Freed-Wu/ime.nvim)

[![luarocks](https://img.shields.io/luarocks/v/Freed-Wu/ime.nvim)](https://luarocks.org/modules/Freed-Wu/ime.nvim)

Switch back from IME after `InsertLeave`. Powered by dbus.

## Introduction

- Vim (include other editors who have a vim emulator) is mulit-mode editor:
  - insert mode
  - normal mode
  - ...
- IME is also mulit-mode:
  - ASCII mode
  - CJKV mode
  - ...

In insert mode, we can switch IME mode to input ASCII characters or CJKV
characters. However, in other modes of Vim, only ASCII mode can work: Vim will
not response any CJKV character. So we must switch back from IME after
`InsertLeave`.

Currently, we have two schemes to realize it:

### IME inside Vim

1. Vim passes user's input to IME by librime/dbus
2. IME passes the result to Vim by librime/dbus
3. Vim draw UI of Vim IME window
4. When user `InsertLeave`, we close Vim IME window.

#### [librime](https://github.com/rime/librime)

librime is a library for creating IME.

- [coc-rime](https://github.com/tonyfettes/coc-rime): written in javascript
- [rime.nvim](https://github.com/Freed-Wu/rime.nvim): written in lua

#### [dbus](https://dbus.freedesktop.org/)

dbus is an inter process communication system. we can communicate with an
external IME.

- [fcitx5.nvim](https://github.com/tonyfettes/fcitx5.nvim): for fcitx5
- [fcitx5-ui.nvim](https://github.com/black-desk/fcitx5-ui.nvim): for fcitx5

### IME outside Vim

1. call IME to switch back to ASCII mode when `InsertLeave` by CLI/dbus

#### CLI

Some IMEs provide a CLI program to switch mode.

- [macism](https://github.com/laishulu/macism): for macOS
- [im-select](https://github.com/daipeihust/im-select): for macOS and Windows
- `ibus engine`: for ibus
- `g3kb-switch`: for ibus
- `xkb-switch`: for xim
- `fcitx-remote`: for fcitx5

Some Vim plugins use CLI:

- [nvim-auto-ime](https://github.com/crispgm/nvim-auto-ime): only support macism
- [im-select.nvim](https://github.com/keaising/im-select.nvim): support
  im-select, ibus, fcitx

#### dbus

This plugin does it for:

- ibus:
  [gnome shell >= 41 don't allow user eval any javascript in unsafe mode](https://github.com/lyokha/g3kb-switch#gnome-45-and-newer).
  Install some gnome extensions like
  [g3kb-switch](https://github.com/lyokha/g3kb-switch) or
  [unsafe-mode-menu](https://github.com/linushdot/unsafe-mode-menu) to avoid it.
- fcitx5
- fcitx5-rime
