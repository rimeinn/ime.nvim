---backend for g3kbswitch. If you use ibus or fcitx5, please use them.
---@module ime.backends.g3kbswitch
---credit: https://github.com/black-desk
local cjson = require "cjson"
local p = require "dbus_proxy"

local IME = require "ime.ime".IME

local M = {
    IME = {
        proxy = {
            bus = p.Bus.SESSION,
            name = "org.gnome.Shell",
            interface = "org.g3kbswitch.G3kbSwitch",
            path = "/org/g3kbswitch/G3kbSwitch"
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
    self.proxy:Set(is_enabled and 1 or 0)
end

---get IME enabled flag
---@return boolean
function M.IME:get_enabled()
    return self.proxy:Get()[2] ~= "0"
end

---get current schema name
---@return string
function M.IME:get_schema_name()
    local id = self.proxy:Get()[2]
    for _, kv in ipairs(cjson.decode(self.proxy:List()[2])) do
        if kv.key == id then
            return kv.value
        end
    end
    return ""
end

return M
