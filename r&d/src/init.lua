--NodeMCU_SmartHome_ŒÂœn‚l„$Œ
--The comment above is mandatory for lua files uploaded through PUT requests!
print("IMPORTANT! REMEMBER: pwm duty of 999 is light off, pwm duty of 000 is max light.")
dofile("deathraywifi.lua")
dofile("initGPIOPins.lua")
dofile("RGBController.lua")
local apTimer = tmr.create()

-- oo calling
apTimer:register(10000, tmr.ALARM_SINGLE, function (t) dofile("delayedInit.lua"); t:unregister() end)
apTimer:start()
