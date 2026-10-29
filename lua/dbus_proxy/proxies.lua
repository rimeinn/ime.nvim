---utils for dbus proxy
local datafile = require 'datafile'
local _f, path = datafile.open("conf/get-GI_TYPELIB_PATH.nix")
if _f then
    _f:close()
else
    path = debug.getinfo(1).source:match("@?(.*/)[^/]+/[^/]+/[^/]+$") .. "etc/conf/get-GI_TYPELIB_PATH.nix"
end

local M = {}

---set `$GI_TYPELIB_PATH`
---@param force boolean?
---@diagnostic disable: undefined-global
-- luacheck: ignore 111 112 113
function M.set_env(force)
    force = force or vim and vim.env.GI_TYPELIB_PATH == nil
    if not force then
        return
    end
    local f = io.open("/run/current-system/nixos-version")
    if f then
        f:close()
        f = io.popen("nix eval --impure -f " .. path)
        local text
        if f then
            text = f:read()
            f:close()
        end
        if text then
            vim.env.GI_TYPELIB_PATH = vim.fn.eval(text)
        end
    end
end

return M
