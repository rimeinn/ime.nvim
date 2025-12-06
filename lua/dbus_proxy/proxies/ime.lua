---select an available backend
local set_env = require 'dbus_proxy.proxies'.set_env
local M = {
    IMEs = {
        require 'dbus_proxy.proxies.ime.fcitx'.IME,
        require 'dbus_proxy.proxies.ime.fcitx-rime'.IME,
        require 'dbus_proxy.proxies.ime.g3kbswitch'.IME,
        require 'dbus_proxy.proxies.ime.gnome-shell'.IME,
        require 'dbus_proxy.proxies.ime.ibus'.IME,
    }
}

---@param IMEs function[]?
---@return table? ime
function M.IME(IMEs)
    set_env()
    IMEs = IMEs or M.IMEs
    for _, IME in ipairs(IMEs) do
        local ok, ime = pcall(IME)
        if ok then
            return ime
        end
    end
end

return M
