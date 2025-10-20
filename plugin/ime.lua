---you can config `ime.backend` before `InsertEnter`
---@diagnostic disable: undefined-global
-- luacheck: ignore 111 113
local ime = require 'ime.nvim'
ime.create_autocmds()
