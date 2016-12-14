--NodeMCU_SmartHome_ŒÂœn‚l„$Œ
--The comment above is mandatory for lua files uploaded through PUT requests!
function restControlPins(uri, conn)
    if uri:lower():find("pin1on") ~= nil then
       gpio.write(2, gpio.HIGH)
       conn:send("OK")
       return
    end
    if uri:lower():find("pin1off") ~= nil then
       gpio.write(2, gpio.LOW)
       conn:send("OK")
       return
    end
    if uri:lower():find("pin2on") ~= nil then
       gpio.write(3, gpio.HIGH)
       conn:send("OK")
       return
    end
    if uri:lower():find("pin2off") ~= nil then
       gpio.write(3, gpio.LOW)
       conn:send("OK")
       return
    end
    if uri:lower():find("pin3on") ~= nil then
       gpio.write(5, gpio.HIGH)
       conn:send("OK")
       return
    end
    if uri:lower():find("pin3off") ~= nil then
       gpio.write(5, gpio.LOW)
       conn:send("OK")
       return
    end
end
