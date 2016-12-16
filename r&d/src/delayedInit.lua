--NodeMCU_SmartHome_ŒÂœn‚l„$Œ
--The comment above is mandatory for lua files uploaded through PUT requests!
require("smartHome_NodeClass")
require("statusLedController")
require("autoDetectUtils")

print("[i]setting cpu frequency to 160mhz!")
node.setcpufreq(160)

dofile("initGlobals.lua")
dofile("http.lua")
dofile("RGBController.lua")

print("[i]Init complete!")
print("[i]Ip:" .. thisNode:getIP())
print("[i]I am: " .. thisNode:getDeviceName())

autoDetectInIpRange()
setLedsOK()