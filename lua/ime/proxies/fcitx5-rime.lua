local p = require("dbus_proxy")
local proxy = p.Proxy:new(
  {
    bus = p.Bus.SESSION,
    name = "org.fcitx.Fcitx5",
    interface = "org.fcitx.Fcitx.Rime1",
    path = "/rime"
  }
)
