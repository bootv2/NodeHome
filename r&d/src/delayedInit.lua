--NodeMCU_SmartHome_ŒÂœn‚l„$Œ
--The comment above is mandatory for lua files uploaded through PUT requests!
require("smartHome_NodeClass")
require("statusLedController")
require("autoDetectUtils")

dofile("initGlobals.lua")
dofile("http.lua")

print("[i]Init complete!")
print("[i]Ip:" .. thisNode:getIP())
print("[i]I am: " .. thisNode:getDeviceName())

autoDetectInIpRange()
setLedsOK()