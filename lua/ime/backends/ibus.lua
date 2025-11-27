---backend for ibus
---@module ime.backends.ibus
---credit: https://github.com/black-desk
local lgi = require "lgi"
local p = require "dbus_proxy"

local IME = require "ime.ime".IME
local fs = require 'vim.fs'

local M = {
    ibus_config_dir = fs.joinpath(os.getenv("HOME"), ".config", "ibus", "bus"),
    IME = {
        ascii_kbd = "xkb:us::eng",
        non_ascii_kbd = "rime",
        proxy = {
            name = "org.freedesktop.IBus",
            interface = "org.freedesktop.IBus",
            path = "/org/freedesktop/IBus",
            flags = lgi.Gio.DBusProxyFlags.DO_NOT_AUTO_START
        }
    }
}

---get ibus config file path
---@param path string?
---@return string
function M.get_ibus_config(path)
    path = path or M.ibus_config_dir
    local paths = fs.find(function(_, _) return true end, { path = path })
    return paths[#paths] or ""
end

---get IBus address
---@param path string?
---@return string
function M.get_ibus_address(path)
    path = path or M.get_ibus_config()
    local f = io.open(path)
    if f == nil then
        return ""
    end
    for line in f:lines() do
        line = line:match("IBUS_ADDRESS=(.*)")
        if line then
            f:close()
            return line
        end
    end
    f:close()
    return ""
end

---@param ime table?
---@return table ime
function M.IME:new(ime)
    ime = ime or {}
    local proxy = M.IME.proxy
    proxy.bus = p.Bus.new(M.get_ibus_address(),
        lgi.Gio.DBusConnectionFlags.AUTHENTICATION_CLIENT + lgi.Gio.DBusConnectionFlags.MESSAGE_BUS_CONNECTION)
    ime.proxy = ime.proxy or p.Proxy:new(proxy)
    ime = IME(ime)
    setmetatable(ime, {
        __index = self
    })
    return ime
end

setmetatable(M.IME, {
    __index = IME,
    __call = M.IME.new
})

---set IME enabled flag
---@param is_enabled boolean
function M.IME:set_enabled(is_enabled)
    M.proxy:SetGlobalEngine(is_enabled and self.non_ascii_kbd or self.ascii_kbd)
end

---get IME enabled flag
---@return boolean
function M.IME:get_enabled()
    return self.proxy:GetGlobalEngine()[3]:sub(1, 4) ~= "xkb:"
end

---get current schema name
---@return string
function M.IME:get_current_schema()
    return self.proxy:GetGlobalEngine()[3]
end

return M
