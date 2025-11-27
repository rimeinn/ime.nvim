---a class to send notification.
---<https://specifications.freedesktop.org/notification/1.3/protocol.html>
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

---Sends a notification to the notification server.
---@param app_name string? The optional name of the application sending the
---notification. Can be blank.
---@param replaces_id integer The optional notification ID that this
---notification replaces. The server must atomically (ie with no flicker or
---other visual cues) replace the given notification with this one. This allows
---clients to effectively modify the notification while it's active. A value of
---value of 0 means that this notification won't replace any existing
---notifications.
---@param app_icon string? The optional program icon of the calling application.
---See Icons and Images. Can be an empty string, indicating no icon.
---@param summary string The summary text briefly describing the notification.
---@param body string? The optional detailed body text. Can be empty.
---@param actions string[] Actions are sent over as a list of pairs. Each even
---element in the list (starting at index 0) represents the identifier for the
---action. Each odd element in the list is the localized string that will be
---displayed to the user.
---@param hints table<string, any>? Optional hints that can be passed to the
---server from the client program. Although clients and servers should never
---assume each other supports any specific hints, they can be used to pass along
---information, such as the process PID or window ID, that the server may be
---able to make use of. See Hints. Can be empty.
---@param expire_timeout integer The timeout time in milliseconds since the
---display of the notification at which the notification should automatically
---close. If -1, the notification's expiration time is dependent on the
---notification server's settings, and may vary for the type of notification. If
---0, never expire.
---@return integer id
function M.Notifier:notify(app_name, replaces_id, app_icon, summary, body, actions, hints, expire_timeout)
    return self.proxy:Notify { app_name, replaces_id, app_icon, summary, body, actions, hints, expire_timeout }
end

---Causes a notification to be forcefully closed and removed from the user's
---view. It can be used, for example, in the event that what the notification
---pertains to is no longer relevant, or to cancel a notification with no
---expiration time.
---@param id integer
function M.Notifier:close(id)
    self.proxy:CloseNotification(id)
end

return M
