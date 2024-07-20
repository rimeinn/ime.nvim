local p = require("dbus_proxy")
local proxy = p.Proxy:new(
  {
    bus = p.Bus.SESSION,
    name = "org.gnome.Shell",
    interface = "org.gnome.Shell",
    path = "/org/gnome/Shell"
  }
)
