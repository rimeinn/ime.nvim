---select an available backend
local set_env = require 'dbus_proxy.proxies'.set_env
local M = {
    names = {
        'dbus_proxy.proxies.ime.fcitx',
        'dbus_proxy.proxies.ime.fcitx-rime',
        'dbus_proxy.proxies.ime.g3kbswitch',
        'dbus_proxy.proxies.ime.gnome-shell',
        'dbus_proxy.proxies.ime.ibus',
    }
}

---@param names string[]?
---@return table? ime
function M.IME(names)
    set_env()
    names = names or M.names
    for _, name in ipairs(names) do
        local IME = require(name).IME
        local ok, ime = pcall(IME)
        if ok then
            return ime
        end
    end
end

return M
