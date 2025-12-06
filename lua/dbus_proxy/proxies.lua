---utils for dbus proxy
local fs = require 'vim.fs'

local M = {}

---get file path
---@param name string
---@return string
function M.get_path(name)
    return fs.joinpath(
        fs.dirname(debug.getinfo(1).source:match("@?(.*)")),
        "proxies", "scripts", name
    )
end

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
        f = io.popen("nix eval --impure -f " .. get_path("get-GI_TYPELIB_PATH.nix"))
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
