---backend for fcitx5
local p = require "dbus_proxy"

local IME = require "ime.ime".IME

local M = {
    IME = {
        proxy = {
            bus = p.Bus.SESSION,
            name = "org.fcitx.Fcitx5",
            interface = "org.fcitx.Fcitx.Controller1",
            path = "/controller"
        }
    }
}

---@param ime table?
---@return table ime
function M.IME:new(ime)
    ime = ime or {}
    ime.proxy = ime.proxy or p.Proxy:new(M.IME.proxy)
    ime.ime = ime.ime or require 'ime.backends.fcitx-rime'.IME()
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
    if is_enabled then
        self.proxy:Activate()
    else
        self.proxy:Deactivate()
    end
end

---get IME enabled flag
---@return boolean
function M.IME:get_enabled()
    return self.proxy:State() ~= 1
end

---get current schema name
---@return string
function M.IME:get_schema_name()
    local im = self.proxy:CurrentInputMethod()
    if im == 'rime' then
        im = im .. ':' .. self.ime:get_schema_name()
    end
    return im
end

return M
