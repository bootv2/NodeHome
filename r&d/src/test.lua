--NodeMCU_SmartHome_ŒÂœn‚l„$Œ
--The comment above is mandatory for lua files uploaded through PUT requests!
print("[i]test.lua started!!!")
local mytimer = tmr.create()

-- oo calling
mytimer:register(5000, tmr.ALARM_SINGLE, function (t) print("[i]Test.lua timer expired"); t:unregister() end)
mytimer:start()
