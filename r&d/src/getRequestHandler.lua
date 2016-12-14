--NodeMCU_SmartHome_ŒÂœn‚l„$Œ
--The comment above is mandatory for lua files uploaded through PUT requests!
require("GPIOPinControl")
require("FSUtils")
require("autoDetectUtils")
require("stringUtils")
require("RGBController")

function parseGetRequest(payload, conn)
    uri = getUriFromPayload(payload)

    if uri:lower():find("rgb") then
        runRGBString(uri)
        conn:send("OK")
        return    
    else

      if uri:lower():find("pin") then
          restControlPins(uri, conn)
          return
      end

      if uri:lower():find("reset") then
          doReset(conn)
          return
      end

      if uri:lower():find("fs") then
          processFSGetRequest(uri, payload, conn)
          return
      end

      if uri:lower():find("whoareyou") then
          print("whoareyou requested :)")
          whoAmI(conn)
          return
      end

      if uri:lower():find("autodetect") then
          autoDetectInIpRange()
          conn:send("detecting nodes..")
          return
      end

      if uri:lower():find("listnodes") then
          respondWithDetectedNodes(conn)
          return
      end

      if uri == "/" then
          response = "<h1> Hello, NodeMcu. GET request recieved! " .. uri .. "</h1> This is " .. thisNode:getIP() .. " or " .. thisNode:getDeviceName()
          conn:send(response)
          return
      end
    end
    
    response = "<h1>404! page not found" .. uri .. "</h1> This is " .. thisNode:getIP() .. " or " .. thisNode:getDeviceName()
    conn:send(response)
end

function whoAmI(conn)
    conn:send(thisNode:getDeviceName() .. " \n" .. softwareIdString)
end

function doReset(conn)
    conn:send("resetting... This should take no more than 10 seconds")
    conn:close()
    apTimer = tmr.create()

    -- oo calling
    apTimer:register(1000, tmr.ALARM_SINGLE, function (t) node.restart(); t:unregister() end)
    apTimer:start()
end