---backend for gnome-shell < 41. If you use ibus or fcitx5, please use them.
---@module ime.backends.gnome-shell
---credit: https://github.com/lyokha/g3kb-switch
local cjson = require "cjson"
local p = require "dbus_proxy"

local IME = require "ime.ime".IME
local fs = require 'ime.backends'

local M = {
    IME = {
        proxy = {
            bus = p.Bus.SESSION,
            name = "org.gnome.Shell",
            interface = "org.gnome.Shell",
            path = "/org/gnome/Shell"
        }
    }
}

---get file path
---@param name string
---@return string
function M.get_path(name)
    return fs.joinpath(
        fs.dirname(debug.getinfo(1).source:match("@?(.*)")),
        "scripts", name
    )
end

---get file content
---@param name string
---@return string
function M.get_content(name)
    local f = io.open(M.get_path(name))
    if f == nil then
        return ""
    end
    local text = f:read("*a")
    f:close()
    return '"' .. text:gsub("\n", "") .. '"'
end

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
    self.proxy:Eval(string.gsub(M.get_content("set_enabled.js"), "idx",
        tostring(is_enabled and 1 or 0)))
end

---get IME enabled flag
---@return boolean
function M.IME:get_enabled()
    return tonumber(self.proxy:Eval(M.get_content("get_enabled.js"))) ~= 0
end

---get current schema name
---@return string
function M.IME:get_current_schema()
    local id = self.proxy:Eval(M.get_content("get_enabled.js"))
    for _, kv in ipairs(cjson.decode(self.proxy:Eval(M.get_content("get_current_schema.js")))) do
        if kv.key == id then
            return kv.value
        end
    end
    return ""
end

return M
