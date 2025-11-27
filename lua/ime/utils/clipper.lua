---a class to put/get clipboard content.
---<https://docs.kde.org/stable5/en/plasma-workspace/klipper/index.html>
---miss APIs of dbus. see
---<https://freeaptitude.altervista.org/articles/playing-with-dbus-and-kde-applications-part-1.html>
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
---@param text string
function M.Notifier:set(text)
    self.proxy:setClipboardContents(text)
end

---set clipboard content
---@return string text
function M.Notifier:get()
    return self.proxy:getClipboardContents()
end

return M
