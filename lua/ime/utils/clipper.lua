---a class to put/get clipboard content
---@module clipper.utils.clipper
local p = require "dbus_proxy"

local M = {
    Clipper = {
        proxy = {
            bus = p.Bus.SESSION,
            name = "org.kde.klipper",
            interface = "org.kde.klipper.klipper",
            path = "/klipper"
        }
    }
}

---@param clipper table?
---@return table clipper
function M.Clipper:new(clipper)
    clipper = clipper or {}
    clipper.proxy = clipper.proxy or p.Proxy:new(M.Clipper.proxy)
    setmetatable(clipper, {
        __index = self
    })
    return clipper
end

setmetatable(M.Clipper, {
    __call = M.Clipper.new
})

---set clipboard content
function M.Notifier:set(...)
    self.proxy:setClipboardContents(...)
end

---set clipboard content
function M.Notifier:get(...)
    self.proxy:getClipboardContents(...)
end

return M
