---backend for fcitx5 with rime support
---@module ime.backends.fcitx-rime
local p = require "dbus_proxy"

local IME = require "ime.ime".IME

local M = {
    IME = {
        proxy = {
            bus = p.Bus.SESSION,
            name = "org.fcitx.Fcitx5",
            interface = "org.fcitx.Fcitx.Rime1",
            path = "/rime"
        }
    }
}

---@param ime table?
---@return table ime
function M.IME:new(ime)
    ime = ime or {}
    ime.proxy = ime.proxy or p.Proxy:new(M.IME.proxy)
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
    self.proxy:SetAsciiMode(not is_enabled)
end

---get IME enabled flag
---@return boolean
function M.IME:get_enabled()
    return not self.proxy:IsAsciiMode()
end

---get current schema name
---@return string
function M.IME:get_schema_name()
    return self.proxy:GetCurrentSchema()
end

return M
