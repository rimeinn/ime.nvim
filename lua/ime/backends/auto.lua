---select a backend if available
---@diagnostic disable: undefined-global
-- luacheck: ignore 111 113
local get_path = require 'ime.backends.gnome-shell'.get_path
local M = {
    IMEs = {
        require 'ime.backends.fcitx'.IME,
        require 'ime.backends.fcitx-rime'.IME,
        require 'ime.backends.g3kbswitch'.IME,
        require 'ime.backends.gnome-shell'.IME,
        require 'ime.backends.ibus'.IME,
    }
}

---set `$GI_TYPELIB_PATH`
function M.set_env()
    local f = io.open("/run/current-system/nixos-version")
    if f then
        f:close()
        f = io.popen("nix eval --impure -f " .. get_path("get-GI_TYPELIB_PATH.nix"))
        if f then
            loadstring("vim.env.GI_TYPELIB_PATH = " .. f:read())()
            f:close()
        end
    end
end

---@param IMEs function[]?
---@return table? ime
function M.IME(IMEs)
    if vim and vim.env.GI_TYPELIB_PATH == nil then
        M.set_env()
    end
    IMEs = IMEs or M.IMEs
    for _, IME in ipairs(IMEs) do
        local ok, ime = pcall(IME)
        if ok then
            return ime
        end
    end
end

return M
