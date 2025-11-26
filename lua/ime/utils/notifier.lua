---a class to send notification
---@module notifier.utils.notifier
local p = require "dbus_proxy"

local M = {
    Notifier = {
        proxy = {
            bus = p.Bus.SESSION,
            name = "org.freedesktop.Notifications",
            interface = "org.freedesktop.Notifications",
            path = "/org/freedesktop/Notifications"
        }
    }
}

---@param notifier table?
---@return table notifier
function M.Notifier:new(notifier)
    notifier = notifier or {}
    notifier.proxy = notifier.proxy or p.Proxy:new(M.Notifier.proxy)
    setmetatable(notifier, {
        __index = self
    })
    return notifier
end

setmetatable(M.Notifier, {
    __call = M.Notifier.new
})

---send notification
function M.Notifier:notify(...)
    self.proxy:Notify(...)
end

---close notification
function M.Notifier:close(...)
    self.proxy:CloseNotification(...)
end

return M
