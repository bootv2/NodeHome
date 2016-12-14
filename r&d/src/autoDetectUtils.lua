--NodeMCU_SmartHome_ŒÂœn‚l„$Œ
--The comment above is mandatory for LUA files uploaded through PUT requests!
require("stringUtils")
require("initGlobals")

--TODO------------use MultiCast IP communication, this is much simpler than current IP detection. + more efficient

ipIterator = startScanningAt
whileIterator = 1
partialIPString = ""
currentIPString = ""
--nodeIterator = 1 because thisNode already exists.
nodeIterator = 1
scanTime = 2000
timerID = 6

function autoDetectInIpRange()
    partialIPString = getPartialIPString()
    createTimer()
end

function createTimer()
    tmr.alarm(timerID,scanTime,tmr.ALARM_SEMI,function()  
        checkIP()
        if ipIterator ~= 255 then
            tmr.start(timerID)
        end
    end)
end

function checkIP()
    currentIPString = partialIPString .. ipIterator

    client=net.createConnection(net.TCP, false) 
    client:on("receive", function(conn, payload) 
      checkIfNode(payload)
      client:close()
    end)
    
    client:connect(myHTTPPort, currentIPString)
    print("connecting to " .. currentIPString .. " on port " .. myHTTPPort)
    
    client:on("connection", function(sck, c)
  -- Wait for connection before sending.
      sck:send("GET /whoareyou ")
    end)
    
    ipIterator = ipIterator + 1
end

function checkIfNode(response)
    print("[d]Connection found!\nChecking if " .. currentIPString .. " is a node running homeNode software!")
    print(response)
    if response:find(softwareIdString) ~= nil then
        node = SNode.create(getNodeNameFromWhoIs(response), currentIPString)
        print("[i]node " .. getNodeNameFromWhoIs(response) .. " found!!")
        nodeList[nodeIterator] = node
        nodeIterator = nodeIterator + 1
    end
end

function respondWithDetectedNodes(conn)
    nodeIter = 1
    response = ""
    while nodeList[nodeIter] ~= nil do
        response = response .. "Node " .. nodeList[nodeIter]:getDeviceName() .. " with IP: " .. nodeList[nodeIter]:getIP()
    end
    conn:send(response)
end