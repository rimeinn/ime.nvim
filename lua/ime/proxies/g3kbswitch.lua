local p = require("dbus_proxy")
local proxy = p.Proxy:new(
  {
    bus = p.Bus.SESSION,
    name = "org.gnome.Shell",
    interface = "org.g3kbswitch.G3kbSwitch",
    path = "/org/g3kbswitch/G3kbSwitch"
  }
)
